import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // User-এর profile image/avatar।
        //
        // এখন আমরা temporary avatar ব্যবহার করছি।
        // পরে API থেকে actual profile image আসবে।
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(
              alpha: 0.12,
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.primary,
            size: 26,
          ),
        ),

        const SizedBox(width: 12),

        // Greeting এবং user's name।
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Good evening',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 3),

              const Text(
                'Akif',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),
            ],
          ),
        ),

        // Notification button।
        //
        // পরে এখানে notification count/badge
        // Riverpod/API থেকে আসতে পারবে।
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            onPressed: () {
              // পরে NotificationScreen-এ navigate করব।
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: AppColors.dark,
            ),
          ),
        ),
      ],
    );
  }
}