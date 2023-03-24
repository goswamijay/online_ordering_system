class SignupModelClass {
  String status;
  String msg;
  SignUpData data;

  SignupModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory SignupModelClass.fromJson(dynamic json) {
    return SignupModelClass(
        status: json['status'] as String, msg: json['msg'], data: SignUpData.fromJson(json['data']));
  }
}

class SignUpData {
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

  SignUpData(
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

  factory SignUpData.fromJson(dynamic json) {
    return SignUpData(
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

/*
class OtpVerification{
  String userId;
  String otp;
  OtpVerification({required this.userId,required this.otp});

  factory SignUpData.fromJson(dynamic json) {
    return SignUpData(
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
}*/
