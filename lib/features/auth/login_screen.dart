import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/forgot_password_screen.dart';
import 'package:pulse_health/features/auth/providers/login_provider.dart';
import 'package:pulse_health/features/auth/signup_screen.dart';
import 'package:pulse_health/features/auth/widgets/auth_text_field.dart';

// 1️⃣ নতুন provider তৈরি করো
// 2️⃣ Login Screen-এ Riverpod connect করব
class LoginScreen extends ConsumerStatefulWidget  {
  const LoginScreen({
    super.key,
  });

  @override
  ConsumerState<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  // Email/phone এবং password-এর text access করার জন্য
  // controller ব্যবহার করছি।
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  // Login form-এর validation control করার জন্য।
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Password এখন visible কিনা সেটা local UI state।
  //
  // এটা শুধু এই screen-এর দরকার, তাই Riverpod ব্যবহার করছি না।
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

  /// Password show/hide করার method।
  void _togglePasswordVisibility() {
    setState(() {
      // Password visible থাকলে hide হবে,
      // আর hidden থাকলে visible হবে।
      _isPasswordVisible = !_isPasswordVisible;
    });
  }


  /// 3️⃣ _login() Login করার method update করব।
  Future<void> _login() async {
  // প্রথমে form validation করছি।
  final isValid = _formKey.currentState?.validate();

  if (isValid != true) {
    return;
  }

  // Riverpod provider-এর notifier access করছি।
  //
  // এখানে read() ব্যবহার করছি কারণ আমরা
  // login() method call করতে চাই।
  final loginNotifier = ref.read(
    loginProvider.notifier,
  );

  // Login request শুরু করছি।
  //
  // এখনো real API নেই।
  // তাই login_provider.dart-এর fake login ব্যবহার হচ্ছে।
  final isSuccessful = await loginNotifier.login(
    email: _emailController.text.trim(),
    password: _passwordController.text,
  );

  if (!mounted) {
    return;
  }

  if (isSuccessful) {
    // আপাতত শুধু message দেখাচ্ছি।
    //
    // পরে এখানে HomeScreen-এ navigate করব।
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Login successful!',
        ),
      ),
    );
    return;
  }

  //Login failed হলে provider থেকে error message নিচ্ছি। 
  final errorMessage = ref.read(
    loginProvider,
  ).errorMessage;

  if(errorMessage != null){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        errorMessage,
        ),
      )
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // 4️⃣ Login button-এর loading state
    // এখন button-এ আমরা Riverpod state observe করব।
    // Login-এর current state observe করছি।
    //
    // isLoading পরিবর্তন হলে UI rebuild হবে।
    final loginState = ref.watch(
      loginProvider,
    );

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24,32,24,24),

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

                  // Password show/hide করার button।
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
                    onPressed: loginState.isLoading
                        ? null
                        :() {
                      // পরবর্তীতে Forgot Password screen।
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return const ForgotPasswordScreen();
                        }
                        )
                      );
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
                    // Login চলাকালীন button disable থাকবে।
                    //
                    // এতে user বারবার login request
                    // পাঠাতে পারবে না।
                    onPressed: loginState.isLoading
                      ? null
                      :_login,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dark,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.dark.withValues(
                        alpha: 0.6,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),

                    child: loginState.isLoading? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ):const Row(
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
                    onPressed: loginState.isLoading ? null 
                    : () {
                      // পরে Google authentication integration হবে।
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
                            onTap: loginState.isLoading 
                                ? null : () {
                                  // পরে Register screen-এ যাবে।
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context){
                                      return const SignupScreen();
                                    })
                                  );
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