import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Login-এর বিভিন্ন state represent করার জন্য
/// এই class ব্যবহার করছি.
///
/// এখন আমরা শুধু UI state manage করছি।
/// API integration এখনো করিনি।
class LoginState {
  const LoginState({
    this.isLoading = false,
    this.errorMessage,
  });

  /// Login request চলছে কিনা।
  final bool isLoading;

  /// Login fail হলে এখানে error message থাকবে।
  final String? errorMessage;

  /// পুরোনো state থেকে নতুন state তৈরি করার জন্য
  /// copyWith ব্যবহার করছি।
  ///
  /// এতে পুরো object নতুন করে manually তৈরি করতে হয় না।
  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Login-এর state এবং login-related action
/// এই Notifier manage করবে।
class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    // Login screen প্রথমবার open হলে
    // loading থাকবে না এবং কোনো error থাকবে না।
    return const LoginState();
  }

  /// Login করার method।
  ///
  /// এখনো API connect করা হয়নি।
  /// তাই temporary fake delay ব্যবহার করছি।
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    // Login শুরু হওয়ার আগে loading true করছি।
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    // API-এর মতো একটা ছোট delay তৈরি করছি।
    //
    // পরে এখানে actual API call থাকবে।
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // আপাতত demonstration-এর জন্য
    // একটা simple condition ব্যবহার করছি।
    if (email == 'test@test.com' &&
        password == '123456') {
      // Login successful।
      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
      );

      return true;
    }

    // Login failed।
    state = state.copyWith(
      isLoading: false,
      errorMessage: 'Invalid email or password.',
    );

    return false;
  }
}

/// LoginNotifier-এর provider.
///
/// Login screen এই provider ব্যবহার করে
/// login state observe এবং login action perform করবে।
final loginProvider =
    NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);