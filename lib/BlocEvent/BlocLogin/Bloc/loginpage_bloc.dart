import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Utils/repo.dart';
import 'LoginPageEvent.dart';
import 'LoginPageState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool isVisible = false;

  LoginBloc() : super(LoginUserInitialState()) {
    on<LoginPasswordShowEvent>(passwordShowEvent);
    on<LoginUserLoginEvent>(loginUserEvent);
  }

  FutureOr<void> passwordShowEvent(
      LoginPasswordShowEvent event, Emitter<LoginState> emit) {
    if (event.isVisible) {
      emit(PasswordHideState(false));
    } else {
      emit(PasswordShowState(true));
    }
  }

  Future<void> loginUserEvent(
      LoginUserLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginUserLoadingState());
    try {
      await Repo.getLoginUser(event.email, event.password);
      if (Repo.loginModelClass.status == '1') {
        emit(LoginUserLoginState(Repo.loginModelClass.msg));
      } else {
        emit(LoginUserFailState(Repo.loginModelClass.msg));
      }
    } catch (e) {
      emit(LoginUserFailState('An error occurred.'));
    }
  }
}
