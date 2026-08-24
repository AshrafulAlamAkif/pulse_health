import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/explore/widgets/explore_search_bar.dart';
import 'package:pulse_health/features/explore/widgets/healthcare_categories_section.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20,24,20,32),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'Explore',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dark,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Find the healthcare services you need.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              const ExploreSearchBar(),

              const SizedBox(height: 32),

              const HealthcareCategoriesSection(),

              const SizedBox(height: 32),

              //
              // পরের ধাপে এখানে Hospitals, Doctors,
              // Pharmacies এবং Diagnostic Centers যোগ করব।
            ],
          ),
        ),
      ),
    );
  }
}