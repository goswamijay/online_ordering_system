abstract class RegisterOTPState {}

class OtpInitialState extends RegisterOTPState {}

class OtpVerifiedSuccessfullyState extends RegisterOTPState {
  final String message;
  OtpVerifiedSuccessfullyState(this.message);
}

class OtpVerifiedFailedState extends RegisterOTPState {
  final String message;
  OtpVerifiedFailedState(this.message);
}

class OtpLoadingState extends RegisterOTPState {}

class OtpVerifiedLoadingState extends RegisterOTPState {}
