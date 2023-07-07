class BlocSignupModelClass {
  String status;
  String msg;
  BlocSignUpData data;

  BlocSignupModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory BlocSignupModelClass.fromJson(dynamic json) {
    return BlocSignupModelClass(
      status: json['status'].toString() ?? '',
      msg: json['msg'],
      data: json['data'] != null
          ? BlocSignUpData.fromJson(json['data'])
          : BlocSignUpData(
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

class BlocSignUpData {
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

  BlocSignUpData(
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

  factory BlocSignUpData.fromJson(dynamic json) {
    return BlocSignUpData(
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