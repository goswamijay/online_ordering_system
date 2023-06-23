class BlocLoginModelClass {
  String status;
  String msg;
  BlocLoginData data;

  BlocLoginModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory BlocLoginModelClass.fromJson(dynamic json) {
    return BlocLoginModelClass(
      status: json['status'].toString() ?? '',
      msg: json['msg'] ?? '',
      data:   json['data'] != null
          ? BlocLoginData.fromJson(json['data'])
          : BlocLoginData(
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
    );}
}

class BlocLoginData {
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

  BlocLoginData(
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

  factory BlocLoginData.fromJson(dynamic json) {
    return BlocLoginData(
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
