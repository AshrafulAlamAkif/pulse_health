import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/auth/login_screen.dart';
import 'package:pulse_health/features/onboarding/providers/onboarding_provider.dart';
import 'package:pulse_health/features/onboarding/widgets/onboarding_indicator.dart';
import 'package:pulse_health/features/onboarding/widgets/onboarding_page.dart';

/// Onboarding screen.
///
/// এখানে Riverpod ব্যবহার করছি কারণ onboarding complete/skip
/// হওয়ার information অন্য screen-এরও প্রয়োজন হবে।
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    super.key,
  });

  @override
  ConsumerState<OnboardingScreen> createState() {
    return _OnboardingScreenState();
  }
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  // PageView-এর page control করার জন্য controller ব্যবহার করছি।
  late final PageController _pageController;

  // বর্তমানে কোন page দেখা যাচ্ছে সেটা রাখছি।
  //
  // এটা শুধুমাত্র onboarding screen-এর UI state।
  // তাই এখানে Riverpod ব্যবহার করছি না।
  int _currentPage = 0;

  // আমাদের মোট onboarding page।
  static const int _totalPages = 3;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    // Screen destroy হলে controller-ও destroy করতে হবে।
    _pageController.dispose();
    super.dispose();
  }

  /// Onboarding complete করার method।
  Future<void> _completeOnboarding() async {
    // Riverpod-এর মাধ্যমে onboarding state update করছি।
    //
    // completeOnboarding() method:
    // 1. SharedPreferences-এ true save করবে
    // 2. Riverpod state-কে true করবে
    await ref
        .read(onboardingProvider.notifier)
        .completeOnboarding();

    if (!mounted) {
      return;
    }

    // Onboarding শেষ হওয়ার পরে Login screen-এ যাচ্ছি।
    //
    // pushReplacement ব্যবহার করছি যাতে user Back চাপলে
    // আবার Onboarding screen-এ ফিরে না যায়।
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      ),
    );
  }


  /// Next button-এর কাজ।
  void _goToNextPage() {
    // যদি শেষ page-এ না থাকি,
    // তাহলে পরের page-এ যাব।
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(
          milliseconds: 350,
        ),
        curve: Curves.easeInOut,
      );
      return;
    }
    // শেষ page হলে onboarding complete করছি।
    _completeOnboarding();
  }


  /// User Skip চাপলে onboarding complete হিসেবে
  /// mark করে Login screen-এ পাঠাচ্ছি।
  Future<void> _skipOnboarding() async {
    // Skip করলেও user আর onboarding দেখতে চায় না।
    //
    // তাই এটাকেও completed হিসেবে save করছি।
    await ref
        .read(onboardingProvider.notifier)
        .completeOnboarding();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Column(
          children: [
            // Skip button।
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 12,
                  right: 20,
                ),
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text(
                    'Skip',
                  ),
                ),
              ),
            ),

            // Main onboarding pages।
            Expanded(
              child: PageView(
                controller: _pageController,

                // User finger দিয়ে page change করলে
                // এই callback execute হবে।
                onPageChanged: (pageIndex) {
                  setState(() {
                    // UI-কে জানাচ্ছি যে current page পরিবর্তন হয়েছে।
                    _currentPage = pageIndex;
                  });
                },

                children: const [
                  OnboardingPage(
                    pageNumber: 1,
                    icon: Icons.location_on_rounded,
                    title: 'Find healthcare around you.',
                    description:
                        'Discover hospitals, doctors, pharmacies and diagnostic centers near your location.',
                  ),

                  OnboardingPage(
                    pageNumber: 2,
                    icon: Icons.bloodtype_rounded,
                    title: 'Find blood when it matters.',
                    description:
                        'Connect with nearby blood donors and create emergency blood requests when needed.',
                  ),

                  OnboardingPage(
                    pageNumber: 3,
                    icon: Icons.favorite_rounded,
                    title: 'Stay ready. Stay healthy.',
                    description:
                        'Keep your appointments, medicines, health records and emergency information in one place.',
                  ),
                ],
              ),
            ),

            // Bottom controls।
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24,
                8,
                24,
                28,
              ),
              child: Row(
                children: [
                  // Page indicator।
                  Expanded(
                    child: OnboardingIndicator(
                      currentPage: _currentPage,
                      totalPages: _totalPages,
                    ),
                  ),

                  // Next / Get Started button।
                  GestureDetector(
                    onTap: _goToNextPage,
                    child: Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: AppColors.dark,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        _currentPage == _totalPages - 1
                            ? Icons.arrow_forward_rounded
                            : Icons.arrow_forward_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}