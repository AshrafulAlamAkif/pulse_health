import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class QuickAccessSection extends StatelessWidget {
  const QuickAccessSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick access',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 16),

        // প্রথম row।
        Row(
          children: [
            Expanded(
              child: _QuickAccessItem(
                icon: Icons.local_hospital_rounded,
                title: 'Hospitals',
                subtitle: 'Nearby care',
                iconBackground: AppColors.primary.withValues(
                  alpha: 0.10,
                ),
                iconColor: AppColors.primary,
                onTap: () {
                  // পরে Nearby Hospitals screen-এ যাব।
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _QuickAccessItem(
                icon: Icons.bloodtype_rounded,
                title: 'Blood',
                subtitle: 'Find donors',
                iconBackground: Colors.red.withValues(
                  alpha: 0.10,
                ),
                iconColor: Colors.red,
                onTap: () {
                  // পরে Blood Management screen-এ যাব।
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // দ্বিতীয় row।
        Row(
          children: [
            Expanded(
              child: _QuickAccessItem(
                icon: Icons.medication_rounded,
                title: 'Medicine',
                subtitle: 'Find pharmacy',
                iconBackground: Colors.orange.withValues(
                  alpha: 0.10,
                ),
                iconColor: Colors.orange,
                onTap: () {
                  // পরে Medicine screen-এ যাব।
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _QuickAccessItem(
                icon: Icons.medical_services_rounded,
                title: 'Doctors',
                subtitle: 'Book appointment',
                iconBackground: Colors.blue.withValues(
                  alpha: 0.10,
                ),
                iconColor: Colors.blue,
                onTap: () {
                  // পরে Doctor & Appointment screen-এ যাব।
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// একটি reusable Quick Access item।
///
/// একই ধরনের চারটি UI আলাদাভাবে লেখার বদলে
/// একটি reusable widget ব্যবহার করছি।
///
/// এতে পরে design পরিবর্তন করতে হলে
/// শুধু এই widget পরিবর্তন করলেই হবে।
class _QuickAccessItem extends StatelessWidget {
  const _QuickAccessItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBackground,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBackground;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),

      // InkWell ব্যবহার করছি যাতে tap করলে
      // user একটি visual feedback পায়।
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,

                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 11),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.dark,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}