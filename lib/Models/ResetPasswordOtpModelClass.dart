class ResetPasswordOtpModelClass {
  String status;
  String msg;
  ResetPasswordOtpModelData data;

  ResetPasswordOtpModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ResetPasswordOtpModelClass.fromJson(dynamic json) {
    return ResetPasswordOtpModelClass(
        status: json['status'] as String, msg: json['msg'], data: ResetPasswordOtpModelData.fromJson(json['data']));
  }
}

class ResetPasswordOtpModelData {
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

  ResetPasswordOtpModelData(
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

  factory ResetPasswordOtpModelData.fromJson(dynamic json) {
    return ResetPasswordOtpModelData(
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

class ResetPasswordOtpModelClass1 {
  String status;
  String msg;

  ResetPasswordOtpModelClass1({
    required this.status,
    required this.msg,
  });

  factory ResetPasswordOtpModelClass1.fromJson(dynamic json) {
    return ResetPasswordOtpModelClass1(
        status: json['status'] as String, msg: json['msg']);
  }
}