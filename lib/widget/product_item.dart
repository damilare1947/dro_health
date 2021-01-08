import 'package:dro_health/provider/product.dart';
import 'package:dro_health/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productItem = Provider.of<Product>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
            arguments: productItem.id);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Flexible(
              flex: 2,
              child: Image.asset(
                productItem.image,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  productItem.productName,
                  style: TextStyle(fontWeight: FontWeight.w600),
                )
              ],
            ),
            Row(
              children: [
                Text(productItem.productDescription1,
                    style: TextStyle(
                        color: Color(0xff909090), fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              children: [
                Text(productItem.productDescription2,
                    style: TextStyle(
                        color: Color(
                          0xff909090,
                        ),
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.all(8.0),
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 5.0, bottom: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xff909090),
                  ),
                  child: Text(productItem.price.toString(),
                      style: TextStyle(color: Colors.white)),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
