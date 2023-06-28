import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocFavoriteMainScreen/BlocFavoriteScreenState.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClass/BlocFavoriteModelClass.dart';
import 'package:http/http.dart' as http;

class BlocFavoriteScreenCubit extends Cubit<BlocFavoriteScreenState> {
  BlocFavoriteScreenCubit() : super(BlocFavoriteInitialState()) {
    favoriteAllDataAPI();
  }

  BlocFavoriteAddItemModelClass blocFavoriteAddItemModelClass =
      BlocFavoriteAddItemModelClass(
    status: 0,
    msg: '',
    data: [],
  );
  Future<void> favoriteAllDataAPI() async {
    try {
      emit(BlocFavoriteLoadingState());
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      log(jwtToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/watchList/getWatchList');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization': ' Bearer ${jwtToken1.toString()}',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        blocFavoriteAddItemModelClass =
            BlocFavoriteAddItemModelClass.fromJson(jsonData);
        emit(BlocFavoriteAllItemGetState());
      } else if (response.statusCode == 400) {
        var jsonData = json.decode(response.body);
        blocFavoriteAddItemModelClass =
            BlocFavoriteAddItemModelClass.fromJson(jsonData);
        emit(BlocFavoriteAllItemGetFailState());
      } else if (response.statusCode == 500) {
        emit(BlocFavoriteJWTNotFoundState());
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      }
      emit(BlocFavoriteInitial1State());

    } catch (error) {
      rethrow;
    }
  }

  Future<void> getAddInFavorite(String productId) async {
    try {
      emit(BlocFavoriteLoadingState());
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/watchList/addToWatchList');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "productId": productId,
      });
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocFavoriteAddToFavoriteSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData);
        emit(BlocFavoriteAddToFavoriteFailState());
      }
      emit(BlocFavoriteInitial1State());

    } catch (error) {
      rethrow;
    }
  }

  Future<void> getRemoveFavorite(String watchListItemId) async {
    try {
      emit(BlocFavoriteLoadingState());
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/watchList/removeFromWatchList');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "wathListItemId": watchListItemId,
      });
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocFavoriteRemoveToFavoriteSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocFavoriteRemoveToFavoriteFailState());
      }
      emit(BlocFavoriteInitial1State());

    } catch (error) {
      rethrow;
    }
  }
}
