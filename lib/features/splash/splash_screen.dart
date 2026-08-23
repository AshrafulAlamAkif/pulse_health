import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/login_screen.dart';
import 'package:pulse_health/features/onboarding/onboarding_screen.dart';
import 'package:pulse_health/features/onboarding/providers/onboarding_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<double> _logoScaleAnimation;

  @override
  void initState() {
    super.initState();

    // AnimationController আমাদের animation-এর সময় এবং
    // progress control করবে।
    //
    // এখন Riverpod এখানে দরকার নেই।
    // কারণ এই animation শুধুমাত্র এই screen-এর local UI state।
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Logo শুরুতে একটু ছোট থাকবে এবং ধীরে ধীরে
    // নিজের normal size-এ আসবে।
    _logoScaleAnimation = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    // Screen open হওয়ার সাথে animation শুরু করছি।
    _animationController.forward();
  }

  @override
  void dispose() {
    // Screen destroy হওয়ার সময় controller dispose করতে হবে।
    //
    // না করলে unnecessary resources থেকে যেতে পারে।
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Riverpod provider-এর state observe করছি।
    //
    // এখানে ref.watch() ব্যবহার করছি কারণ onboarding
    // state-এর পরিবর্তন হলে এই screen-এর decision
    // update হওয়া দরকার।
    // final onboardingState = ref.watch(onboardingProvider);
    // Provider-এর state পরিবর্তন হলে navigation decision নেব।
    //
    // Navigation-এর মতো side effect-এর জন্য
    // ref.listen() ব্যবহার করছি।
    ref.listen<AsyncValue<bool>>(onboardingProvider, (previous, next) {
      next.when(
        loading: () {
          // SharedPreferences থেকে data load হচ্ছে।
          //
          // Loading অবস্থায় navigation করার দরকার নেই।
        },

        error: (error, stackTrace) {
          // কোনো কারণে local storage থেকে data
          // load করতে সমস্যা হলে আপাতত onboarding দেখাব।
          _openOnboarding();
        },

        data: (hasSeenOnboarding) {
          if (hasSeenOnboarding) {
            // User আগে onboarding complete করেছে।
            //
            // Login screen এখনো তৈরি করা হয়নি,
            // তাই আপাতত onboarding-এ পাঠাচ্ছি।
            //
            // Login screen তৈরি হলে এখানে
            // _openLogin() ব্যবহার করব।
            _openLogin();
          } else {
            // User এখনো onboarding complete করেনি।
            //
            // তাই onboarding screen দেখাব।
            _openOnboarding();
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _logoScaleAnimation.value,
                child: child,
              );
            },

            child: const _SplashContent(),
          ),
        ),
      ),
    );
  }
  /// Splash screen থেকে Onboarding screen-এ যাওয়ার method।
  ///
  /// pushReplacement ব্যবহার করছি যাতে user পরে back
  /// চাপলে আবার Splash screen-এ ফিরে না আসে।
  void _openOnboarding() {
    if (!mounted) {
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const OnboardingScreen();
        },
      ),
    );
  }

  void _openLogin() {
  if (!mounted) {
    return;
  }

  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) {
        return const LoginScreen();
      },
    ),
  );
}
  
}

/// Splash screen-এর মূল visual content.
///
/// এই widget আলাদা করেছি যাতে SplashScreen-এর main
/// logic এবং visual design একসাথে জটিল না হয়ে যায়।
class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // আপাতত temporary logo mark ব্যবহার করছি।
        //
        // পরে এখানে আমাদের final custom logo/SVG বসাব।
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.favorite_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // App name।
        const Text(
          'PULSE',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
            color: AppColors.dark,
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        // App tagline।
        const Text(
          'Healthcare, simplified.',
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}


