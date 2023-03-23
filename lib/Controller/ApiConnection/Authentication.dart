import 'dart:convert';
import 'package:http/http.dart' as http;


class Authentication{

  static Future<void> loginUser(String email, String password,String name,String mobileNo) async{
    try{
      var uri = Uri.parse(
          'https://shopping-app-backend-t4ay.onrender.com/user/registerUser');
      var response = await http.post(
        uri,
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
            "password": password
          },
        ),

      );

      print(response.statusCode == 201);
     // print(response.statusCode == 400);

      if(response.statusCode == 201){
        Map<String, dynamic> newResponses = jsonDecode(response.body);

        int mobileNo = newResponses['data']['mobileNo'];
        String status = newResponses['status'];
        String msg = newResponses['data']['msg'];
        String name = newResponses['data']['name'];
        String id = newResponses['data']['_id'];
        String emailId = newResponses['data']['emailId'];
        String jwtToken = newResponses['data']['jwtToken'];
        String fcmToken = newResponses['data']['fcmToken'];
        String createdAt = newResponses['data']['createdAt'];
        String updatedAt = newResponses['data']['updatedAt'];
        String v = newResponses['data']['__v'];

        List<dynamic> signUpData = [mobileNo,status];

        print(mobileNo);



        print(newResponses['data']['mobileNo']);
        return newResponses['msg']['status'];
      }
    }catch(e){
      print(e.toString());
    }
  }

}