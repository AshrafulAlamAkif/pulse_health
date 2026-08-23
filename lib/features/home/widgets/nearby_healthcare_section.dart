import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';

class NearbyHealthcareSection extends StatelessWidget {
  const NearbyHealthcareSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title এবং "See all" একই row-তে রাখছি।
        //
        // পরে "See all" চাপলে complete nearby healthcare
        // listing screen-এ navigate করব।
        Row(
          children: [
            const Expanded(
              child: Text(
                'Near you',
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
                // পরে NearbyHealthcareScreen-এ navigate করব।
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

        // এখন শুধু UI তৈরির জন্য temporary data ব্যবহার করছি।
        //
        // পরে এই data API থেকে আসবে।
        const _NearbyHealthcareCard(
          name: 'City Care Hospital',
          type: 'Hospital & Emergency Care',
          distance: '1.2 km',
          rating: '4.8',
          isOpen: true,
        ),

        const SizedBox(height: 12),

        const _NearbyHealthcareCard(
          name: 'MediPlus Pharmacy',
          type: 'Pharmacy',
          distance: '0.8 km',
          rating: '4.6',
          isOpen: true,
        ),
      ],
    );
  }
}

/// Nearby healthcare-এর একটি reusable card।
///
/// Hospital, clinic, pharmacy বা diagnostic center—
/// একই ধরনের layout ব্যবহার করতে পারবে।
///
/// পরে API থেকে data এলেও এই widget-এর design
/// পরিবর্তন করার প্রয়োজন হবে না।
class _NearbyHealthcareCard extends StatelessWidget {
  const _NearbyHealthcareCard({
    required this.name,
    required this.type,
    required this.distance,
    required this.rating,
    required this.isOpen,
  });

  final String name;
  final String type;
  final String distance;
  final String rating;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),

      child: InkWell(
        borderRadius: BorderRadius.circular(24),

        onTap: () {
          // পরে এই healthcare provider-এর
          // details screen-এ navigate করব।
        },

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              // Healthcare place-এর জন্য
              // এখন temporary icon ব্যবহার করছি।
              //
              // পরে API থেকে actual image এলে
              // এখানে network image বসানো যাবে।
              Container(
                width: 64,
                height: 64,

                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(
                    alpha: 0.08,
                  ),
                  borderRadius: BorderRadius.circular(19),
                ),

                child: const Icon(
                  Icons.local_hospital_rounded,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
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
                      type,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 9),

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

                        const SizedBox(width: 10),

                        const Icon(
                          Icons.star_rounded,
                          size: 14,
                          color: Colors.orange,
                        ),

                        const SizedBox(width: 3),

                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Open/closed status দেখাচ্ছি।
              //
              // পরে API থেকে actual business status
              // আসবে।
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: isOpen
                      ? Colors.green.withValues(
                          alpha: 0.10,
                        )
                      : Colors.red.withValues(
                          alpha: 0.10,
                        ),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Text(
                  isOpen ? 'Open' : 'Closed',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: isOpen
                        ? Colors.green
                        : Colors.red,
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