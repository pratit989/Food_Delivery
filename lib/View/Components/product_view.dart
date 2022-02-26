import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/Model/restaurant_model.dart';
import 'package:food_app/View/Components/counter_view.dart';
import 'package:food_app/ViewModel/cart_view_model.dart';
import 'package:get/get.dart';
class ProductView extends StatefulWidget {
  const ProductView(
      {Key? key, required this.dish})
      : super(key: key);

  final CategoryDishes dish;

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  int? countControllerValue;
  CategoryDishes get dish => widget.dish;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              width: MediaQuery.of(context).size.width*0.6,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        dish.dishName ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Text(
                            'INR ${dish.dishPrice}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(50, 0, 0, 0),
                          child: Text(
                            '${dish.dishCalories?.toInt()} calories',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 10),
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        dish.dishDescription ?? '',
                        style: const TextStyle(
                          color: Color(0xFF6A6A6A),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.22,
                      height: MediaQuery.of(context).size.height*0.042,
                      decoration: BoxDecoration(
                        color: const Color(0xFF228B22),
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
                  Visibility(
                    visible: dish.addonCat?.isNotEmpty ?? false,
                    child: const Text(
                      'Customizations Available',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.2,
                height: MediaQuery.of(context).size.width*0.2,
                child: FadeInImage(
                  placeholder: const AssetImage('assets/placeholderImage.jpg'),
                  image: NetworkImage(dish.dishImage ?? ''),
                  imageErrorBuilder: (context, obj, stackTrace) {
                    return Image.asset('assets/placeholderImage.jpg');
                  },
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
