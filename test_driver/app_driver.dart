import 'package:flutter_driver/flutter_driver.dart';
import 'package:online_ordering_system/BlocEvent/BlocCartMainScreen/Bloc/CartMainScreenBloc.dart';
import 'package:online_ordering_system/BlocEvent/BlocProductMainScreen/Bloc/ProductMainScreenBloc.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Online Ordering System', () {
    late FlutterDriver driver;
    setUpAll(() async {
      driver = await FlutterDriver.connect(
          dartVmServiceUrl: 'ws://127.0.0.1:9456/6__4w3zNANE=/ws');
    });

    test('Login Successful', () async {
      await driver.tap(find.byValueKey('login_user_name_email'));
      await driver.enterText('test@gmail.com');
      await driver.tap(find.byValueKey('login_user_name_password'));
      await driver.enterText('123456');
      await driver.tap(find.byValueKey('Login_Button'));
      //await driver.getText(find.text('You are not registered with us kindly register first!'));
      await driver.waitFor(find.text('Login Successful!'));
      //expect(driver.waitFor(find.text('Login Successful!')), 'Login Successful!');
    });

    test('Sign up Successful', () async {
      await driver.tap(find.byValueKey('Login_To_Signup_page_Route'));
      await driver.waitFor(find.text('Welcome'));
      await driver.tap(find.byValueKey('Sign_up_user_name'));
      await driver.enterText('test1');
      await driver.tap(find.byValueKey('Sign_up_email_id'));
      await driver.enterText('test1@gmail.com');
      await driver.tap(find.byValueKey('Sign_up_mobile_number'));
      await driver.enterText('887744');
      await driver.tap(find.byValueKey('Sign_up_password'));
      await driver.enterText('123456');
      await driver.tap(find.byValueKey('Sign_up_Re_password'));
      await driver.enterText('123456');
      await driver.tap(find.byValueKey('user_Signup_Button'));
      await driver.tap(find.text('OTP Verification'));
      //    expect(find.byType('Text'), 'OTP Verification');
    });

    test('Home Page to Product add & remove in cart and favourite', () async {
      final productMainScreenBloc = ProductMainScreenBloc();
      await driver.tap(find.byValueKey('Home_Page_add_to_cart_button:-1'));
      expect(productMainScreenBloc.isLoadingList[1], false);
      await driver.tap(find.byValueKey('Home_Page_to_add_favourite_button:-0'));
      expect(productMainScreenBloc.isLoadingList[0], false);
      await driver
          .tap(find.byValueKey('Home_Page_to_remove_favourite_button:-0'));
      expect(productMainScreenBloc.isLoadingList[0], false);
      await driver
          .tap(find.byValueKey('Home_Page_to_increases_cart_item_button:-1'));
      expect(productMainScreenBloc.isLoadingList[1], false);
      await driver
          .tap(find.byValueKey('Home_Page_to_decreases_cart_item_button:-1'));
      expect(productMainScreenBloc.isLoadingList[1], false);
      // productMainScreenBloc.add(ProductUpdateButtonEvent(false, 1));
    });

    test('Home Page Search Product to add & remove in cart and favourite',
        () async {
      final productMainScreenBloc = ProductMainScreenBloc();
      final cartMainScreenBloc = CartMainScreenBloc();

      await driver.tap(find.byValueKey('Home_Page_add_to_cart_button:-0'));
      expect(productMainScreenBloc.isLoadingList[0], false);
      await driver.tap(find.byValueKey('Home_Page_add_to_cart_button:-1'));
      expect(productMainScreenBloc.isLoadingList[1], false);
      await driver.tap(find.byValueKey('Home_Page_add_to_cart_button:-2'));
      expect(productMainScreenBloc.isLoadingList[2], false);
      await driver.tap(find.byValueKey('Home_Page_add_to_cart_button:-3'));
      expect(productMainScreenBloc.isLoadingList[3], false);
      await driver.tap(find.byValueKey('Product_Screen_To_Cart_Screen_Button'));
      await driver.tap(find.byValueKey('Cart_Screen_decrease_item_count:-1'));
      expect(cartMainScreenBloc.isLoadingList[1], false);
      await driver.tap(find.byValueKey('Cart_Screen_increase_item_count:-0'));
      expect(cartMainScreenBloc.isLoadingList[0], false);
      await driver.tap(find.byValueKey('Cart_Screen_delete_item:-2'));
      expect(cartMainScreenBloc.isLoadingList[2], false);
      await driver.tap(find.byValueKey('Cart_Screen_place_order_items'));
      await driver.tap(find.byValueKey('Cart_Screen_place_order_items_confirm_button'));
    });
  });
}
