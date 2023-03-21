class GetConfirmListModelClass {
  int Price;
  String Name;
  String ShortDescription;
  String ImageURL;
  int Count;
  DateTime dateTime;

  GetConfirmListModelClass(
      {required this.Price,
        required this.Name,
        required this.ShortDescription,
        required this.ImageURL,
        required this.Count,
        required this.dateTime});
}