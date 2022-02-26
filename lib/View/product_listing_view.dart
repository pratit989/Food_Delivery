import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:food_app/View/cart_view.dart';
import 'package:food_app/View/profile_view.dart';
import 'package:food_app/ViewModel/cart_view_model.dart';
import 'package:food_app/ViewModel/product_listing_view_model.dart';
import 'package:get/get.dart';

class ProductListing extends StatefulWidget {
  const ProductListing({Key? key}) : super(key: key);

  @override
  _ProductListingState createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductListingViewModel>(
      init: Get.find<ProductListingViewModel>(),
      builder: (controller) {
        return Scaffold(
          drawer: const ProfileView(),
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: Colors.grey[600]
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              GestureDetector(
                onTap: () => Get.to(() => const CartView()),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GetBuilder<CartViewModel>(
                    init: Get.find<CartViewModel>(),
                    builder: (cartController) {
                      return Badge(
                        badgeContent: Text('${cartController.cartItemCount}',style: const TextStyle(color: Colors.white, fontSize: 10),),
                        child: const Icon(Icons.shopping_cart),
                        position: BadgePosition.topEnd(top: 0, end: -8),
                      );
                    }
                  ),
                ),
              )
            ],
          ),
          body: controller.loading
          ? const Center(child: CircularProgressIndicator(),)
          : DefaultTabController(
            length: controller.getProductCategoryTabs.length,
            initialIndex: 0,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.pinkAccent,
                  unselectedLabelColor: const Color(0xFF6A6A6A),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: Colors.pinkAccent,
                  tabs: controller.getProductCategoryTabs,
                  isScrollable: true,
                ),
                Expanded(
                  child: TabBarView(
                    children: controller.getProductCategoryPages
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
