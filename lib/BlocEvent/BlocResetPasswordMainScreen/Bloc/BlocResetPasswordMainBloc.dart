import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Utils/repo.dart';
import 'BlocResetPasswordMainEvent.dart';
import 'BlocResetPasswordMainState.dart';

class BlocResetPasswordMainBloc
    extends Bloc<BlocResetPasswordMainEvent, BlocResetPasswordMainState> {
  String emailId = '';
  String userId = '';
  int status = 0;
  int status1 = 0;
  BlocResetPasswordMainBloc() : super(BlocResetPasswordEmailInitialState()) {
    on<BlocForgetPasswordEvent>(blocForgetPasswordEvent);
    on<BlocForgetPasswordOTPEvent>(blocForgetPasswordEvent1);
    on<BlocForgetResendOTPEvent>(blocForgetPasswordOtp);
  }

  FutureOr<void> blocForgetPasswordEvent(BlocForgetPasswordEvent event,
      Emitter<BlocResetPasswordMainState> emit) async {
    emit(BlocResetPasswordEmailLoadingState());
    int responseCode = await Repo.forgotPassword(event.email);
    if (responseCode == 200) {
      emailId = Repo.emailId;
      userId = Repo.userId;
      status = Repo.status;
      emit(BlocResetPasswordEmailSentSuccessfullyState());
    } else if (responseCode == 400) {
      emit(BlocResetPasswordEmailSentFailState());
    }
  }

  FutureOr<void> blocForgetPasswordEvent1(BlocForgetPasswordOTPEvent event,
      Emitter<BlocResetPasswordMainState> emit) async {
    emit(BlocResetPasswordLoadingState());
    int responseCode = await Repo.forgetPasswordOTP(event.userId, event.otp);
    if (responseCode == 200) {
      status1 = Repo.status1;
      emit(BlocResetPasswordVerifiedSuccessfullyState());
    } else if (responseCode == 400) {
      emit(BlocResetPasswordVerifiedFailState());
    }
  }

  FutureOr<void> blocForgetPasswordOtp(BlocForgetResendOTPEvent event,
      Emitter<BlocResetPasswordMainState> emit) async {
    emit(BlocResetPasswordResendOTPLoadingState());
    int responseCode = await Repo.resentOTP(event.userId);
    if (responseCode == 200) {
      emit(BlocResetPasswordResendOTPSuccessfullyState());
    } else if (responseCode == 400) {
      emit(BlocResetPasswordResendOTPFailState());
    }
  }
}
