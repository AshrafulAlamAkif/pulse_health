import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Sign Up-এর UI state এখানে রাখা হচ্ছে.
///
/// এখনো কোনো real API নেই।
/// তাই এই state শুধু registration-এর
/// loading এবং error status manage করবে.
class SignupState {
  const SignupState({
    this.isLoading = false,
    this.errorMessage,
  });

  /// Registration request চলছে কিনা।
  final bool isLoading;

  /// Registration fail হলে error message এখানে থাকবে।
  final String? errorMessage;

  /// Existing state থেকে নতুন state তৈরি করার জন্য
  /// copyWith ব্যবহার করছি।
  SignupState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Sign Up-এর state এবং actions manage করবে।
class SignupNotifier extends Notifier<SignupState> {
  @override
  SignupState build() {
    // Screen প্রথমবার open হলে
    // কোনো loading বা error থাকবে না।
    return const SignupState();
  }

  /// Account create করার method।
  ///
  /// এখনো backend/API নেই।
  /// তাই temporary fake registration করছি।
  Future<bool> signup({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    // Registration শুরু।
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    // Future API request-এর মতো delay।
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // আপাতত সব valid input-কে
    // successful registration হিসেবে ধরছি।
    if (name.isNotEmpty &&
        phone.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
      );

      return true;
    }

    state = state.copyWith(
      isLoading: false,
      errorMessage: 'Unable to create account.',
    );

    return false;
  }
}

/// SignupNotifier-এর provider।
final signupProvider =
    NotifierProvider<SignupNotifier, SignupState>(
  SignupNotifier.new,
);