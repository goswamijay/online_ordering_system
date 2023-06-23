abstract class LoginState {}

class LoginUserInitialState extends LoginState {

}

class LoginUserLoginState extends LoginState {
  final String loginStateMessage;
  LoginUserLoginState(this.loginStateMessage);
}

class LoginUserLogoutState extends LoginState {}

class LoginUserFailState extends LoginState {
  final String loginFailStateError;
  LoginUserFailState(this.loginFailStateError);
}

class LoginUserLoadingState extends LoginState {}

class PasswordShowState extends LoginState{
   bool passwordVisible;
  PasswordShowState(this.passwordVisible);
}

class PasswordHideState extends LoginState{
   bool passwordHide;
  PasswordHideState(this.passwordHide);
}
