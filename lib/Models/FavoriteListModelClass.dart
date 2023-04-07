import 'ProductListModelClass.dart';

class FavoriteListModelClass {
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;
  int Count;

  FavoriteListModelClass(
      {required this.Price,
      required this.Name,
      required this.ShortDescription,
      required this.ImageURL,
      this.Count = 1});

 /* factory FavoriteListModelClass.fromJson(Map<String, dynamic> json) {
    return FavoriteListModelClass(
        Price: json['price'] as int,
        Name: json['title'] as String,
        ShortDescription: json['description'] as String,
        ImageURL: json['images[0]'] as String,
    Count: 1);
  }*/
}



class favoriteAddItemModelClass {
  int status;
  String msg;
  List<favoriteAddItemData> data;

  favoriteAddItemModelClass(
      {required this.status, required this.msg, required this.data});

  factory favoriteAddItemModelClass.fromJson(Map json) {
    final List<favoriteAddItemData> dataList = [];
    for (var data in json['data']) {
      dataList.add(favoriteAddItemData.fromJson(data));
    }
    return favoriteAddItemModelClass(
      status: json['status'] ?? 0,
      msg: json['msg'] ?? '',
      data: dataList,
    );
  }
}

class favoriteAddItemData {
  String id;
  String userId;
  String cartId;
  int quantity;
  int productCount;
  ProductAllAPIData productDetails;

  favoriteAddItemData(
      {required this.id,
        required this.userId,
        required this.cartId,
        required this.quantity,
        required this.productCount,
        required this.productDetails});

  factory favoriteAddItemData.fromJson(Map json) {

    return favoriteAddItemData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      cartId: json['cartId'] ?? '',
      quantity: json['quantity'] ?? 0,
      productCount: json['productCount'] ?? 0,
      productDetails:   json['productDetails'] != null
    ? ProductAllAPIData.fromJson(json['productDetails'])
        : ProductAllAPIData(id: '', title: '', description: '', price: '', imageUrl: '', quantity: 0, cartItemId: '', watchListItemId: ''),
    );
  }
}


