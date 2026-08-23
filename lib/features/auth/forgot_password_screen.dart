import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/login_screen.dart';
import 'package:pulse_health/features/auth/providers/forgot_password_provider.dart';
import 'package:pulse_health/features/auth/widgets/auth_text_field.dart';

class ForgotPasswordScreen
    extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  ConsumerState<ForgotPasswordScreen> createState() {
    return _ForgotPasswordScreenState();
  }
}

class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
  // Email input control করার জন্য controller।
  late final TextEditingController _emailController;

  // Form validation-এর জন্য।
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    // Screen destroy হলে controller dispose করছি।
    _emailController.dispose();

    super.dispose();
  }

  /// Password reset request পাঠানোর method।
  Future<void> _sendResetRequest() async {
    // প্রথমে form validation করছি।
    final isValid =
        _formKey.currentState?.validate();

    if (isValid != true) {
      return;
    }

    // Riverpod notifier access করছি।
    //
    // read() ব্যবহার করছি কারণ এখানে
    // provider-এর method call করতে চাই।
    final notifier = ref.read(
      forgotPasswordProvider.notifier,
    );

    // Password reset request পাঠাচ্ছি।
    final isSuccessful =
        await notifier.sendResetRequest(
      email: _emailController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (isSuccessful) {
      // এখনো real OTP/API নেই।
      //
      // তাই আপাতত success message দেখাচ্ছি।
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Password reset instructions sent.',
          ),
        ),
      );

      return;
    }

    // Provider থেকে error message নিচ্ছি।
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

  @override
  Widget build(BuildContext context) {
    // Forgot Password state observe করছি।
    //
    // Loading state পরিবর্তন হলে UI rebuild হবে।
    final state = ref.watch(
      forgotPasswordProvider,
    );

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
                // Back button।
                IconButton(
                  onPressed: state.isLoading
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),

                const SizedBox(height: 40),

                // Decorative icon।
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
                    Icons.lock_reset_rounded,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Forgot\nyour password?',
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.5,
                    color: AppColors.dark,
                  ),
                ),

                const SizedBox(height: 16),

                const Text(
                  'No worries. Enter your email and we’ll help you get back into your account.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 40),

                // Email field।
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Enter your registered email',
                  prefixIcon:
                      Icons.email_outlined,
                  keyboardType:
                      TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                // Send reset button।
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    // Request চলাকালীন button disable।
                    onPressed: state.isLoading
                        ? null
                        : _sendResetRequest,

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
                                'Send reset link',
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

                const SizedBox(height: 32),

                // Back to login।
                Center(
                  child: TextButton.icon(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            Navigator.of(
                              context,
                            ).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginScreen();
                                },
                              ),
                            );
                          },
                    icon: const Icon(
                      Icons
                          .arrow_back_rounded,
                      size: 18,
                    ),
                    label: const Text(
                      'Back to login',
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