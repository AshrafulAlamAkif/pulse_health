import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class YourHealthSection extends StatelessWidget {
  const YourHealthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title।
        const Text(
          'Your health',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 16),

        // Health information-এর cards horizontal layout-এ রাখছি।
        //
        // কারণ appointment, medicine, blood—এই তিনটি
        // information একই গুরুত্বের হলেও একসাথে বড়
        // জায়গা নেওয়ার প্রয়োজন নেই।
        SizedBox(
          height: 132,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [
              _HealthSummaryCard(
                width: 190,
                icon: Icons.calendar_month_rounded,
                title: 'Appointment',
                value: 'Tomorrow',
                description: 'Dr. Rahman • 10:30 AM',
                iconColor: AppColors.primary,
                iconBackground: Color(0xFFEAF7F3),
              ),

              SizedBox(width: 12),

              _HealthSummaryCard(
                width: 190,
                icon: Icons.medication_rounded,
                title: 'Medicine',
                value: '2 reminders',
                description: 'Next dose • 8:00 PM',
                iconColor: Colors.orange,
                iconBackground: Color(0xFFFFF3E5),
              ),

              SizedBox(width: 12),

              _HealthSummaryCard(
                width: 190,
                icon: Icons.bloodtype_rounded,
                title: 'Blood',
                value: 'O Positive',
                description: 'Your blood group',
                iconColor: Colors.red,
                iconBackground: Color(0xFFFFEBEB),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Health summary-এর reusable card।
///
/// একই design-এর মধ্যে বিভিন্ন health information
/// দেখানোর জন্য reusable widget ব্যবহার করছি।
class _HealthSummaryCard extends StatelessWidget {
  const _HealthSummaryCard({
    required this.width,
    required this.icon,
    required this.title,
    required this.value,
    required this.description,
    required this.iconColor,
    required this.iconBackground,
  });

  final double width;
  final IconData icon;
  final String title;
  final String value;
  final String description;
  final Color iconColor;
  final Color iconBackground;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),

      child: InkWell(
        borderRadius: BorderRadius.circular(24),

        onTap: () {
          // পরে প্রতিটি card-এর নিজস্ব details screen-এ
          // navigate করব।
        },

        child: SizedBox(
          width: width,

          child: Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,

                      decoration: BoxDecoration(
                        color: iconBackground,
                        borderRadius:
                            BorderRadius.circular(13),
                      ),

                      child: Icon(
                        icon,
                        color: iconColor,
                        size: 20,
                      ),
                    ),

                    const Spacer(),

                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),

                const Spacer(),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
