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