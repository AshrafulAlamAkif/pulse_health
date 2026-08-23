import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class BloodRequestsSection extends StatelessWidget {
  const BloodRequestsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header।
        Row(
          children: [
            const Expanded(
              child: Text(
                'Blood requests nearby',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                  letterSpacing: -0.3,
                ),
              ),
            ),

            TextButton(
              onPressed: () {
                // পরে সব blood request দেখানোর screen-এ
                // navigate করব।
              },
              child: const Text(
                'See all',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // প্রথম blood request।
        const _BloodRequestCard(
          bloodGroup: 'O+',
          unitsNeeded: '2 units needed',
          hospitalName: 'City Care Hospital',
          distance: '1.8 km',
          urgency: 'Urgent',
        ),

        const SizedBox(height: 12),

        // দ্বিতীয় blood request।
        const _BloodRequestCard(
          bloodGroup: 'A+',
          unitsNeeded: '1 unit needed',
          hospitalName: 'Green Life Medical',
          distance: '2.6 km',
          urgency: 'Today',
        ),
      ],
    );
  }
}

/// একটি reusable blood request card।
///
/// একই ধরনের request অনেকগুলো দেখাতে হতে পারে।
/// তাই আলাদা reusable widget বানাচ্ছি।
class _BloodRequestCard extends StatelessWidget {
  const _BloodRequestCard({
    required this.bloodGroup,
    required this.unitsNeeded,
    required this.hospitalName,
    required this.distance,
    required this.urgency,
  });

  final String bloodGroup;
  final String unitsNeeded;
  final String hospitalName;
  final String distance;
  final String urgency;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),

      child: InkWell(
        borderRadius: BorderRadius.circular(24),

        onTap: () {
          // পরে BloodRequestDetailsScreen-এ
          // navigate করব।
        },

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              // Blood group-এর জন্য বড় visual indicator।
              //
              // Blood-related information যেন দ্রুত চোখে পড়ে,
              // তাই group-টাকে card-এর সবচেয়ে noticeable
              // অংশগুলোর একটি করছি।
              Container(
                width: 62,
                height: 62,

                decoration: BoxDecoration(
                  color: Colors.red.withValues(
                    alpha: 0.08,
                  ),
                  borderRadius: BorderRadius.circular(19),
                ),

                child: Center(
                  child: Text(
                    bloodGroup,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            unitsNeeded,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.dark,
                            ),
                          ),
                        ),

                        _UrgencyBadge(
                          text: urgency,
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    Text(
                      hospitalName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),

                        const SizedBox(width: 3),

                        Text(
                          distance,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

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

/// Request-এর urgency বোঝানোর ছোট badge।
class _UrgencyBadge extends StatelessWidget {
  const _UrgencyBadge({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final bool isUrgent = text == 'Urgent';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: isUrgent
            ? Colors.red.withValues(alpha: 0.10)
            : Colors.orange.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(9),
      ),

      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: isUrgent
              ? Colors.red
              : Colors.orange,
        ),
      ),
    );
  }
}