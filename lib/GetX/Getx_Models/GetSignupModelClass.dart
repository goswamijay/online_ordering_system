class GetSignupModelClass {
  String status;
  String msg;
  GetSignUpData data;

  GetSignupModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory GetSignupModelClass.fromJson(dynamic json) {
    return GetSignupModelClass(
      status: json['status'].toString() ?? '',
      msg: json['msg'],
      data: json['data'] != null
          ? GetSignUpData.fromJson(json['data'])
          : GetSignUpData(
              id: '',
              name: '',
              mobileNo: '',
              emailId: '',
              status: '',
              jwtToken: '',
              fcmToken: '',
              createdAt: '',
              updatedAt: '',
              v: ''),
    );
  }
}

class GetSignUpData {
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

  GetSignUpData(
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

  factory GetSignUpData.fromJson(dynamic json) {
    return GetSignUpData(
      status: json['status'].toString() ?? '',
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      emailId: json['emailId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'].toString() ?? '',
      jwtToken: json['jwtToken'] ?? '',
      fcmToken: json['fcmToken'] ?? '',
    );
  }
}
