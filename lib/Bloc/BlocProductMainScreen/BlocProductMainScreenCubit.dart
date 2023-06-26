import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_ordering_system/Bloc/BlocProductMainScreen/BlocProductMainScreenState.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClass/BlocProductModelClass.dart';

class BlocProductMainScreenCubit extends Cubit<BlocProductMainScreenState> {
  BlocProductMainScreenCubit() : super(BlocProductMainInitialScreenState()) {
    productAllAPI();
  }
  BlocProductAllAPI getProductAllAPI =
      BlocProductAllAPI(status: 1, msg: '', totalProduct: 0, data: []);

  int photoIndex1 = 0;
  bool searchButton = false;

  List<bool> isLoadingList = List.generate(25, (index) => false);

  productAllAPI() async {
    try {
      emit(BlocProductMainLoadingScreenState());
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      log(jwtToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct');
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

        getProductAllAPI = BlocProductAllAPI.fromJson(jsonData);
        emit(BlocProductMainGetProductScreenState());
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        getProductAllAPI = BlocProductAllAPI.fromJson(jsonData);
        emit(BlocProductMainFailProductScreenState());
      } else if (response.statusCode == 500) {
        Future.delayed(const Duration(seconds: 0), () async {
          emit(BlocProductMainJWTNotFoundProductScreenState());
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        });
      }
    } catch (error) {
      rethrow;
    }
  }

  updateProductAllAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      log(jwtToken1.toString());

      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/product/getAllProduct');
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

        getProductAllAPI = BlocProductAllAPI.fromJson(jsonData);
        emit(BlocProductMainGetProductScreenState());
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        getProductAllAPI = BlocProductAllAPI.fromJson(jsonData);
        emit(BlocProductMainFailProductScreenState());
      } else if (response.statusCode == 500) {
        Future.delayed(const Duration(seconds: 0), () async {
          emit(BlocProductMainJWTNotFoundProductScreenState());
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        });
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

  updateIndex(int index) {
    photoIndex1 = index;
  }

  searchButtonPress() {
    searchButton = true;
  }

  searchUnButtonPress() {
    searchButton = false;
  }
}
