import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class BloodQuickActions extends StatelessWidget {
  const BloodQuickActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick actions',
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
              child: _BloodActionCard(
                icon: Icons.person_search_rounded,
                title: 'Find donor',
                description: 'Find people who can help',
                iconColor: AppColors.primary,
                iconBackground: const Color(0xFFEAF7F3),
                onTap: () {
                  // পরে Find Donor screen হবে।
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _BloodActionCard(
                icon: Icons.volunteer_activism_rounded,
                title: 'Donate blood',
                description: 'Help someone in need',
                iconColor: Colors.red,
                iconBackground: const Color(0xFFFFEAEA),
                onTap: () {
                  // পরে Donate Blood screen হবে।
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Emergency request আলাদা full-width card।
        _CreateRequestCard(
          onTap: () {
            // পরে Create Blood Request screen হবে।
          },
        ),
      ],
    );
  }
}

/// Regular blood action card।
class _BloodActionCard extends StatelessWidget {
  const _BloodActionCard({
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

              const SizedBox(height: 16),

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
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  height: 1.3,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 12),

              const Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
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

/// Emergency blood request-এর জন্য
/// full-width prominent card।
class _CreateRequestCard extends StatelessWidget {
  const _CreateRequestCard({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.dark,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.add_alert_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              const Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need blood urgently?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 4),

                    Text(
                      'Create a blood request and reach nearby donors.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.3,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}