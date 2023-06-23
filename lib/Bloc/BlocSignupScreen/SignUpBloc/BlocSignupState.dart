abstract class SignUpState {}

class SignUpUserInitialState extends SignUpState {}

class SignUpUserState extends SignUpState {
  final String loginStateMessage;
  SignUpUserState(this.loginStateMessage);
}

class SignUpUserLogoutState extends SignUpState {}

class SignUpUserFailState extends SignUpState {
  final String loginFailStateError;
  SignUpUserFailState(this.loginFailStateError);
}

class SignUpUserLoadingState extends SignUpState {}

class PasswordShowSignUpState extends SignUpState {
  bool passwordVisible;
  PasswordShowSignUpState(this.passwordVisible);
}

class PasswordHideSignUpState extends SignUpState {
  bool passwordHide;
  PasswordHideSignUpState(this.passwordHide);
}
