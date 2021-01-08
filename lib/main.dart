import 'package:dro_health/provider/bag.dart';
import 'package:dro_health/provider/products.dart';
import 'package:dro_health/screens/Product_overview_screen.dart';
import 'package:dro_health/screens/bag_screen.dart';
import 'package:dro_health/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

Products product;
TextEditingController _searchQuery;
Bag bag;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext contest) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Bag(),
        ),
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: 'proxima-Nova'),
          home: ProductOverviewScreen(),
          routes: {
            ProductOverviewScreen.routeName: (context) =>
                ProductOverviewScreen(),
            ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
            BagScreen.routeName: (context) => BagScreen(),
            DraggableWidget.routeName: (context) => DraggableWidget()
          }),
    );
  }
}
