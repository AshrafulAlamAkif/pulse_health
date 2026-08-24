import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class ExploreServicesSection extends StatelessWidget {
  const ExploreServicesSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Emergency section
        const Text(
          'Emergency',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _ServiceCard(
                icon: Icons.emergency_rounded,
                title: 'Emergency Care',
                description: 'Get urgent help',
                iconColor: Colors.red,
                iconBackground: const Color(0xFFFFEAEA),
                onTap: () {
                  // পরে Emergency Care screen হবে।
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _ServiceCard(
                icon: Icons.local_shipping_rounded,
                title: 'Ambulance',
                description: 'Find emergency transport',
                iconColor: Colors.orange,
                iconBackground: const Color(0xFFFFF3E5),
                onTap: () {
                  // পরে Ambulance screen হবে।
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Health services section
        const Text(
          'Health services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.dark,
            letterSpacing: -0.3,
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: _ServiceCard(
                icon: Icons.folder_shared_rounded,
                title: 'Health Records',
                description: 'Manage your records',
                iconColor: AppColors.primary,
                iconBackground: const Color(0xFFEAF7F3),
                onTap: () {
                  // পরে Health Records screen হবে।
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _ServiceCard(
                icon: Icons.lightbulb_rounded,
                title: 'Health Tips',
                description: 'Learn & stay healthy',
                iconColor: Colors.purple,
                iconBackground: const Color(0xFFF4ECFF),
                onTap: () {
                  // পরে Health Tips screen হবে।
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Explore-এর service card-এর reusable widget।
class _ServiceCard extends StatelessWidget {
  const _ServiceCard({
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.3,
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