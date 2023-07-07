import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/ModelClassBlocEvent/CartMainScreenModel.dart';
import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CartMainScreenEvent.dart';
import 'CartMainScreenState.dart';

class CartMainScreenBloc
    extends Bloc<BlocCartMainScreenEvent, BlocCartScreenState> {
  List<bool> isLoadingList = List.generate(25, (index) => false);

  BlocCartAddItemModelClass blocCartAddItemModelClass =
      BlocCartAddItemModelClass(status: 0, msg: '', cartTotal: 0, data: []);
  CartMainScreenBloc() : super(BlocCartInitialState()) {
    on<BlocCartAllDataGetEvent>(blocCartAllDataGetEvent);
    on<BlocCartAllDataUpdateEvent>(bloCartAllDataUpdateEvent);
    on<BlocCartIncreaseProductQuantityEvent>(
        blocCartIncreaseProductQuantityEvent);
    on<BlocCartDecreaseProductQuantityEvent>(
        blocCartDecreaseProductQuantityEvent);
    on<BlocCartAddToCartEvent>(blocCartAddToCartEvent);
    on<BlocCartRemoveFromCartEvent>(blocCartRemoveFromCartEvent);
    on<BlocCartUpdateButtonEvent>(blocCartUpdateButtonEvent);
    on<BlocCartUpdateButton2Event>(blocCartUpdateButton2Event);
  }

  FutureOr<void> blocCartAllDataGetEvent(
      BlocCartAllDataGetEvent event, Emitter<BlocCartScreenState> emit) async {
    emit(BlocCartLoadingState());
    int responseCode = await Repo.getCartAllDataAPI();
    if (responseCode == 200) {
      blocCartAddItemModelClass = Repo.blocCartAddItemModelClass;
      emit(BlocCartAllItemGetState());
    } else if (responseCode == 400) {
      blocCartAddItemModelClass = Repo.blocCartAddItemModelClass;
      emit(BlocCartAllItemGetFailState());
    } else {
      emit(BlocCartJWTNotFoundState());
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }

  FutureOr<void> bloCartAllDataUpdateEvent(BlocCartAllDataUpdateEvent event,
      Emitter<BlocCartScreenState> emit) async {
    int responseCode = await Repo.getCartAllDataAPI();
    if (responseCode == 200) {
      blocCartAddItemModelClass = Repo.blocCartAddItemModelClass;
      emit(BlocCartAllItemGetState());
    } else if (responseCode == 400) {
      blocCartAddItemModelClass = Repo.blocCartAddItemModelClass;
      emit(BlocCartAllItemGetFailState());
    } else {
      emit(BlocCartJWTNotFoundState());
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }

  FutureOr<void> blocCartIncreaseProductQuantityEvent(
      BlocCartIncreaseProductQuantityEvent event,
      Emitter<BlocCartScreenState> emit) async {
    emit(BlocCartItemLoadingState());
    int responseCode = await Repo.increaseProductQuantity(event.cartItemId);
    if (responseCode == 200) {
      emit(BlocCartIncreaseSuccessfullyState());
    } else {
      emit(BlocCartIncreaseFailState());
    }
  }

  FutureOr<void> blocCartDecreaseProductQuantityEvent(
      BlocCartDecreaseProductQuantityEvent event,
      Emitter<BlocCartScreenState> emit) async {
    emit(BlocCartItemLoadingState());

    int responseCode = await Repo.decreaseProductQuantity(event.cartItemId);
    if (responseCode == 200) {
      emit(BlocCartDecreaseSuccessfullyState());
    } else {
      emit(BlocCartDecreaseFailState());
    }
  }

  FutureOr<void> blocCartAddToCartEvent(
      BlocCartAddToCartEvent event, Emitter<BlocCartScreenState> emit) async {
    emit(BlocCartItemLoadingState());

    int responseCode = await Repo.addToCart(event.productId);
    if (responseCode == 201) {
      emit(BlocCartAddToCartSuccessfullyState());
    } else {
      emit(BlocCartAddToCartFailState());
    }
  }

  FutureOr<void> blocCartRemoveFromCartEvent(BlocCartRemoveFromCartEvent event,
      Emitter<BlocCartScreenState> emit) async {
    emit(BlocCartItemLoadingState());
    int responseCode = await Repo.removeProductFromCart(event.cartItemId);
    if (responseCode == 200) {
      emit(BlocCartRemoveFromCartSuccessfullyState());
    } else {
      emit(BlocCartRemoveToCartFailState());
    }
  }

  FutureOr<void> blocCartUpdateButtonEvent(
      BlocCartUpdateButtonEvent event, Emitter<BlocCartScreenState> emit) {
    isLoadingList[event.index] = true;
    emit(BlocCartItemRemoveLoadingState());
  }

  FutureOr<void> blocCartUpdateButton2Event(
      BlocCartUpdateButton2Event event, Emitter<BlocCartScreenState> emit) {
    isLoadingList[event.index] = false;
    emit(BlocCartItemRemoveLoadingState());
  }
}
