import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ModelClassBlocEvent/BlocOrderPlaceModelClass.dart';
import 'BlocOrderPlaceMainEvent.dart';
import 'BlocOrderPlaceMainState.dart';

class BlocOrderPlaceMainBloc
    extends Bloc<BlocOrderPlaceMainEvent, BlocOrderPlaceMainState> {
  BlocPlaceOrderModelClass blocPlaceOrderModelClass =
      BlocPlaceOrderModelClass(status: 0, msg: '', data: []);
  BlocOrderPlaceMainBloc() : super(BlocOrderPlaceInitialState()) {
    on<BlocPlaceOrderAllGetItemEvent>(getAllItemEvent);
    on<BlocPlaceOrderAllUpdateItemEvent>(getAllItemUpdateEvent);
    on<BlocPlaceOrderItemEvent>(placeOrderEvent);
  }

  FutureOr<void> getAllItemEvent(BlocPlaceOrderAllGetItemEvent event,
      Emitter<BlocOrderPlaceMainState> emit) async {
    emit(BlocOrderPlaceGetLoadingState());
    int responseCode = await Repo.placeOrderAllDataAPI();
    if (responseCode == 200) {
      blocPlaceOrderModelClass = Repo.blocPlaceOrderModelClass;
      emit(BlocOrderPlaceGetSuccessfullyState());
    } else if (responseCode == 400) {
      blocPlaceOrderModelClass = Repo.blocPlaceOrderModelClass;
      emit(BlocOrderPlaceGetFailState());
    } else {
      emit(BlocOrderPlaceJWTTokenNotFoundState());
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }

  FutureOr<void> getAllItemUpdateEvent(BlocPlaceOrderAllUpdateItemEvent event,
      Emitter<BlocOrderPlaceMainState> emit) async {
    emit(BlocOrderPlaceGetLoadingState());

    int responseCode = await Repo.placeOrderAllDataAPI();
    if (responseCode == 200) {
      blocPlaceOrderModelClass = Repo.blocPlaceOrderModelClass;
      emit(BlocOrderPlaceAddSuccessfullyState());
    } else if (responseCode == 400) {
      blocPlaceOrderModelClass = Repo.blocPlaceOrderModelClass;
      emit(BlocOrderPlaceGetFailState());
    } else {
      emit(BlocOrderPlaceJWTTokenNotFoundState());
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }

  FutureOr<void> placeOrderEvent(BlocPlaceOrderItemEvent event,
      Emitter<BlocOrderPlaceMainState> emit) async {
    emit(BlocOrderPlaceAddLoadingState());
    int responseCode = await Repo.getPlaceOrder(event.cartId, event.cartTotal);
    if (responseCode == 201) {
      emit(BlocOrderPlaceAddSuccessfullyState());
    } else {
      emit(BlocOrderPlaceGetFailState());
    }
  }
}
