import 'package:food_app/Model/restaurant_model.dart';
import 'package:get/get.dart';

class CartViewModel extends GetxController {
  final Map<String, CategoryDishes> _cart = {};

  Map<String, CategoryDishes> get cart => _cart;
  int get cartLength => _cart.length;
  int get cartItemCount {
    int sum = 0;
    for (CategoryDishes _dish in _cart.values) {
      sum += _dish.count;
    }
    return sum;
  }

  addItemToCart(CategoryDishes dish) {
    _cart[dish.dishId!] = dish;
    _cart[dish.dishId]!.count = 1;
    update();
  }

  incrementQuantity(String itemID, int count) {
    count == 0 ? _cart.remove(itemID) : _cart[itemID]!.count = count;
    update();
  }

  double get totalSum {
    double sum = 0;
    for (CategoryDishes dish in _cart.values) {
      sum += dish.count*dish.dishPrice!;
    }
    return sum;
  }

  reset() {
    _cart.clear();
    update();
  }
}