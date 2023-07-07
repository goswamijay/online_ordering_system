abstract class LoginEvent {}

class LoginUserLoginEvent extends LoginEvent {
  final String email;
  final String password;
  LoginUserLoginEvent(this.email, this.password);
}

class LoginUserLogoutEvent extends LoginEvent {}

class LoginPasswordShowEvent extends LoginEvent {
  final bool isVisible;
  LoginPasswordShowEvent(this.isVisible);
}
