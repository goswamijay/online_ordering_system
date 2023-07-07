abstract class SignUpEvent {}

class SignUpButtonPressEvent extends SignUpEvent {
  final String email;
  final String password;
  final String phoneNo;
  final String name;
  SignUpButtonPressEvent(this.email, this.password, this.phoneNo, this.name);
}

class SignUpPasswordShowEvent extends SignUpEvent {
  final bool isVisible;
  SignUpPasswordShowEvent(this.isVisible);
}
