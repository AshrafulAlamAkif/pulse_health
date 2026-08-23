import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  // বর্তমানে কোন page selected।
  final int currentPage;

  // মোট কতগুলো page আছে।
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalPages,
        (index) {
          // Current page হলে indicator বড় হবে।
          final bool isActive = index == currentPage;

          return AnimatedContainer(
            duration: const Duration(
              milliseconds: 250,
            ),
            margin: const EdgeInsets.only(
              right: 6,
            ),
            width: isActive ? 28 : 7,
            height: 7,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}