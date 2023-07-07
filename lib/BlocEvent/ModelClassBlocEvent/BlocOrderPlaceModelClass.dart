class BlocPlaceOrderModelClass {
  int status;
  String msg;
  List<BlocPlaceOrderModelData> data;

  BlocPlaceOrderModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory BlocPlaceOrderModelClass.fromJson(Map json) {

    final List<BlocPlaceOrderModelData> dataList = [];
    for (var data in json['data']) {
      dataList.add(BlocPlaceOrderModelData.fromJson(data));
    }
    return BlocPlaceOrderModelClass(
        status: json['status'] ?? 0,
        msg: json['msg'] ?? '',
        data: dataList
    );
  }
}

class BlocPlaceOrderModelData {
  String id;
  String userId;
  String orderId;
  String productId;
  String title;
  String description;
  String price;
  String imageUrl;
  int quantity;
  String productTotalAmount;
  String createdAt;
  String updatedAt;
  int v;

  BlocPlaceOrderModelData(
      {required this.id,
        required this.userId,
        required this.orderId,
        required this.productId,
        required this.title,
        required this.description,
        required this.price,
        required this.imageUrl,
        required this.quantity,
        required this.productTotalAmount,
        required this.createdAt,
        required this.updatedAt,
        required this.v});

  factory BlocPlaceOrderModelData.fromJson(Map json) {
    return BlocPlaceOrderModelData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      orderId: json['orderId'] ?? '',
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      quantity: json['quantity'] ?? 0,
      productTotalAmount: json['productTotalAmount'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['v'] ?? 0,
    );
  }
}