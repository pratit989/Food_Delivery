import 'package:flutter/material.dart';
import 'package:food_app/Model/restaurant_model.dart';
import 'package:food_app/View/Components/product_view.dart';

class ProductCategoryPage extends StatefulWidget {
  const ProductCategoryPage({Key? key, required this.productList}) : super(key: key);
  final List<CategoryDishes> productList;

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.productList.length,
      itemBuilder: (context, index) {
        return ProductView(dish: widget.productList[index]);
      },
    );
  }
}
