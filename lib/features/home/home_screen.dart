import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/home/widgets/emergency_card.dart';
import 'package:pulse_health/features/home/widgets/home_header.dart';

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

              const SizedBox(height: 28),

              const EmergencyCard(),

              const SizedBox(height: 32),

              // পরের ধাপে এখানে Quick Access আসবে।

              // পরের ধাপে এখানে Near You আসবে।

              // পরের ধাপে এখানে Your Health আসবে।
            ],
          ),
        ),
      ),
    );
  }
}