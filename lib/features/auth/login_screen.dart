import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/widgets/auth_text_field.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  // Email/phone এবং password-এর text access করার জন্য
  // controller ব্যবহার করছি।
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  // Login form-এর validation control করার জন্য।
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  // Password এখন visible কিনা সেটা local UI state।
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // Screen destroy হওয়ার সময় controller dispose করছি।
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      // Password visible থাকলে hide হবে,
      // আর hidden থাকলে visible হবে।
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _login() {
    // প্রথমে form validation করছি।
    final isValid = _formKey.currentState?.validate();

    if (isValid != true) {
      return;
    }

    // এখনো backend connect করা হয়নি।
    //
    // পরবর্তীতে এখানে Firebase Authentication/API
    // integration হবে।
    debugPrint(
      'Login: ${_emailController.text}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              24,
              32,
              24,
              24,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Small brand mark।
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  'Welcome\nback.',
                  style: TextStyle(
                    fontSize: 44,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.5,
                    color: AppColors.dark,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Your healthcare journey continues here.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 40),

                // Email/phone field।
                AuthTextField(
                  controller: _emailController,
                  label: 'Email or phone',
                  hintText: 'Enter your email or phone',
                  prefixIcon: Icons.person_outline_rounded,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter your email or phone';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 18),

                // Password field।
                AuthTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline_rounded,

                  // Password visible না হলে text hide থাকবে।
                  obscureText: !_isPasswordVisible,

                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),

                  validator: (value) {
                    if (value == null ||
                        value.isEmpty) {
                      return 'Please enter your password';
                    }

                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 12),

                // Forgot password।
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // পরবর্তীতে Forgot Password screen।
                    },
                    child: const Text(
                      'Forgot password?',
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Login button।
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dark,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue',
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

                // Divider।
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                      ),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Divider(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Google button।
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // পরে Google authentication
                      // integration হবে।
                    },
                    icon: const Icon(
                      Icons.g_mobiledata_rounded,
                      size: 28,
                    ),
                    label: const Text(
                      'Continue with Google',
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.dark,
                      side: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Register option।
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      children: [
                        const TextSpan(
                          text: "Don't have an account? ",
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              // পরে Register screen-এ যাবে।
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight:
                                    FontWeight.w700,
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