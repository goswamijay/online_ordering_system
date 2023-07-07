class ResetPasswordOtpModelClass {
  int status;
  String msg;
  ResetPasswordOtpModelData data;

  ResetPasswordOtpModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory ResetPasswordOtpModelClass.fromJson(dynamic json) {
    return ResetPasswordOtpModelClass(
        status: json['status']  ?? 0, msg: json['msg'] ?? '', data: ResetPasswordOtpModelData.fromJson(json['data']));
  }
}

class ResetPasswordOtpModelData {
  String id;
  String name;
  String mobileNo;
  String emailId;
  int status;
  String jwtToken;
  String fcmToken;
  String createdAt;
  String updatedAt;
  int v;

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
      status: json['status'] ?? 0,
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      emailId: json['emailId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
      jwtToken: json['jwtToken'] ?? '',
      fcmToken: json['fcmToken'] ?? '',
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