import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Onboarding screen complete হয়েছে কি না,
/// সেই state এই Notifier manage করবে.
///
/// State-এর type হলো bool:
/// false = onboarding এখনো complete হয়নি
/// true  = onboarding complete হয়েছে
class OnboardingNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    // App শুরু হওয়ার সময় local storage থেকে
    // আগের saved onboarding status নিয়ে আসছি।
    //
    // কারণ শুধু memory-তে true রাখলে app বন্ধ করার পর
    // সেই value হারিয়ে যেত।
    final preferences = await SharedPreferences.getInstance();

    // যদি আগে কোনো value save করা না থাকে,
    // তাহলে false ধরে নিচ্ছি।
    return preferences.getBool(
          'has_seen_onboarding',
        ) ??
        false;
  }

  /// User onboarding complete করলে এই method call হবে।
  Future<void> completeOnboarding() async {
    // Local storage-এর instance নিচ্ছি।
    final preferences = await SharedPreferences.getInstance();

    // Onboarding completed হিসেবে save করছি।
    await preferences.setBool(
      'has_seen_onboarding',
      true,
    );

    // Riverpod-এর current state update করছি।
    //
    // AsyncNotifier ব্যবহার করছি বলে state-এর মধ্যে
    // AsyncValue থাকে।
    state = const AsyncData(true);
  }
}

/// OnboardingNotifier-এর provider.
///
/// App-এর যেকোনো জায়গা থেকে এই provider-এর state
/// read/watch করা যাবে।
final onboardingProvider =
    AsyncNotifierProvider<OnboardingNotifier, bool>(
  OnboardingNotifier.new,
);