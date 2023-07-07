abstract class BlocResetPasswordMainEvent {}

class BlocForgetPasswordEvent extends BlocResetPasswordMainEvent {
  String email;
  BlocForgetPasswordEvent(this.email);
}

class BlocForgetPasswordOTPEvent extends BlocResetPasswordMainEvent {
  String userId;
  String otp;
  BlocForgetPasswordOTPEvent(this.userId, this.otp);
}

class BlocForgetResendOTPEvent extends BlocResetPasswordMainEvent {
  String userId;
  BlocForgetResendOTPEvent(this.userId);
}
