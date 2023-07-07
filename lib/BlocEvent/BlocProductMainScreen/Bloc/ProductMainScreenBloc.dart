import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';

import '../../ModelClassBlocEvent/BlocProductMainScreenModel.dart';
import 'ProductMainScreenEvent.dart';
import 'ProductMainScreenState.dart';

class ProductMainScreenBloc
    extends Bloc<ProductMainScreenEvent, BlocProductMainScreenState> {
  BlocProductAllAPI getProductAllAPI =
      BlocProductAllAPI(status: 1, msg: '', totalProduct: 0, data: []);
  int totalProduct = 0;
  bool isSearchButtonPress = false;
  int imageList = 0;

  List<bool> isLoadingList = List.generate(25, (index) => false);

  ProductMainScreenBloc() : super(BlocProductMainInitialScreenState()) {
    on<ProductAllItemShowingEvent>(productAllAPIData);
    on<ProductAllItemUpdateEvent>(productDataUpdate);
    on<ProductUpdateButtonEvent>(productUpdateButtonEvent);
    on<ProductUpdateButton2Event>(productUpdateButton2Event);
    on<ProductTotalItemEvent>(totalItemShowing);
    on<ProductSearchButtonPressEvent>(searchButtonPress);
    on<ProductImageListEvent>(imageListMethod);
  }

  FutureOr<void> productAllAPIData(ProductAllItemShowingEvent event,
      Emitter<BlocProductMainScreenState> emit) async {
    emit(BlocProductMainLoadingScreenState());
    try {
      int responseCode = await Repo.productAllAPI();
      if (responseCode == 200) {
        getProductAllAPI = Repo.getProductAllAPI;
        emit(BlocProductMainGetProductScreenState(getProductAllAPI));
      } else if (responseCode == 400) {
        getProductAllAPI = Repo.getProductAllAPI;
        emit(BlocProductMainFailProductScreenState());
      } else if (responseCode == 500) {
        emit(BlocProductMainJWTNotFoundProductScreenState());
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> productDataUpdate(ProductAllItemUpdateEvent event,
      Emitter<BlocProductMainScreenState> emit) async {
    int responseCode = await Repo.productAllAPI();
    if (responseCode == 200) {
      getProductAllAPI = Repo.getProductAllAPI;
      emit(BlocProductMainScreenUpdateState(getProductAllAPI));
    } else if (responseCode == 400) {
      getProductAllAPI = Repo.getProductAllAPI;
      emit(BlocProductMainFailProductScreenState());
    } else if (responseCode == 500) {
      emit(BlocProductMainJWTNotFoundProductScreenState());
    }
  }

  FutureOr<void> productUpdateButtonEvent(ProductUpdateButtonEvent event,
      Emitter<BlocProductMainScreenState> emit) {
    isLoadingList[event.index] = true;
    emit(BlocProductLoadingState());
  }

  FutureOr<void> productUpdateButton2Event(ProductUpdateButton2Event event,
      Emitter<BlocProductMainScreenState> emit) {
    isLoadingList[event.index] = false;
    emit(BlocProductLoadingState());
  }

  FutureOr<void> totalItemShowing(
      ProductTotalItemEvent event, Emitter<BlocProductMainScreenState> emit) {
    totalProduct = Repo.getProductAllAPI.totalProduct;
    emit(BlocProductTotalItemState());
  }

  FutureOr<void> searchButtonPress(ProductSearchButtonPressEvent event,
      Emitter<BlocProductMainScreenState> emit) {
    if (event.isSearchButtonPress) {
      isSearchButtonPress = true;
    } else {
      isSearchButtonPress = false;
    }
  }

  FutureOr<void> imageListMethod(
      ProductImageListEvent event, Emitter<BlocProductMainScreenState> emit) {
    imageList = event.imageList;
    emit(BlocImageListChangeState());
  }
}
