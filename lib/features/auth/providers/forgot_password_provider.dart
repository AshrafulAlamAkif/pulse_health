import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Forgot Password flow-এর state এখানে রাখা হচ্ছে.
///
/// এই state-এর মধ্যে আমরা OTP flow-এর
/// business state রাখছি।
class ForgotPasswordState {
  const ForgotPasswordState({
    this.isLoading = false,
    this.errorMessage,
    this.otpSent = false,
    this.otpVerified = false,
    this.identifier,
  });

  /// API/request চলছে কিনা।
  final bool isLoading;

  /// কোনো error হলে এখানে message থাকবে।
  final String? errorMessage;

  /// OTP successfully পাঠানো হয়েছে কিনা।
  final bool otpSent;

  /// OTP successfully verify হয়েছে কিনা।
  final bool otpVerified;

  /// User যে phone/email দিয়েছে সেটা এখানে রাখছি।
  ///
  /// পরে OTP screen-এ masked phone/email
  /// দেখাতে পারব।
  final String? identifier;

  /// Existing state থেকে নতুন state তৈরি করার জন্য
  /// copyWith ব্যবহার করছি।
  ForgotPasswordState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? otpSent,
    bool? otpVerified,
    String? identifier,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      otpSent: otpSent ?? this.otpSent,
      otpVerified: otpVerified ?? this.otpVerified,
      identifier: identifier ?? this.identifier,
    );
  }
}

/// Forgot Password-এর পুরো business flow
/// এই Notifier manage করবে।
class ForgotPasswordNotifier
    extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() {
    // Screen প্রথমবার open হলে
    // কোনো request বা OTP status থাকবে না।
    return const ForgotPasswordState();
  }

  /// OTP পাঠানোর method।
  ///
  /// এখনো real API/SMS service নেই।
  /// তাই temporary fake request করছি।
  Future<bool> sendOtp({
    required String identifier,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    // Real API request-এর মতো temporary delay।
    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (identifier.trim().isNotEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
        otpSent: true,
        identifier: identifier.trim(),
      );

      return true;
    }

    state = state.copyWith(
      isLoading: false,
      errorMessage:
          'Please enter your phone number or email.',
    );

    return false;
  }

  /// OTP verify করার method।
  ///
  /// এখন demonstration-এর জন্য:
  /// OTP = 123456
  ///
  /// API integration হলে এখানে actual
  /// backend verification থাকবে।
  Future<bool> verifyOtp({
    required String otp,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (otp == '123456') {
      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
        otpVerified: true,
      );

      return true;
    }

    state = state.copyWith(
      isLoading: false,
      errorMessage: 'Invalid OTP. Please try again.',
    );

    return false;
  }

  /// OTP আবার পাঠানোর method।
  Future<bool> resendOtp() async {
    if (state.identifier == null) {
      return false;
    }

    return sendOtp(
      identifier: state.identifier!,
    );
  }

  /// Password update করার method।
  ///
  /// এখনো backend নেই।
  Future<bool> updatePassword({
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (password.length >= 6) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
      );

      return true;
    }

    state = state.copyWith(
      isLoading: false,
      errorMessage:
          'Password must be at least 6 characters.',
    );

    return false;
  }
}

/// Forgot Password provider।
final forgotPasswordProvider =
    NotifierProvider<
        ForgotPasswordNotifier,
        ForgotPasswordState>(
  ForgotPasswordNotifier.new,
);