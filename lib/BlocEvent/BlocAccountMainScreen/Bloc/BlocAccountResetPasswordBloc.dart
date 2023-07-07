import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';
import 'BlocAccountResetPasswordEvent.dart';
import 'BlocAccountResetPasswordState.dart';

class BlocAccountResetPasswordBloc
    extends Bloc<BlocAccountResetPasswordEvent, BlocAccountResetPasswordState> {
  BlocAccountResetPasswordBloc()
      : super(BlocAccountResetPasswordInitialState()) {
    on<BlocAccountPasswordChangeEvent>(changePassword);
  }

  FutureOr<void> changePassword(BlocAccountPasswordChangeEvent event,
      Emitter<BlocAccountResetPasswordState> emit) async {
    emit(BlocAccountResetPasswordLoadingState());
    int responseCode = await Repo.resetPassword(event.password);
    if (responseCode == 200) {
      emit(BlocAccountResetPasswordChangeSuccessfullyState());
    } else {
      emit(BlocAccountResetPasswordChangeFailState());
    }
  }
}
