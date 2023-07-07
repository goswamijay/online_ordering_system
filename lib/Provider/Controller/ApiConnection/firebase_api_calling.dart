import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApiCalling extends ChangeNotifier {

   Future<void> sendPushNotification(String title, String msg) async {
    final prefs = await SharedPreferences.getInstance();
    String? fcmToken = prefs.getString('fcmToken');
    try {
      final body = {
        "to": fcmToken,
        "notification": {
          "title": title, //our name should be send
          "body": msg,
          "android_channel_id": "OnlineOrderingsystem"
        },
        // "data": {
        //   "some_data": "User ID: ${me.id}",
        // },
      };

      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
                'key=AAAArYNwUlk:APA91bEV2jU3D3JkNOcBOtxt3-M4vBQrs2-HErH_0CQhKnDrB3xPxTjrU44jN7TIjC1Ia4E-6ztggsu6MpI2PjEq757mNly3PPI04FHX_QCqRoh6j_Y8TTR4TyLVJyKDxnZOsWoVjWau'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}
