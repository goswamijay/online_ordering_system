abstract class ProductMainScreenEvent {}

class ProductAllItemShowingEvent extends ProductMainScreenEvent {}

class ProductAllItemUpdateEvent extends ProductMainScreenEvent {}

class ProductUpdateButtonEvent extends ProductMainScreenEvent {
  final bool isVisible;
  final int index;
  ProductUpdateButtonEvent(this.isVisible, this.index);
}

class ProductUpdateButton2Event extends ProductMainScreenEvent {
  final bool isVisible;
  final int index;
  ProductUpdateButton2Event(this.isVisible, this.index);
}

class ProductTotalItemEvent extends ProductMainScreenEvent {}

class ProductSearchButtonPressEvent extends ProductMainScreenEvent {
  final bool isSearchButtonPress;
  ProductSearchButtonPressEvent(this.isSearchButtonPress);
}

class ProductImageListEvent extends ProductMainScreenEvent {
  final int imageList;
  ProductImageListEvent(this.imageList);
}
