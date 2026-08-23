import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class EmergencyCard extends StatelessWidget {
  const EmergencyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        // Emergency action-এর গুরুত্ব বোঝানোর জন্য
        // primary color-এর একটি soft variation ব্যবহার করছি।
        color: AppColors.primary,

        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row-তে emergency label এবং icon রাখছি।
          Row(
            children: [
              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.16,
                  ),
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.emergency_rounded,
                  color: Colors.white,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                'NEED HELP NOW?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          const Text(
            'Emergency Care',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 7),

          const Text(
            'Find the nearest emergency hospital or get help quickly.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.45,
            ),
          ),

          const SizedBox(height: 20),

          // Emergency action button।
          //
          // এখন শুধু UI তৈরি করছি।
          // পরে এখানে emergency flow / nearby hospital
          // screen-এ navigation যোগ করব।
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // পরে EmergencyScreen-এ navigate করব।
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                elevation: 0,

                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),

              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get emergency help',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(width: 8),

                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}