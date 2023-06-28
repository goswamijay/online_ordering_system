import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/data.dart';

class BlocFirebaseApiCalling  {

  static Future<void> sendPushNotification(String title, String msg) async {
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
      };
      var res = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader:
            'key=$key'
          },
          body: jsonEncode(body));
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }
}