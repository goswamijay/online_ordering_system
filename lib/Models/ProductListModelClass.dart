class ProductList {
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;

  ProductList(
      {required this.Price,
        required this.Name,
        required this.ShortDescription,
        required this.ImageURL});

  factory ProductList.fromJson(Map json) {
    return ProductList(
      Price: json['price'] ,
      Name: json['title'] ,
      ShortDescription: json['description'] ,
      ImageURL: json['images[0]'] ,
    );
  }
}
class ProductAllAPI {
  int status;
  String msg;
  int totalProduct;
  List<ProductAllAPIData> data;

  ProductAllAPI({required this.status, required this.msg,required  this.totalProduct,required this.data});

  factory ProductAllAPI.fromJson(Map<String, dynamic> json) {
    final List<ProductAllAPIData> dataList = [];
    for (var data in json['data']) {
      dataList.add(ProductAllAPIData.fromJson(data));
    }
    return ProductAllAPI(
      status: json['staus'],
      msg: json['msg'],
      totalProduct: json['totalProduct'],
      data: dataList,
    );
  }
}

class ProductAllAPIData {
  String id;
  String title;
  String description;
  String price;
  String imageUrl;
  int v;
  String createdAt;
  String updatedAt;

  ProductAllAPIData({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.v,
    required this.createdAt,
    required  this.updatedAt,
  });

  factory ProductAllAPIData.fromJson(Map<String, dynamic> json) {
    return ProductAllAPIData(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      v: json['__v'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
/*

class ProductAllAPI {
  int status;
  String msg;
  int totalProduct;
  //ProductAllAPIData data;

  ProductAllAPI(
      {required this.status,
        required this.msg,
        required this.totalProduct,
        //required this.data
      });

  factory ProductAllAPI.fromJson(Map json) {
    return ProductAllAPI(
      status: json['staus'],
      msg: json['msg']  as String,
      totalProduct: json['totalProduct'] ,
      // data: json['data'] ,
    );
  }
}


class ProductAllAPIData {
 // String id;
  String title;
 // String description;
 // String price;
 // String imageUrl;
 // int v;
 // String createdAt;
//  String updatedAt;


  ProductAllAPIData(
      {//required this.id,
        required this.title,
       // required this.description,
       // required this.price,
       // required this.imageUrl,
       // required this.v,
       // required this.createdAt,
       // required this.updatedAt,
    });

  factory ProductAllAPIData.fromJson(dynamic json) {
    return ProductAllAPIData(
      //id: json['_id'] as String,
      title: json['title'] as String,
      //description: json['description'] as String,
      //price: json['price'] as String,
      //imageUrl: json['imageUrl'] as String,
     // v: json['__v'] ,
      //createdAt: json['createdAt'] as String,
     // updatedAt: json['updatedAt'] as String,

    );
  }
}

*/
