class GetLoginModelClass {
  String status;
  String msg;
  GetLoginData data;

  GetLoginModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory GetLoginModelClass.fromJson(dynamic json) {
    return GetLoginModelClass(
        status: json['status'].toString() ?? '',
        msg: json['msg'] ?? '',
        data:   json['data'] != null
            ? GetLoginData.fromJson(json['data'])
            : GetLoginData(
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

class GetLoginData {
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

  GetLoginData(
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

  factory GetLoginData.fromJson(dynamic json) {
    return GetLoginData(
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
