import 'dart:async';

import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';

import 'signUpEvent.dart';
import 'signUpState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpUserInitialState()) {
    on<SignUpButtonPressEvent>(signInUser);
    on<SignUpPasswordShowEvent>(signInPasswordShow);
  }

  FutureOr<void> signInUser(
      SignUpButtonPressEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpUserLoadingState());
    try {
      await Repo.getSignUpUser(
          event.email, event.password, event.name, event.phoneNo);
      if (Repo.blocSignupModelClass.status == '1') {
        emit(SignUpUserState(Repo.blocSignupModelClass.msg));
      } else {
        emit(SignUpUserFailState(Repo.blocSignupModelClass.msg));
      }
    } catch (e) {
      emit(SignUpUserFailState('An error occurred.'));
    }
  }

  FutureOr<void> signInPasswordShow(
      SignUpPasswordShowEvent event, Emitter<SignUpState> emit) {
    if (event.isVisible) {
      emit(PasswordHideSignUpState(false));
    } else {
      emit(PasswordShowSignUpState(true));
    }
  }
}
