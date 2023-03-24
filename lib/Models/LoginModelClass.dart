class LoginModelClass {
  String status;
  String msg;
  LoginData data;

  LoginModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory LoginModelClass.fromJson(dynamic json) {
    return LoginModelClass(
        status: json['status'] as String, msg: json['msg'], data: LoginData.fromJson(json['data']));
  }
}

class LoginData {
  String id;
  String name;
  String mobileNo;
  String emailId;
  String status;
  String jwtToken;
  String fcmToken;
  String createdAt;
  String updatedAt;
  String v;

  LoginData(
      {required this.id,
        required this.name,
        required this.mobileNo,
        required this.emailId,
        required this.status,
        required this.jwtToken,
        required this.fcmToken,
        required this.createdAt,
        required this.updatedAt,
        required this.v});

  factory LoginData.fromJson(dynamic json) {
    return LoginData(
      status: json['status'] as String,
      id: json['_id'] as String,
      name: json['name'] as String,
      mobileNo: json['mobileNo'] as String,
      emailId: json['emailId'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as String,
      jwtToken: json['jwtToken'] as String,
      fcmToken: json['fcmToken'] as String,
    );
  }
}