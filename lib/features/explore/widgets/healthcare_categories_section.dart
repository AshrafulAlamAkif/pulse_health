import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class HealthcareCategoriesSection extends StatelessWidget {
  const HealthcareCategoriesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Healthcare',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _HealthcareCategoryCard(
                icon: Icons.local_hospital_rounded,
                title: 'Hospitals',
                description: 'Find nearby care',
                iconColor: AppColors.primary,
                iconBackground: Color(0xFFEAF7F3),
                onTap: () {
                  // পরে Nearby Hospitals screen-এ যাব।
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _HealthcareCategoryCard(
                icon: Icons.medical_services_rounded,
                title: 'Doctors',
                description: 'Find specialists',
                iconColor: Colors.blue,
                iconBackground: Color(0xFFEAF2FF),
                onTap: () {
                  // পরে Doctors screen-এ যাব।
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _HealthcareCategoryCard(
                icon: Icons.medication_rounded,
                title: 'Pharmacies',
                description: 'Find medicines',
                iconColor: Colors.orange,
                iconBackground: Color(0xFFFFF3E5),
                onTap: () {
                  // পরে Pharmacy screen-এ যাব।
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _HealthcareCategoryCard(
                icon: Icons.biotech_rounded,
                title: 'Diagnostics',
                description: 'Tests & reports',
                iconColor: Colors.purple,
                iconBackground: Color(0xFFF4ECFF),
                onTap: () {
                  // পরে Diagnostic Centers screen-এ যাব।
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Healthcare category-এর reusable card।
///
/// চারটি category-এর জন্য একই layout ব্যবহার করছি,
/// যাতে design consistent থাকে এবং maintenance সহজ হয়।
class _HealthcareCategoryCard extends StatelessWidget {
  const _HealthcareCategoryCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.iconColor,
    required this.iconBackground,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color iconColor;
  final Color iconBackground;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: iconBackground,
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 23,
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

              const SizedBox(height: 18),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                description,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}