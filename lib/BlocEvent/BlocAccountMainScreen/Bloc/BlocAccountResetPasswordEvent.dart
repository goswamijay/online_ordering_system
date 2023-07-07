abstract class BlocAccountResetPasswordEvent{}

class BlocAccountPasswordChangeEvent extends BlocAccountResetPasswordEvent{
  String password;
  BlocAccountPasswordChangeEvent(this.password);
}