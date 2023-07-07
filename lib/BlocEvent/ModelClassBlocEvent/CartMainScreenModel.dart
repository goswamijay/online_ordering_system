import 'BlocProductMainScreenModel.dart';

class BlocCartAddItemModelClass {
  int status;
  String msg;
  double cartTotal;
  List<BlocCartAddItemData> data;

  BlocCartAddItemModelClass(
      {required this.status,
      required this.msg,
      required this.cartTotal,
      required this.data});

  factory BlocCartAddItemModelClass.fromJson(Map json) {
    final List<BlocCartAddItemData> dataList = [];
    if (json['data'] != null) {
      for (var data in json['data']) {
        dataList.add(BlocCartAddItemData.fromJson(data));
      }
    }
    return BlocCartAddItemModelClass(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        cartTotal:
            json['cartTotal'] != null ? json['cartTotal'].toDouble() : 0.00,
        data: dataList ?? []);
  }
}

class BlocCartAddItemData {
  String id;
  String userId;
  String cartId;
  int quantity;
  int productCount;
  BlocProductAllAPIData? productDetails;

  BlocCartAddItemData(
      {required this.id,
      required this.userId,
      required this.cartId,
      required this.quantity,
      required this.productCount,
      required this.productDetails});

  factory BlocCartAddItemData.fromJson(Map json) {
    return BlocCartAddItemData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      cartId: json['cartId'] ?? '',
      quantity: json['quantity'] ?? 0,
      productCount: json['productCount'] ?? 0,
      productDetails: json['productDetails'] != null
          ? BlocProductAllAPIData.fromJson(json['productDetails'])
          : null,
    );
  }
}
