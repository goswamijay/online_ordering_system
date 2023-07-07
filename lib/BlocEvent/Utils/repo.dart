import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_ordering_system/BlocEvent/ModelClassBlocEvent/BlocLoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClassBlocEvent/BlocSignUpModel.dart';
import '../ModelClassBlocEvent/BlocOrderPlaceModelClass.dart';
import '../ModelClassBlocEvent/CartMainScreenModel.dart';
import '../ModelClassBlocEvent/BlocFavouriteScreenModel.dart';
import '../ModelClassBlocEvent/BlocProductMainScreenModel.dart';
import 'DataString.dart';

class Repo {
  static BlocLoginModelClass loginModelClass = BlocLoginModelClass(
      status: '',
      msg: '',
      data: BlocLoginData(
          id: '',
          name: '',
          mobileNo: '',
          emailId: '',
          status: '',
          jwtToken: '',
          fcmToken: '',
          createdAt: '',
          updatedAt: '',
          v: ''));

  static BlocSignupModelClass blocSignupModelClass = BlocSignupModelClass(
      status: '',
      msg: '',
      data: BlocSignUpData(
          id: '',
          name: '',
          mobileNo: '',
          emailId: '',
          status: '',
          jwtToken: '',
          fcmToken: '',
          createdAt: '',
          updatedAt: '',
          v: ''));

  static BlocProductAllAPI getProductAllAPI =
      BlocProductAllAPI(status: 1, msg: '', totalProduct: 0, data: []);

  static BlocCartAddItemModelClass blocCartAddItemModelClass =
      BlocCartAddItemModelClass(status: 0, msg: '', cartTotal: 0, data: []);

  static BlocFavoriteAddItemModelClass blocFavoriteAddItemModelClass =
      BlocFavoriteAddItemModelClass(
    status: 0,
    msg: '',
    data: [],
  );

  static BlocPlaceOrderModelClass blocPlaceOrderModelClass =
      BlocPlaceOrderModelClass(status: 0, msg: '', data: []);

  static String emailId = '';
  static String userId = '';
  static int status = 0;
  static int status1 = 0;

  static Future<BlocLoginModelClass> getLoginUser(
      String email, String password) async {
    try {
      var uri = Uri.parse('$baseUrl/user/login');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {"emailId": email, "password": password},
          ));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        loginModelClass = BlocLoginModelClass.fromJson(jsonData);
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('jwtToken', loginModelClass.data.jwtToken);
        await prefs.setString('LoginEmail', loginModelClass.data.emailId);
        await prefs.setString('LoginName', loginModelClass.data.name);
        await prefs.setString('LoginMobileNo', loginModelClass.data.mobileNo);
        await prefs.setBool('LogInBool', true);


        return loginModelClass;
      } else {
        final jsonData = json.decode(response.body);
        loginModelClass = BlocLoginModelClass.fromJson(jsonData);
        return loginModelClass;
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> getSignUpUser(
      String email, String password, String name, String mobileNo) async {
    try {
      var uri = Uri.parse('$baseUrl/user/registerUser');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {
              "name": name,
              "mobileNo": mobileNo,
              "emailId": email,
              "password": password,
            },
          ));
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString('login1', blocSignupModelClass.status);
        await prefs.setString('signUpId', blocSignupModelClass.data.id);
        await prefs.setString('signUpEmail', blocSignupModelClass.data.emailId);
        await prefs.setString('signUpPassword', password);
      } else {
        final jsonData = json.decode(response.body);
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> getRegisterOtpVerification(
      String userId, String otp) async {
    try {
      var uri = Uri.parse('$baseUrl/user/verifyOtpOnRegister');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {"userId": userId, "otp": otp},
          ));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);
      } else {
        final jsonData = json.decode(response.body);
        blocSignupModelClass = BlocSignupModelClass.fromJson(jsonData);
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> productAllAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/product/getAllProduct');
      var response = await http.get(
        uri,
        headers: {
          'Content-type': 'application/json',
          'Authorization': 'Bearer ${jwtToken1.toString()}',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        getProductAllAPI = BlocProductAllAPI.fromJson(jsonData);
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        getProductAllAPI = BlocProductAllAPI.fromJson(jsonData);
      } else if (response.statusCode == 500) {
        Future.delayed(const Duration(seconds: 0), () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
        });
      }

      return response.statusCode; // Return the response code
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> getCartAllDataAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/cart/getMyCart');
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
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);

        blocCartAddItemModelClass =
            BlocCartAddItemModelClass.fromJson(jsonData);
      } else if (response.statusCode == 500) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      }
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> addToCart(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/cart/addToCart');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "productId": productId,
      });
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> decreaseProductQuantity(String cartItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/cart/decreaseProductQuantity');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
      });

      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> increaseProductQuantity(String cartItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/cart/increaseProductQuantity');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
      });
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> removeProductFromCart(String cartItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/cart/removeProductFromCart');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartItemId": cartItemId,
      });

      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> favoriteAllDataAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/watchList/getWatchList');
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
      } else if (response.statusCode == 400) {
        var jsonData = json.decode(response.body);
        blocFavoriteAddItemModelClass =
            BlocFavoriteAddItemModelClass.fromJson(jsonData);
      } else if (response.statusCode == 500) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      }
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> addInFavorite(String productId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/watchList/addToWatchList');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "productId": productId,
      });
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> removeFromFavorite(String watchListItemId) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/watchList/removeFromWatchList');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "wathListItemId": watchListItemId,
      });
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> resetPassword(String password) async {
    final prefs = await SharedPreferences.getInstance();

    final jwtToken1 = prefs.getString('jwtToken'.toString());
    try {
      var uri = Uri.parse('$baseUrl/user/changePassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $jwtToken1",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {"newPass": password, "confirmPass": password},
        ),
      );
      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> getPlaceOrder(String cartId, String cartTotal) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';
      var uri = Uri.parse('$baseUrl/order/placeOrder');
      var response = await http.post(uri, headers: {
        'accept': '*/*',
        'Authorization': 'Bearer $jwtToken1',
      }, body: {
        "cartId": cartId,
        'cartTotal': cartTotal
      });
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> placeOrderAllDataAPI() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final jwtToken1 = prefs.getString('jwtToken'.toString()) ?? '';

      var uri = Uri.parse('$baseUrl/order/getOrderHistory');
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
        blocPlaceOrderModelClass = BlocPlaceOrderModelClass.fromJson(jsonData);
      } else if (response.statusCode == 400) {
        final jsonData = json.decode(response.body);
        blocPlaceOrderModelClass = BlocPlaceOrderModelClass.fromJson(jsonData);
      } else if (response.statusCode == 500) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      }
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }

  static Future<int> forgotPassword(String emailId) async {
    try {
      var uri = Uri.parse('$baseUrl/user/forgotPassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {
            "emailId": emailId,
          },
        ),
      );

      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        emailId = jsonData['data']['emailId'];
        userId = jsonData['data']['_id'];
        status = jsonData['status'];
      } else if (response.statusCode == 400) {
        status = jsonData['status'];
      }
      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> forgetPasswordOTP(String userId, String otp) async {
    try {
      var uri = Uri.parse('$baseUrl/user/verifyOtpOnForgotPassword');
      var response = await http.post(
        uri,
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*"
        },
        body: jsonEncode(
          {"userId": userId, "otp": otp},
        ),
      );
      var jsonData = json.decode(response.body);

      return response.statusCode;
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> resentOTP(String userId) async {
    try {
      var uri = Uri.parse('$baseUrl/user/resendOtp');
      var response = await http.post(uri,
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "*"
          },
          body: jsonEncode(
            {
              "userId": userId,
            },
          ));
      var jsonData = json.decode(response.body);
      return response.statusCode;
    } catch (error) {
      rethrow;
    }
  }
}
