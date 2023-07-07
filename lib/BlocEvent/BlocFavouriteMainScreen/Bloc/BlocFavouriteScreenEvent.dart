abstract class BlocFavoriteScreenEvent {}

class BlocFavouriteGetAllItemEvent extends BlocFavoriteScreenEvent {}

class BlocFavouriteUpdateAllItemEvent extends BlocFavoriteScreenEvent {}

class BlocFavouriteAddProductEvent extends BlocFavoriteScreenEvent {
  String productId;
  BlocFavouriteAddProductEvent(this.productId);
}

class BlocFavouriteRemoveProductEvent extends BlocFavoriteScreenEvent {
  String watchListItemId;
  BlocFavouriteRemoveProductEvent(this.watchListItemId);
}
