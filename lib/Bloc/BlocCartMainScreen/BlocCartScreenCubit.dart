import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocCartMainScreen/BlocCartScreenState.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClass/BlocCartModelClass.dart';
import 'package:http/http.dart' as http;

class BlocCartScreenCubit extends Cubit<BlocCartScreenState> {
  BlocCartScreenCubit() : super(BlocCartInitialState()) {
    getCartAllDataAPI();
  }

  BlocCartAddItemModelClass blocCartAddItemModelClass =
      BlocCartAddItemModelClass(status: 0, msg: '', cartTotal: 0, data: []);

  List<bool> isLoadingList = List.generate(25, (index) => false);

  Future<void> getCartAllDataAPI() async {
    try {
      emit(BlocCartLoadingState());
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/getMyCart');
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
        final jsonData = json.decode(response.body);

        blocCartAddItemModelClass =
            BlocCartAddItemModelClass.fromJson(jsonData);
        emit(BlocCartAllItemGetState());
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);

        blocCartAddItemModelClass =
            BlocCartAddItemModelClass.fromJson(jsonData);
        emit(BlocCartAllItemGetFailState());
      } else if (response.statusCode == 500) {
        emit(BlocCartJWTNotFoundState());
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addToCart(String productId) async {
    try {
      emit(BlocCartLoadingState());
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/addToCart');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "productId": productId,
      });
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartAddToCartSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartAddToCartFailState());
      }
    } catch (error) {
      rethrow;
    } finally {
      emit(BlocCartInitial1State());
    }
  }

  Future<void> decreaseProductQuantity(String cartItemId) async {
    try {
      emit(BlocCartItemLoadingState());
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/decreaseProductQuantity');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartDecreaseSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartDecreaseFailState());
      }
    } catch (error) {
      rethrow;
    } finally {
      emit(BlocCartInitial1State());
    }
  }

  Future<void> increaseProductQuantity(String cartItemId) async {
    try {
      emit(BlocCartItemLoadingState());

      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/increaseProductQuantity');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
      });
      var jsonData = json.decode(response.body);
      log(jsonData.toString());
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartIncreaseSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartIncreaseFailState());
      }
    } catch (error) {
      rethrow;
    } finally {
      emit(BlocCartInitial1State());
    }
  }

  Future<void> removeProductFromCart(String cartItemId) async {
    try {
      emit(BlocCartItemRemoveLoadingState());

      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/cart/removeProductFromCart');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
      });
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartRemoveFromCartSuccessfullyState());
      } else {
        final jsonData = json.decode(response.body);
        log(jsonData.toString());
        emit(BlocCartRemoveToCartFailState());
      }
    } catch (error) {
      rethrow;
    }
  }

  updateButtonState(int index) {
    isLoadingList[index] = true;
  }

  updateButtonDisableState(int index) {
    isLoadingList[index] = false;
  }
}
