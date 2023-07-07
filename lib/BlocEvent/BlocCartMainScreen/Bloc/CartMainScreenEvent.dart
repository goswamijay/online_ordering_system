abstract class BlocCartMainScreenEvent {}

class BlocCartAllDataGetEvent extends BlocCartMainScreenEvent {}

class BlocCartAllDataUpdateEvent extends BlocCartMainScreenEvent {}

class BlocCartAddToCartEvent extends BlocCartMainScreenEvent {
  final String productId;
  BlocCartAddToCartEvent(this.productId);
}

class BlocCartDecreaseProductQuantityEvent extends BlocCartMainScreenEvent {
  final String cartItemId;
  BlocCartDecreaseProductQuantityEvent(this.cartItemId);
}

class BlocCartIncreaseProductQuantityEvent extends BlocCartMainScreenEvent {
  final String cartItemId;
  BlocCartIncreaseProductQuantityEvent(this.cartItemId);
}

class BlocCartRemoveFromCartEvent extends BlocCartMainScreenEvent {
  final String cartItemId;
  BlocCartRemoveFromCartEvent(this.cartItemId);
}

class BlocCartUpdateButtonEvent extends BlocCartMainScreenEvent {
  final bool isVisible;
  final int index;
  BlocCartUpdateButtonEvent(this.isVisible, this.index);
}

class BlocCartUpdateButton2Event extends BlocCartMainScreenEvent {
  final bool isVisible;
  final int index;
  BlocCartUpdateButton2Event(this.isVisible, this.index);
}
