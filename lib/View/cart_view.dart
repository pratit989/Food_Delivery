import 'package:flutter/material.dart';
import 'package:food_app/View/Components/cart_product_view.dart';
import 'package:food_app/View/control_view.dart';
import 'package:food_app/ViewModel/cart_view_model.dart';
import 'package:get/get.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (cartController) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.grey),
              backgroundColor: Colors.white,
              title: const Text('Order Summary', style: TextStyle(color: Colors.grey),),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05, horizontal: MediaQuery
                    .of(context)
                    .size
                    .width * 0.05),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.7,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D3D0D),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: Text(
                              '${cartController.cartLength} Dishes - ${cartController.cartItemCount} Items',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: MediaQuery
                              .of(context)
                              .size
                              .height) * 0.8,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: ListView.builder(
                              itemCount: cartController.cartLength,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CartProductView(dish: cartController.cart.values.elementAt(index)),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                                      child: Divider(color: Colors.black,),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05),),
                              Text('${cartController.totalSum}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.05, color: Colors.green),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: const Color(0xFF0D3D0D), onPressed: () {
                  Get.to(() => AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Order Successfully Placed'),
                    actions: [
                      TextButton(onPressed: () {
                        Get.offAll(() => const ControlView());
                        cartController.reset();
                      }, child: const Text('OK'),)
                    ],
                  ));
                }, label: SizedBox(width: MediaQuery
                .of(context)
                .size
                .width * 0.8, child: const Text('Place Order', style: TextStyle(fontSize: 18), textAlign: TextAlign.center,))),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        }
    );
  }
}
