import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/blood/widgets/blood_header.dart';
import 'package:pulse_health/features/blood/widgets/blood_quick_actions.dart';
import 'package:pulse_health/features/blood/widgets/blood_search_card.dart';
import 'package:pulse_health/features/blood/widgets/nearby_blood_requests.dart';

class BloodScreen extends StatelessWidget {
  const BloodScreen({
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
              // Screen header।
              const Text(
                'Blood',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Find blood, help others, save lives.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 28),

              const BloodHeader(),

              const SizedBox(height: 18),

              const BloodSearchCard(),
              
              const SizedBox(height: 18),

              const BloodQuickActions(),

              const SizedBox(height: 18),

              const NearbyBloodRequests(),

              const SizedBox(height: 12),

              // search এবং quick actions যোগ করব।
            ],
          ),
        ),
      ),
    );
  }
}