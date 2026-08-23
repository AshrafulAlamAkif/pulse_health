import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/login_screen.dart';
import 'package:pulse_health/features/auth/providers/forgot_password_provider.dart';
import 'package:pulse_health/features/auth/widgets/auth_text_field.dart';

class NewPasswordScreen
    extends ConsumerStatefulWidget {
  const NewPasswordScreen({
    super.key,
  });

  @override
  ConsumerState<NewPasswordScreen> createState() {
    return _NewPasswordScreenState();
  }
}

class _NewPasswordScreenState
    extends ConsumerState<NewPasswordScreen> {
  late final TextEditingController
      _passwordController;

  late final TextEditingController
      _confirmPasswordController;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  bool _isPasswordVisible = false;

  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    _passwordController =
        TextEditingController();

    _confirmPasswordController =
        TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible =
          !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible =
          !_isConfirmPasswordVisible;
    });
  }

  Future<void> _updatePassword() async {
    final isValid =
        _formKey.currentState?.validate();

    if (isValid != true) {
      return;
    }

    final notifier = ref.read(
      forgotPasswordProvider.notifier,
    );

    final isSuccessful =
        await notifier.updatePassword(
      password: _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (isSuccessful) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Password updated successfully.',
          ),
        ),
      );

      // Password update হওয়ার পরে
      // Login screen-এ ফিরে যাচ্ছি।
      Navigator.of(context)
          .pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
        (route) => false,
      );

      return;
    }

    final errorMessage = ref.read(
      forgotPasswordProvider,
    ).errorMessage;

    if (errorMessage != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    Icons.lock_outline_rounded,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Create a\nnew password.',
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
                  'Choose a strong password that you haven’t used before.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 40),

                AuthTextField(
                  controller:
                      _passwordController,
                  label: 'New password',
                  hintText:
                      'Enter your new password',
                  prefixIcon:
                      Icons.lock_outline_rounded,
                  obscureText:
                      !_isPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed:
                        _togglePasswordVisibility,
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons
                              .visibility_off_outlined
                          : Icons
                              .visibility_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter a password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                AuthTextField(
                  controller:
                      _confirmPasswordController,
                  label: 'Confirm password',
                  hintText:
                      'Enter your password again',
                  prefixIcon:
                      Icons.lock_outline_rounded,
                  obscureText:
                      !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    onPressed:
                        _toggleConfirmPasswordVisibility,
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons
                              .visibility_off_outlined
                          : Icons
                              .visibility_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please confirm your password';
                    }

                    if (value !=
                        _passwordController.text) {
                      return 'Passwords do not match';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : _updatePassword,

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
                                'Update password',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons
                                    .check_rounded,
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