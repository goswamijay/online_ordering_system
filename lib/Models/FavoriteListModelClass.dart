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
