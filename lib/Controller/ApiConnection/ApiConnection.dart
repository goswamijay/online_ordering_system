import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Models/ProductListModelClass.dart';
class ApiConncection {
  static Future<List<dynamic>> getData() async {
    List<ProductList> users = [];
    try {
  /*    var uri = Uri.parse(
          'https://api.escuelajs.co/api/v1/products?limit=20&offset=20');

      var response = await http.get(uri);

      if (response.statusCode == 200) {
        //   res =  ProductList.fromJson(jsonDecode(response.body));

        Iterable result = json.decode(response.body.toString());
      //  print(result.length);
        res = result.map((e) => ProductList.fromJson(e)).toList();
      } else {
        print("not fetched");
      }
    }*/
      var uri = Uri.parse(
          'https://api.escuelajs.co/api/v1/products?limit=20&offset=20');

      var response = await http.get(uri);
      var jsonData = json.decode(response.body);

      if (response.statusCode == 200) {
        for (var json in jsonData) {
          ProductList productList = ProductList(
            Price: json['price'] ,
            Name: json['title'] ,
            ShortDescription: json['description'] ,
            ImageURL: json['images[0]'] ,
             );
          users.add(productList);
        }
        print(jsonData);
        return users;
      } //=> if you dont want to use try method just remove and its work
    }

    catch (e) {
      throw Exception(e.toString());
    }
    return users;
  }
}
