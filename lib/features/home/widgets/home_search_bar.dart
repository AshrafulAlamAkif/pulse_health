import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.textSecondary,
            size: 23,
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Text(
              'Search hospitals, doctors, medicine...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          // পরে এখানে filter/search options যোগ করা যাবে।
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.tune_rounded,
              size: 18,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}