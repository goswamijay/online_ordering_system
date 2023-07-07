
import 'BlocProductModelClass.dart';

class BlocxFavorite{
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;
  int Count;

  BlocxFavorite(
      {required this.Price,
        required this.Name,
        required this.ShortDescription,
        required this.ImageURL,
        this.Count =1});
}

class BlocFavoriteAddItemModelClass {
  int status;
  String msg;
  List<BlocFavoriteAddItemData> data;

  BlocFavoriteAddItemModelClass(
      {required this.status, required this.msg, required this.data});

  factory BlocFavoriteAddItemModelClass.fromJson(Map json) {
    final List<BlocFavoriteAddItemData> dataList = [];
    for (var data in json['data']) {
      dataList.add(BlocFavoriteAddItemData.fromJson(data));
    }
    return BlocFavoriteAddItemModelClass(
      status: json['status'] ?? 0,
      msg: json['msg'] ?? '',
      data: dataList,
    );
  }
}

class BlocFavoriteAddItemData {
  String id;
  String userId;
  String cartId;
  int quantity;
  int productCount;
  BlocProductAllAPIData productDetails;

  BlocFavoriteAddItemData(
      {required this.id,
        required this.userId,
        required this.cartId,
        required this.quantity,
        required this.productCount,
        required this.productDetails});

  factory BlocFavoriteAddItemData.fromJson(Map json) {

    return BlocFavoriteAddItemData(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      cartId: json['cartId'] ?? '',
      quantity: json['quantity'] ?? 0,
      productCount: json['productCount'] ?? 0,
      productDetails:   json['productDetails'] != null
          ? BlocProductAllAPIData.fromJson(json['productDetails'])
          : BlocProductAllAPIData(id: '', title: '', description: '', price: '', imageUrl: '', quantity: 0, cartItemId: '', watchListItemId: ''),
    );
  }
}