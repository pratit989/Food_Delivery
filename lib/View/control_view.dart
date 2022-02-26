import 'package:flutter/material.dart';
import 'package:food_app/View/login_page_view.dart';
import 'package:food_app/View/product_listing_view.dart';
import 'package:food_app/ViewModel/user_view_model.dart';
import 'package:get/get.dart';

import '../ViewModel/network_view_model.dart';

class ControlView extends StatefulWidget {
  const ControlView({Key? key}) : super(key: key);

  @override
  _ControlViewState createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Get.find<UserViewModel>().user == null
          ? const LoginPage()
          : Get.find<NetworkViewModel>().connectionStatus.value == 1 || Get.find<NetworkViewModel>().connectionStatus.value == 2
              ? const ProductListing()
              : const NoInternetConnection();
    });
  }
}

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(
              height: 30,
            ),
            Text(
              'Please check your internet connection..',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
