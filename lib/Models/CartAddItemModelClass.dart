import 'ProductListModelClass.dart';

class CartAddItemModelClass {
  int status;
  String msg;
  CartAddItemData data;

  CartAddItemModelClass(
      {required this.status, required this.msg, required this.data});

  factory CartAddItemModelClass.fromJson(Map json) {
    return CartAddItemModelClass(
      status: json['status'],
      msg: json['msg'] as String,
      data: json['data'],
    );
  }
}

class CartAddItemData {
  String userId;
  String cartId;
  int quantity;
  int productCount;
  ProductAllAPIData productDetails;

  CartAddItemData(
      {required this.userId,
      required this.cartId,
      required this.quantity,
      required this.productCount,
      required this.productDetails});

  factory CartAddItemData.fromJson(Map json) {
    return CartAddItemData(
      userId: json['userId'] as String,
      cartId: json['cartId'] as String,
      quantity: json['quantity'],
      productCount: json['productCount'],
      productDetails: json['productDetails'],
    );
  }
}
