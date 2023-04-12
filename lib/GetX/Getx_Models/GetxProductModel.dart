class GetxProduct{
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;
  int Count;

  GetxProduct(
      {required this.Price,
        required this.Name,
        required this.ShortDescription,
        required this.ImageURL,
        this.Count =1});
}


class GetProductAllAPI {
  int status;
  String msg;
  int totalProduct;
  List<GetProductAllAPIData> data;

  GetProductAllAPI({required this.status, required this.msg,required  this.totalProduct,required this.data});

  factory GetProductAllAPI.fromJson(Map<String, dynamic> json) {
    final List<GetProductAllAPIData> dataList = [];
    for (var data in json['data']) {
      dataList.add(GetProductAllAPIData.fromJson(data));
    }
    return GetProductAllAPI(
      status: json['staus'] ?? 0,
      msg: json['msg'] ?? '',
      totalProduct: json['totalProduct'] ?? 0,
      data: dataList,
    );
  }
}

class GetProductAllAPIData {
  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int quantity;
  String cartItemId;
  String watchListItemId;

  GetProductAllAPIData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.cartItemId,
    required this.watchListItemId
  });

  factory GetProductAllAPIData.fromJson(Map<String, dynamic> json) {
    return GetProductAllAPIData(
        id: json['_id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        price: json['price'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        quantity: json['quantity'] ?? 0,
        cartItemId: json['cartItemId'] ?? '',
        watchListItemId: json['watchListItemId'] ?? ''
    );
  }
}