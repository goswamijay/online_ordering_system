import '../../Provider/Models/ProductListModelClass.dart';

class GetCartAddItemModelClass {
  int status;
  String msg;
  double cartTotal;
  List<GetCartAddItemData> data;

  GetCartAddItemModelClass(
      {required this.status, required this.msg, required this.cartTotal,required this.data});

  factory GetCartAddItemModelClass.fromJson(Map json) {
    final List<GetCartAddItemData> dataList = [];
    if (json['data'] != null) {
      for (var data in json['data']) {
        dataList.add(GetCartAddItemData.fromJson(data));
      }
    }
    return GetCartAddItemModelClass(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        cartTotal : json['cartTotal'] != null ?json['cartTotal'].toDouble() : 0.00 ,
        data:  dataList ?? []
    );
  }
}

class GetCartAddItemData {
  String id;
  String userId;
  String cartId;
  int quantity;
  int productCount;
  ProductAllAPIData? productDetails;

  GetCartAddItemData(
      {required this.id,
        required this.userId,
        required this.cartId,
        required this.quantity,
        required this.productCount,
        required this.productDetails});

  factory GetCartAddItemData.fromJson(Map json) {

    return GetCartAddItemData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      cartId: json['cartId'] ?? '',
      quantity: json['quantity'] ?? 0,
      productCount: json['productCount'] ?? 0,
      productDetails: json['productDetails'] != null
          ? ProductAllAPIData.fromJson(json['productDetails'])
          : null,
    );
  }
}

