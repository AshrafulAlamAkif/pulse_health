import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/home/widgets/blood_requests_section.dart';
import 'package:pulse_health/features/home/widgets/emergency_card.dart';
import 'package:pulse_health/features/home/widgets/home_header.dart';
import 'package:pulse_health/features/home/widgets/home_search_bar.dart';
import 'package:pulse_health/features/home/widgets/location_selector.dart';
import 'package:pulse_health/features/home/widgets/nearby_healthcare_section.dart';
import 'package:pulse_health/features/home/widgets/quick_access_section.dart';
import 'package:pulse_health/features/home/widgets/your_health_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB( 20, 20,20,32),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // Home-এর top section।
              //
              // Header আলাদা widget-এ রেখেছি যাতে
              // HomeScreen-এর code unnecessarily বড় না হয়।
              const HomeHeader(),

              const SizedBox(height: 20),

              const HomeSearchBar(),

              const SizedBox(height: 14),

              const LocationSelector(),

              const SizedBox(height: 24),

              const EmergencyCard(),

              const SizedBox(height: 32),

              const QuickAccessSection(),

              const SizedBox(height: 32),

              const NearbyHealthcareSection(),

              const SizedBox(height: 32),

              const BloodRequestsSection(),
              
              const SizedBox(height: 32),

              const YourHealthSection(),
            ],
          ),
        ),
      ),
    );
  }
}