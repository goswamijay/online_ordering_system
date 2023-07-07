import '../../Provider/Models/ProductListModelClass.dart';

class GetxFavorite{
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;
  int Count;

  GetxFavorite(
      {required this.Price,
        required this.Name,
        required this.ShortDescription,
        required this.ImageURL,
      this.Count =1});
}

class GetFavoriteAddItemModelClass {
  int status;
  String msg;
  List<GetFavoriteAddItemData> data;

  GetFavoriteAddItemModelClass(
      {required this.status, required this.msg, required this.data});

  factory GetFavoriteAddItemModelClass.fromJson(Map json) {
    final List<GetFavoriteAddItemData> dataList = [];
    for (var data in json['data']) {
      dataList.add(GetFavoriteAddItemData.fromJson(data));
    }
    return GetFavoriteAddItemModelClass(
      status: json['status'] ?? 0,
      msg: json['msg'] ?? '',
      data: dataList,
    );
  }
}

class GetFavoriteAddItemData {
  String id;
  String userId;
  String cartId;
  int quantity;
  int productCount;
  ProductAllAPIData productDetails;

  GetFavoriteAddItemData(
      {required this.id,
        required this.userId,
        required this.cartId,
        required this.quantity,
        required this.productCount,
        required this.productDetails});

  factory GetFavoriteAddItemData.fromJson(Map json) {

    return GetFavoriteAddItemData(
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