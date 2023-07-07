import 'ProductListModelClass.dart';


class CartAddItemModelClass {
  int status;
  String msg;
  double cartTotal;
  List<CartAddItemData> data;

  CartAddItemModelClass(
      {required this.status, required this.msg, required this.cartTotal,required this.data});

  factory CartAddItemModelClass.fromJson(Map json) {
    final List<CartAddItemData> dataList = [];
    if (json['data'] != null) {
      for (var data in json['data']) {
        dataList.add(CartAddItemData.fromJson(data));
      }
    }
    return CartAddItemModelClass(
      status: json['status'] ?? 0,
      msg: json['msg'] ?? '',
        cartTotal : json['cartTotal'] != null ?json['cartTotal'].toDouble() : 0.00 ,
        data:  dataList ?? []
    );
  }
}

class CartAddItemData {
  String id;
  String userId;
  String cartId;
  int quantity;
  int productCount;
  ProductAllAPIData? productDetails;

  CartAddItemData(
      {required this.id,
        required this.userId,
      required this.cartId,
      required this.quantity,
      required this.productCount,
      required this.productDetails});

  factory CartAddItemData.fromJson(Map json) {

    return CartAddItemData(
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

