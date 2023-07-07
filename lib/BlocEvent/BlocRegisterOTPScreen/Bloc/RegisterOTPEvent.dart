abstract class RegisterOTPEvent {}

class RegisterOTPVerificationEvent extends RegisterOTPEvent {
  final String id;
  final String otp;

  RegisterOTPVerificationEvent(this.id, this.otp);
}
