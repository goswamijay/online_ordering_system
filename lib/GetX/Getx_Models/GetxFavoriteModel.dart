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