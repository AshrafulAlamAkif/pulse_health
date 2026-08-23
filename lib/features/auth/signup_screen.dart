import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/login_screen.dart';
import 'package:pulse_health/features/auth/providers/signup_provider.dart';
import 'package:pulse_health/features/auth/widgets/auth_text_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({
    super.key,
  });

  @override
  ConsumerState<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState
    extends ConsumerState<SignupScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password visibility local UI state।
  bool _isPasswordVisible = false;

  // Confirm password visibility local UI state।
  bool _isConfirmPasswordVisible = false;

  // Terms accept করেছে কিনা।
  //
  // এটা শুধুমাত্র এই screen-এর state,
  // তাই এখন Riverpod প্রয়োজন নেই।
  bool _acceptedTerms = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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

  Future<void> _createAccount() async {
    // প্রথমে form validation করছি।
    final isValid = _formKey.currentState?.validate();

    if (isValid != true) {
      return;
    }

    // Terms accept না করলে registration করতে দেব না।
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please accept the Terms & Conditions.',
          ),
        ),
      );
      return;
    }

    // Riverpod notifier access করছি।
    final signupNotifier = ref.read(
      signupProvider.notifier,
    );

    // Registration request করছি।
    final isSuccessful = await signupNotifier.signup(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (isSuccessful) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account created successfully!',
          ),
        ),
      );

      // Registration successful হলে
      // Login screen-এ ফিরে যাচ্ছি।
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        ),
      );

      return;
    }

    final errorMessage = ref.read(
      signupProvider,
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
    // Signup state observe করছি।
    //
    // Loading পরিবর্তন হলে UI rebuild হবে।
    final signupState = ref.watch(
      signupProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24,24,24,32),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Back button।
                IconButton(
                  onPressed: signupState.isLoading
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Create\nyour account.',
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.5,
                    color: AppColors.dark,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Let’s create your personal healthcare space.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 36),

                // Full name।
                AuthTextField(
                  controller: _nameController,
                  label: 'Full name',
                  hintText: 'Enter your full name',
                  prefixIcon:
                      Icons.person_outline_rounded,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your name';
                    }

                    if (value.trim().length < 2) {
                      return 'Please enter a valid name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // Phone number।
                AuthTextField(
                  controller: _phoneController,
                  label: 'Phone number',
                  hintText: '01XXXXXXXXX',
                  prefixIcon:
                      Icons.phone_outlined,
                  keyboardType:
                      TextInputType.phone,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }

                    if (value.trim().length < 11) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // Email।
                AuthTextField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
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

                const SizedBox(height: 18),

                // Password।
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Create a password',
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

                // Confirm password।
                AuthTextField(
                  controller:
                      _confirmPasswordController,
                  label: 'Confirm password',
                  hintText: 'Enter your password again',
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

                const SizedBox(height: 18),

                // Terms & Conditions।
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged:
                          signupState.isLoading
                              ? null
                              : (value) {
                                  setState(() {
                                    _acceptedTerms =
                                        value ?? false;
                                  });
                                },
                      activeColor:
                          AppColors.primary,
                    ),

                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          'I agree to the Terms & Conditions and Privacy Policy.',
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color:
                                AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Create account button।
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed:
                        signupState.isLoading
                            ? null
                            : _createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dark,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.dark.withValues(
                        alpha: 0.6,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: signupState.isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Create account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_rounded,
                              ),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 28),

                // Login option।
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Already have an account? ',
                        ),

                        WidgetSpan(
                          child: GestureDetector(
                            onTap:
                                signupState.isLoading
                                    ? null
                                    : () {
                                        Navigator.of(
                                          context,
                                        ).pushReplacement(
                                          MaterialPageRoute(
                                            builder:
                                                (context) {
                                              return const LoginScreen();
                                            },
                                          ),
                                        );
                                      },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
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