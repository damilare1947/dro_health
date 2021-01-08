import 'package:dro_health/provider/product.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
        id: 'p01',
        image: 'images/kezitil.png',
        productName: 'Kezitil Susp.',
        productDescription1: 'cerufoxime Axetil',
        productDescription2: 'oral suspension -125mg',
        price: 1820),
    Product(
        id: 'p02',
        image: 'images/kezitil_tab.png',
        productName: 'Kezitil',
        productDescription1: 'Cerufoxime Axetil',
        productDescription2: 'Tablet -250mg',
        price: 1140),
    Product(
        id: 'p03',
        image: 'images/garlic.png',
        productName: 'Garlic oil',
        productDescription1: 'Garlic oil',
        productDescription2: 'Soft gel-650mg',
        price: 385),
    Product(
        id: 'p04',
        image: 'images/folic_tab.jpg',
        productName: 'Folic-Acid(100)',
        productDescription1: 'Folic Acid',
        productDescription2: 'Tablet -5mg',
        price: 170),
    Product(
        id: 'p05',
        image: 'images/folic_acid_container.jpg',
        productName: 'Folic-Acid',
        productDescription1: 'Folic acid',
        productDescription2: 'oral suspension -125mg',
        price: 1820),
    Product(
        id: 'p06',
        image: 'images/prime_rose.jpg',
        productName: 'Evening Primerose oil',
        productDescription1: 'Emzor',
        productDescription2: 'oral suspension -125mg',
        price: 1820),
  ];

  List<Product> get loadedProducts {
    return [..._products];
  }

  Product findId(String id) {
    return loadedProducts.firstWhere((prod) => prod.id == id);
  }
}
