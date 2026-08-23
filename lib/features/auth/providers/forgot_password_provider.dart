import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Forgot Password-এর UI state এখানে রাখা হচ্ছে.
///
/// এখনো real API নেই।
/// তাই আপাতত শুধু loading এবং error state manage করছি.
class ForgotPasswordState {
  const ForgotPasswordState({
    this.isLoading = false,
    this.errorMessage,
  });

  /// Password reset request চলছে কিনা।
  final bool isLoading;

  /// কোনো error হলে এখানে message থাকবে।
  final String? errorMessage;

  /// Existing state থেকে নতুন state তৈরি করার জন্য
  /// copyWith ব্যবহার করছি।
  ForgotPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Forgot Password-এর state এবং action manage করবে।
class ForgotPasswordNotifier
    extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() {
    // Screen প্রথমবার open হলে
    // কোনো loading বা error থাকবে না।
    return const ForgotPasswordState();
  }

  /// Password reset request পাঠানোর method।
  ///
  /// এখনো real backend/API নেই।
  /// তাই temporary fake request করছি।
  Future<bool> sendResetRequest({
    required String email,
  }) async {
    // Request শুরু হয়েছে।
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    // API request-এর মতো temporary delay।
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // আপাতত valid email থাকলেই success ধরছি।
    if (email.trim().isNotEmpty &&
        email.contains('@')) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
      );

      return true;
    }

    state = state.copyWith(
      isLoading: false,
      errorMessage:
          'Unable to send password reset request.',
    );

    return false;
  }
}

/// ForgotPasswordNotifier-এর provider।
final forgotPasswordProvider =
    NotifierProvider<
        ForgotPasswordNotifier,
        ForgotPasswordState>(
  ForgotPasswordNotifier.new,
);