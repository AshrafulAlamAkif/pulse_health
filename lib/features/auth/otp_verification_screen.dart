import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/new_password_screen.dart';
import 'package:pulse_health/features/auth/providers/forgot_password_provider.dart';

class OtpVerificationScreen
    extends ConsumerStatefulWidget {
  const OtpVerificationScreen({
    super.key,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() {
    return _OtpVerificationScreenState();
  }
}

class _OtpVerificationScreenState
    extends ConsumerState<OtpVerificationScreen> {
  // OTP input controller।
  late final TextEditingController _otpController;

  // Timer local UI state।
  //
  // এটা শুধু এই screen-এর timer,
  // তাই Riverpod-এর প্রয়োজন নেই।
  Timer? _timer;

  int _remainingSeconds = 60;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _otpController = TextEditingController();

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();

    _otpController.dispose();

    super.dispose();
  }

  /// 60-second countdown শুরু করছি।
  void _startTimer() {
    _timer?.cancel();

    setState(() {
      _remainingSeconds = 60;
    });

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (_remainingSeconds <= 1) {
          timer.cancel();

          setState(() {
            _remainingSeconds = 0;
          });

          return;
        }

        setState(() {
          _remainingSeconds--;
        });
      },
    );
  }

  /// OTP verify করার method।
  Future<void> _verifyOtp() async {
    final isValid =
        _formKey.currentState?.validate();

    if (isValid != true) {
      return;
    }

    final notifier = ref.read(
      forgotPasswordProvider.notifier,
    );

    final isSuccessful =
        await notifier.verifyOtp(
      otp: _otpController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (isSuccessful) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return const NewPasswordScreen();
          },
        ),
      );

      return;
    }

    final errorMessage = ref.read(
      forgotPasswordProvider,
    ).errorMessage;

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  /// OTP resend করার method।
  Future<void> _resendOtp() async {
    if (_remainingSeconds > 0) {
      return;
    }

    final notifier = ref.read(
      forgotPasswordProvider.notifier,
    );

    final isSuccessful =
        await notifier.resendOtp();

    if (!mounted) {
      return;
    }

    if (isSuccessful) {
      _startTimer();

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'A new OTP has been sent.',
          ),
        ),
      );
    }
  }

  String _formatTime() {
    final seconds =
        _remainingSeconds.toString().padLeft(
              2,
              '0',
            );

    return '00:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(
      forgotPasswordProvider,
    );

    final identifier =
        state.identifier ?? 'your account';

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              24,
              24,
              32,
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          Navigator.of(context)
                              .pop();
                        },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),

                const SizedBox(height: 40),

                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primary
                        .withValues(alpha: 0.12),
                    borderRadius:
                        BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.sms_outlined,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Verify\nyour number.',
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.5,
                    color: AppColors.dark,
                  ),
                ),

                const SizedBox(height: 16),

                Text(
                  'We sent a 6-digit verification code to $identifier.',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 40),

                // OTP input।
                TextFormField(
                  controller: _otpController,
                  keyboardType:
                      TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,

                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 12,
                    color: AppColors.dark,
                  ),

                  decoration:
                      InputDecoration(
                    counterText: '',
                    hintText: '------',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      letterSpacing: 12,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                      borderSide:
                          const BorderSide(
                        color: AppColors.primary,
                        width: 1.5,
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter the OTP';
                    }

                    if (value.length != 6) {
                      return 'OTP must be 6 digits';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Timer / Resend section।
                Center(
                  child: _remainingSeconds > 0
                      ? Text(
                          'Resend code in ${_formatTime()}',
                          style: const TextStyle(
                            fontSize: 14,
                            color:
                                AppColors.textSecondary,
                          ),
                        )
                      : TextButton(
                          onPressed:
                              state.isLoading
                                  ? null
                                  : _resendOtp,
                          child: const Text(
                            'Resend OTP',
                          ),
                        ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : _verifyOtp,

                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          AppColors.dark,
                      foregroundColor:
                          Colors.white,
                      disabledBackgroundColor:
                          AppColors.dark.withValues(
                        alpha: 0.6,
                      ),
                      elevation: 0,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),

                    child: state.isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                            children: [
                              Text(
                                'Verify OTP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons
                                    .arrow_forward_rounded,
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}