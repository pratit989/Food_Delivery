import 'package:food_app/ViewModel/network_view_model.dart';
import 'package:food_app/ViewModel/product_listing_view_model.dart';
import 'package:food_app/ViewModel/user_view_model.dart';
import 'package:get/get.dart';

import 'ViewModel/cart_view_model.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserViewModel());
    Get.lazyPut(() => ProductListingViewModel());
    Get.put(CartViewModel());
    Get.lazyPut(() => NetworkViewModel());
  }
}