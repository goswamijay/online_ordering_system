abstract class BlocOrderPlaceMainEvent {}

class BlocPlaceOrderAllGetItemEvent extends BlocOrderPlaceMainEvent {}

class BlocPlaceOrderAllUpdateItemEvent extends BlocOrderPlaceMainEvent {}

class BlocPlaceOrderItemEvent extends BlocOrderPlaceMainEvent {
  String cartId;
  String cartTotal;
  BlocPlaceOrderItemEvent(this.cartId, this.cartTotal);
}
