class BlocProductAllAPI {
  int status;
  String msg;
  int totalProduct;
  List<BlocProductAllAPIData> data;

  BlocProductAllAPI(
      {required this.status,
      required this.msg,
      required this.totalProduct,
      required this.data});

  factory BlocProductAllAPI.fromJson(Map<String, dynamic> json) {
    final List<BlocProductAllAPIData> dataList = [];
    for (var data in json['data']) {
      dataList.add(BlocProductAllAPIData.fromJson(data));
    }
    return BlocProductAllAPI(
      status: json['staus'] ?? 0,
      msg: json['msg'] ?? '',
      totalProduct: json['totalProduct'] ?? 0,
      data: dataList ?? [],
    );
  }
}

class BlocProductAllAPIData {
  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int quantity;
  String cartItemId;
  String watchListItemId;

  BlocProductAllAPIData(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.quantity,
      required this.cartItemId,
      required this.watchListItemId});

  factory BlocProductAllAPIData.fromJson(Map<String, dynamic> json) {
    return BlocProductAllAPIData(
        id: json['_id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        price: json['price'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        quantity: json['quantity'] ?? 0,
        cartItemId: json['cartItemId'] ?? '',
        watchListItemId: json['watchListItemId'] ?? '');
  }
}
