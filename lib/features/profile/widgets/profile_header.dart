import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          // এখন temporary avatar।
          //
          // পরে user-এর actual profile image
          // API থেকে আসবে।
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(
                alpha: 0.10,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Akif',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'akif@example.com',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              // পরে Edit Profile screen খুলবে।
            },
            icon: const Icon(
              Icons.edit_rounded,
              size: 20,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }
}