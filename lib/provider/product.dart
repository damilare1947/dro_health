import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String image;
  final String productName;
  final String productDescription1;
  final String productDescription2;
  final int price;
  Product(
      {@required this.id,
      @required this.image,
      @required this.productName,
      @required this.productDescription1,
      @required this.productDescription2,
      @required this.price});
}
