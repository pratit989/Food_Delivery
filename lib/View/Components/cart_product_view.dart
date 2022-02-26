import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/Model/restaurant_model.dart';
import 'package:get/get.dart';

import '../../ViewModel/cart_view_model.dart';
import 'counter_view.dart';

class CartProductView extends StatefulWidget {
  const CartProductView({Key? key, required this.dish}) : super(key: key);
  final CategoryDishes dish;

  @override
  _CartProductViewState createState() => _CartProductViewState();
}

class _CartProductViewState extends State<CartProductView> {
  late int countControllerValue;
  CategoryDishes get dish => widget.dish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(5, 20, 5, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: dish.dishType == 2 ? const Color(0xFF228B22) : Colors.red[900]!,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.brightness_1,
                color: dish.dishType == 2 ? const Color(0xFF228B22) : Colors.red[900],
                size: 15,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.3,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    dish.dishName ?? '',
                    style:
                    TextStyle(
                      color: const Color(0xFF021308),
                      fontSize: MediaQuery.of(context).size.width*0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'INR ${dish.dishPrice}',
                  style: const TextStyle(
                    color: Color(0xFF021308),
                  ),
                ),
                Text(
                  '${dish.dishCalories} calories',
                  style: const TextStyle(
                    color: Color(0xFF021308),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            child: Container(
                width: MediaQuery.of(context).size.width*0.22,
                height: MediaQuery.of(context).size.height*0.042,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D3D0D),
                  borderRadius: BorderRadius.circular(25),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: const Color(0xFF9E9E9E),
                    width: 1,
                  ),
                ),
                child: GetBuilder<CartViewModel>(
                  init: Get.find<CartViewModel>(),
                  builder: (cartController) {
                    return CountController(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      minimum: 0,
                      decrementIconBuilder: (enabled) => FaIcon(
                        FontAwesomeIcons.minus,
                        color: enabled ? const Color(0xD9FFFFFF) : const Color(0xFFEEEEEE),
                        size: MediaQuery.of(context).size.width*0.04,
                      ),
                      incrementIconBuilder: (enabled) => FaIcon(
                        FontAwesomeIcons.plus,
                        color: enabled ? const Color(0xD9FFFFFF) : const Color(0xFFEEEEEE),
                        size: MediaQuery.of(context).size.width*0.04,
                      ),
                      countBuilder: (count) => Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Color(0xD9FFFFFF),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      count: cartController.cart[dish.dishId!] != null
                          ? cartController.cart[dish.dishId]!.count
                          : 0,
                      updateCount: (count) {
                        count == 1 ? cartController.addItemToCart(dish) : cartController.incrementQuantity(dish.dishId!, count);
                        setState(() => countControllerValue = count);
                      },
                      stepSize: 1,
                    );
                  },
                )
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
            child: Text(
              'INR ${dish.dishPrice!*dish.count}',
              style: const TextStyle(
                color: Color(0xFF021308),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
