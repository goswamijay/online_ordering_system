import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/BlocEvent/ModelClassBlocEvent/BlocFavouriteScreenModel.dart';
import 'package:online_ordering_system/BlocEvent/Utils/repo.dart';

import 'BlocFavouriteScreenEvent.dart';
import 'BlocFavouriteScreenState.dart';

class FavouriteScreenBloc
    extends Bloc<BlocFavoriteScreenEvent, BlocFavoriteScreenState> {
  BlocFavoriteAddItemModelClass blocFavoriteAddItemModelClass =
      BlocFavoriteAddItemModelClass(
    status: 0,
    msg: '',
    data: [],
  );
  FavouriteScreenBloc() : super(BlocFavoriteInitialState()) {
    on<BlocFavouriteGetAllItemEvent>(getAllFavoriteProduct);
    on<BlocFavouriteAddProductEvent>(addItemsInFavorite);
    on<BlocFavouriteRemoveProductEvent>(removeItemsFromFavorite);
    on<BlocFavouriteUpdateAllItemEvent>(getUpdateFavoriteProduct);
  }

  FutureOr<void> getAllFavoriteProduct(BlocFavouriteGetAllItemEvent event,
      Emitter<BlocFavoriteScreenState> emit) async {
    emit(BlocFavoriteLoadingState());
    try {
      int responseCode = await Repo.favoriteAllDataAPI();
      if (responseCode == 200) {
        blocFavoriteAddItemModelClass = Repo.blocFavoriteAddItemModelClass;
        emit(BlocFavoriteAllItemGetState());
      } else if (responseCode == 400) {
        blocFavoriteAddItemModelClass = Repo.blocFavoriteAddItemModelClass;
        emit(BlocFavoriteAllItemGetFailState());
      } else if (responseCode == 500) {
        emit(BlocFavoriteJWTNotFoundState());
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> addItemsInFavorite(BlocFavouriteAddProductEvent event,
      Emitter<BlocFavoriteScreenState> emit) async {
    emit(BlocFavoriteLoadingState());
    try {
      int responseCode = await Repo.addInFavorite(event.productId);
      if (responseCode == 200) {
        emit(BlocFavoriteAddToFavoriteSuccessfullyState());
      } else if (responseCode == 400) {
        emit(BlocFavoriteAddToFavoriteFailState());
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> removeItemsFromFavorite(BlocFavouriteRemoveProductEvent event,
      Emitter<BlocFavoriteScreenState> emit) async {
    emit(BlocFavoriteLoadingState());
    try {
      int responseCode = await Repo.removeFromFavorite(event.watchListItemId);
      if (responseCode == 200) {
        emit(BlocFavoriteRemoveToFavoriteSuccessfullyState());
      } else if (responseCode == 400) {
        emit(BlocFavoriteRemoveToFavoriteFailState());
      }
    } catch (e) {
      rethrow;
    }
  }

  FutureOr<void> getUpdateFavoriteProduct(BlocFavouriteUpdateAllItemEvent event,
      Emitter<BlocFavoriteScreenState> emit) async {
    try {
      int responseCode = await Repo.favoriteAllDataAPI();
      if (responseCode == 200) {
        blocFavoriteAddItemModelClass = Repo.blocFavoriteAddItemModelClass;
        emit(BlocFavoriteAllItemGetState());
      } else if (responseCode == 400) {
        blocFavoriteAddItemModelClass = Repo.blocFavoriteAddItemModelClass;
        emit(BlocFavoriteAllItemGetFailState());
      } else if (responseCode == 500) {
        emit(BlocFavoriteJWTNotFoundState());
      }
    } catch (e) {
      rethrow;
    }
  }
}
