import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';


class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.pageNumber,
  });

  // প্রতিটি onboarding page-এর জন্য আলাদা icon থাকবে।
  final IconData icon;

  // বড় heading।
  final String title;

  // Heading-এর নিচের ছোট description।
  final String description;

  // কোন page দেখানো হচ্ছে সেটা visual design-এর
  // জন্য ব্যবহার করছি।
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),

          // Screen-এর বড় visual area।
          Expanded(
            flex: 6,
            child: _OnboardingVisual(
              icon: icon,
              pageNumber: pageNumber,
            ),
          ),

          const SizedBox(
            height: 32,
          ),

          // Text area।
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 36,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                    letterSpacing: -1.2,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


/// প্রতিটি onboarding page-এর বড় visual অংশ।
///
/// এখন আমরা actual image ব্যবহার করছি না।
///
/// প্রথমে shape + icon দিয়ে visual language তৈরি করছি।
/// পরে চাইলে এখানে custom illustration/SVG বসানো যাবে।
class _OnboardingVisual extends StatelessWidget {
  const _OnboardingVisual({
    required this.icon,
    required this.pageNumber,
  });

  final IconData icon;
  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // বড় organic background shape।
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(48),
          ),
        ),

        // Decorative circle।
        Positioned(
          top: 32,
          right: 28,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Main icon container।
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 56,
          ),
        ),

        // ছোট page number।
        Positioned(
          bottom: 24,
          left: 24,
          child: Text(
            '0$pageNumber',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.primary.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}