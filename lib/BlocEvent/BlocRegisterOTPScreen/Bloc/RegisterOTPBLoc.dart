import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/repo.dart';
import 'RegisterOTPEvent.dart';
import 'RegisterOTPState.dart';

class RegisterOTPBloc extends Bloc<RegisterOTPEvent, RegisterOTPState> {
  RegisterOTPBloc() : super(OtpInitialState()) {
    on<RegisterOTPVerificationEvent>(registerOTPVerification);
  }

  FutureOr<void> registerOTPVerification(RegisterOTPVerificationEvent event,
      Emitter<RegisterOTPState> emit) async {
    emit(OtpVerifiedLoadingState());

    try {
      await Repo.getRegisterOtpVerification(event.id, event.otp);
      if (Repo.blocSignupModelClass.status == '1') {
        emit(OtpVerifiedSuccessfullyState(Repo.blocSignupModelClass.msg));
      } else {
        emit(OtpVerifiedFailedState(Repo.blocSignupModelClass.msg));
      }
    } catch (e) {
      emit(OtpVerifiedFailedState('An error occurred.'));
    }
  }
}
