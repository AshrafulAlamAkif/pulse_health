import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class ExploreSearchBar extends StatelessWidget {
  const ExploreSearchBar({
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
              'Search healthcare services...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const Icon(
            Icons.tune_rounded,
            color: AppColors.dark,
            size: 20,
          ),
        ],
      ),
    );
  }
}