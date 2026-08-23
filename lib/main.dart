import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulse_health/app/theme/app_theme.dart';
import 'package:pulse_health/features/onboarding/onboarding_screen.dart';
import 'package:pulse_health/features/splash/splash_screen.dart';


void main() {
  // ProviderScope হলো Riverpod-এর root container।
  //
  // আমাদের পুরো app-এর Riverpod provider/state
  // এই ProviderScope-এর ভিতরে কাজ করবে।
  //
  // এখন হয়তো এর প্রয়োজন বুঝতে কঠিন লাগতে পারে।
  // পরের দিকে provider ব্যবহার করার সময় বিষয়টা পরিষ্কার হবে।
  runApp(
    const ProviderScope(
      child: PulseApp(),
    ),
  );
}


class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // App-এর নাম।
      title: 'Pulse',

      // আমাদের custom theme।
      theme: AppTheme.lightTheme,

      // আপাতত temporary screen।
      // পরের ধাপে এটাকে SplashScreen দিয়ে replace করব।
      home: const OnboardingScreen(),
    );
  }
}