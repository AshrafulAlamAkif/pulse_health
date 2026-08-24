import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/profile/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            24,
            20,
            32,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 24),

              const ProfileHeader(),

              const SizedBox(height: 28),

              const Text(
                'Health',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),

              const SizedBox(height: 14),

              _ProfileMenuCard(
                icon: Icons.calendar_month_rounded,
                title: 'Appointments',
                subtitle:
                    'View and manage your appointments',
                onTap: () {
                  // পরে Appointments screen হবে।
                },
              ),

              const SizedBox(height: 10),

              _ProfileMenuCard(
                icon: Icons.folder_shared_rounded,
                title: 'Health Records',
                subtitle:
                    'Access your medical records',
                onTap: () {
                  // পরে Health Records screen হবে।
                },
              ),

              const SizedBox(height: 10),

              _ProfileMenuCard(
                icon: Icons.medication_rounded,
                title: 'Medicines',
                subtitle:
                    'Manage your medicines and reminders',
                onTap: () {
                  // পরে Medicines screen হবে।
                },
              ),

              const SizedBox(height: 28),

              const Text(
                'Emergency',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),

              const SizedBox(height: 14),

              _ProfileMenuCard(
                icon: Icons.contact_phone_rounded,
                title: 'Emergency Contact',
                subtitle:
                    'Manage your emergency contact',
                onTap: () {
                  // পরে Emergency Contact screen হবে।
                },
              ),

              const SizedBox(height: 28),

              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                ),
              ),

              const SizedBox(height: 14),

              _ProfileMenuCard(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                subtitle:
                    'Manage notification preferences',
                onTap: () {
                  // পরে Notifications settings হবে।
                },
              ),

              const SizedBox(height: 10),

              _ProfileMenuCard(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: 'English',
                onTap: () {
                  // পরে language selector হবে।
                },
              ),

              const SizedBox(height: 10),

              _ProfileMenuCard(
                icon: Icons.lock_outline_rounded,
                title: 'Privacy',
                subtitle:
                    'Manage your privacy settings',
                onTap: () {
                  // পরে Privacy screen হবে।
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// Profile-এর প্রতিটি menu item-এর জন্য
/// reusable widget।
class _ProfileMenuCard extends StatelessWidget {
  const _ProfileMenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  size: 21,
                  color: AppColors.dark,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
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
                        fontSize: 10,
                        color:
                            AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}