import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class NearbyBloodRequests extends StatelessWidget {
  const NearbyBloodRequests({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Nearby blood requests',
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
                // পরে সব request দেখানোর screen হবে।
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

        const _BloodRequestCard(
          bloodGroup: 'B+',
          units: '2 units',
          hospital: 'Popular Medical College Hospital',
          distance: '1.4 km',
          urgency: 'Urgent',
        ),

        const SizedBox(height: 12),

        const _BloodRequestCard(
          bloodGroup: 'A-',
          units: '1 unit',
          hospital: 'Green Life Medical',
          distance: '2.8 km',
          urgency: 'Today',
        ),
      ],
    );
  }
}

class _BloodRequestCard extends StatelessWidget {
  const _BloodRequestCard({
    required this.bloodGroup,
    required this.units,
    required this.hospital,
    required this.distance,
    required this.urgency,
  });

  final String bloodGroup;
  final String units;
  final String hospital;
  final String distance;
  final String urgency;

  @override
  Widget build(BuildContext context) {
    final bool isUrgent = urgency == 'Urgent';

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        onTap: () {
          // পরে request details screen হবে।
        },
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Blood group
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(
                        alpha: 0.08,
                      ),
                      borderRadius:
                          BorderRadius.circular(18),
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
                                '$units needed',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: AppColors.dark,
                                ),
                              ),
                            ),

                            Container(
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: isUrgent
                                    ? Colors.red.withValues(
                                        alpha: 0.10,
                                      )
                                    : Colors.orange
                                        .withValues(
                                        alpha: 0.10,
                                      ),
                                borderRadius:
                                    BorderRadius.circular(9),
                              ),
                              child: Text(
                                urgency,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight:
                                      FontWeight.w700,
                                  color: isUrgent
                                      ? Colors.red
                                      : Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 7),

                        Text(
                          hospital,
                          maxLines: 1,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            color:
                                AppColors.textSecondary,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 13,
                              color:
                                  AppColors.textSecondary,
                            ),

                            const SizedBox(width: 3),

                            Text(
                              distance,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors
                                    .textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Respond button।
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () {
                    // পরে donor response flow হবে।
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor:
                        AppColors.primary,
                    side: const BorderSide(
                      color: AppColors.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'View request',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}