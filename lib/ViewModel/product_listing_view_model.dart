import 'package:flutter/material.dart';
import 'package:food_app/Model/restaurant_model.dart';
import 'package:food_app/Service/web_service.dart';
import 'package:food_app/View/Components/product_category_page_view.dart';
import 'package:get/get.dart';

class ProductListingViewModel extends GetxController {
  final Map<String, List<CategoryDishes>> _productData = {};

  List<Restaurant> _restaurantData = [];

  List<Restaurant> get restaurantData => _restaurantData;

  bool _loading = false;

  bool get loading => _loading;

  @override
  void onInit() {
    super.onInit();
    _getRestaurantDataFromAPI();
  }

  _getRestaurantDataFromAPI() async {
    _loading = true;
    _restaurantData = await Webservice().fetchRestaurant();
    for (TableMenuList tableMenu in _restaurantData.first.tableMenuList!) {
      _productData[tableMenu.menuCategory!] = tableMenu.categoryDishes!;
    }
    _loading = false;
    update();
  }

  List<Tab> get getProductCategoryTabs {
    return _productData.keys.map((categoryName) => Tab(text: categoryName)).toList();
  }

  List<ProductCategoryPage> get getProductCategoryPages {
    return _productData.values.map((dishList) => ProductCategoryPage(productList: dishList)).toList();
  }
}
