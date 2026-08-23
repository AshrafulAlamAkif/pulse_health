import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class HealthTipCard extends StatelessWidget {
  const HealthTipCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(26),
      ),

      child: Row(
        children: [
          // Tip-এর visual identity।
          //
          // এখন simple icon ব্যবহার করছি।
          // পরে চাইলে daily tip অনুযায়ী illustration
          // বা image ব্যবহার করা যাবে।
          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: Colors.white.withValues(
                alpha: 0.10,
              ),
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.lightbulb_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          // Main health tip content।
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Today’s health tip',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white60,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  'Stay hydrated throughout the day.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Full health tip পড়ার জন্য arrow।
          IconButton(
            onPressed: () {
              // পরে HealthTipsScreen-এ navigate করব।
            },

            icon: const Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: 21,
            ),
          ),
        ],
      ),
    );
  }
}