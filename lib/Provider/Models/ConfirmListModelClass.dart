class ConfirmListModelClass {
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;
  int Count;
  DateTime dateTime;

  ConfirmListModelClass(
      {required this.Price,
      required this.Name,
      required this.ShortDescription,
      required this.ImageURL,
      required this.Count,
      required this.dateTime});
}

class PlaceOrderModelClass {
  int status;
  String msg;
  List<PlaceOrderModelData> data;

  PlaceOrderModelClass({
    required this.status,
    required this.msg,
    required this.data,
  });

  factory PlaceOrderModelClass.fromJson(Map json) {

    final List<PlaceOrderModelData> dataList = [];
    for (var data in json['data']) {
      dataList.add(PlaceOrderModelData.fromJson(data));
    }
    return PlaceOrderModelClass(
      status: json['status'] ?? 0,
      msg: json['msg'] ?? '',
      data: dataList
    );
  }
}

class PlaceOrderModelData {
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

  PlaceOrderModelData(
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

  factory PlaceOrderModelData.fromJson(Map json) {
    return PlaceOrderModelData(
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
