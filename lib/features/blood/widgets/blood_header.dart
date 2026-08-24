import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class BloodHeader extends StatelessWidget {
  const BloodHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          // Blood group visual।
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.10,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(
              child: Text(
                'O+',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'My blood group',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white60,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'O Positive',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Keep this updated for emergencies.',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              // পরে blood group edit করা যাবে।
            },
            icon: const Icon(
              Icons.edit_rounded,
              color: Colors.white,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }
}