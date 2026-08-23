import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),

      onTap: () {
        // পরে location selection screen / bottom sheet
        // এখানে open করব।
      },

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
        ),

        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(
                  alpha: 0.10,
                ),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.location_on_rounded,
                size: 18,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 10),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your location',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: 2),

                  Text(
                    'Kaliganj, Dhaka',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dark,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}