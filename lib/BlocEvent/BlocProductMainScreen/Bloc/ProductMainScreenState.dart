import 'package:online_ordering_system/BlocEvent/ModelClassBlocEvent/BlocProductMainScreenModel.dart';

abstract class BlocProductMainScreenState {}

class BlocProductMainInitialScreenState extends BlocProductMainScreenState {}

class BlocProductMainLoadingScreenState extends BlocProductMainScreenState {}

class BlocProductMainScreenUpdateState extends BlocProductMainScreenState {
  BlocProductAllAPI getProductAllAPI =
      BlocProductAllAPI(status: 1, msg: '', totalProduct: 0, data: []);
  BlocProductMainScreenUpdateState(this.getProductAllAPI);
}

class BlocProductMainGetProductScreenState extends BlocProductMainScreenState {
  BlocProductAllAPI getProductAllAPI =
      BlocProductAllAPI(status: 1, msg: '', totalProduct: 0, data: []);
  BlocProductMainGetProductScreenState(this.getProductAllAPI);
}

class BlocProductMainUpdateProductScreenState
    extends BlocProductMainScreenState {}

class BlocProductMainFailProductScreenState
    extends BlocProductMainScreenState {}

class BlocProductMainJWTNotFoundProductScreenState
    extends BlocProductMainScreenState {}

class BlocProductLoadingState extends BlocProductMainScreenState {}

class BlocProductTotalItemState extends BlocProductMainScreenState {}

class BlocImageListChangeState extends BlocProductMainScreenState {}
