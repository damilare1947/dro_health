import 'package:dro_health/provider/bag.dart';
import 'package:dro_health/provider/product.dart';
import 'package:dro_health/provider/products.dart';
import 'package:dro_health/widget/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = 'product_details_screen';
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments;

    final loadedProducts =
        Provider.of<Products>(context, listen: false).findId(productId);

    final bag = Provider.of<Bag>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBar1(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: Image.asset(loadedProducts.image)),
                    Text(loadedProducts.productName,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600)),
                    Text(loadedProducts.productDescription2,
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w600)),
                    content(),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (value < 2) {
                                        value = 1;
                                      } else {
                                        value--;
                                      }
                                    });
                                  },
                                ),
                                Text('$value'),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      value++;
                                    });
                                  },
                                ),
                              ],
                            )),
                        SizedBox(width: 5.0),
                        Text('Packs'),
                        Spacer(),
                        Text('${loadedProducts.price * value}')
                      ],
                    ),
                    contentContainer(loadedProducts.productName),
                    SizedBox(height: 50.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 20.0, top: 20.0, bottom: 20.0),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Color(0xff9F5DE2),
                          textColor: Colors.white,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('images/bag.svg',
                                    width: 25.0,
                                    height: 25.0,
                                    color: Colors.white),
                                SizedBox(width: 20),
                                Text('Add to Bag',
                                    style: TextStyle(fontSize: 20.0))
                              ],
                            ),
                          ),
                          onPressed: () {
                            bag.addItem(
                                loadedProducts.id,
                                loadedProducts.price,
                                loadedProducts.productName,
                                value,
                                loadedProducts.image);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: "Successsful",
                                    descriptions:
                                        "${loadedProducts.productName} oil has been added to your bag",
                                    text1: "View Bag",
                                    text2: 'Done',
                                  );
                                });
                            print('length:${bag.items}');
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: Color(0xff909090)),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SOLD BY',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
              ),
              Text('Emzor Pharmaceuticals',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget appBar1() {
    final bag = Provider.of<Bag>(context);
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back)),
            Spacer(),
            FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                color: Color(0xff9F5DE2),
                textColor: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  alignment: Alignment.center,
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('images/bag.svg',
                          width: 20.0, height: 20.0, color: Colors.white),
                      SizedBox(width: 5),
                      Text(bag.totalQuantity.toString(),
                          style: TextStyle(fontSize: 20.0))
                    ],
                  ),
                ),
                onPressed: () {}),
          ],
        ));
  }

  Widget contentContainer(loadedProducts) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PRODUCT DETAILS',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                icons('images/capsules.svg'),
                SizedBox(width: 5.0),
                column('Pack Size', '3x10'),
                SizedBox(width: 60.0),
                icons('images/qr-code.svg'),
                SizedBox(width: 5.0),
                column('ProductId', 'PROBRYVPW1'),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                icons('images/medicine.svg'),
                SizedBox(width: 5.0),
                column('Constituents', loadedProducts),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                icons('images/delete.svg'),
                SizedBox(width: 5.0),
                column('Dispensed in', 'Packs'),
              ],
            ),
            SizedBox(height: 30.0),
            Container(
                alignment: Alignment.center,
                child: Text(
                    '1 pack of $loadedProducts contains 3 Units of 10 Tablet(s)',
                    style: TextStyle(color: Colors.grey, fontSize: 12.0)))
          ],
        ));
  }

  Column column(text1, text2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1,
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.grey[500])),
        Text(text2, style: TextStyle(fontWeight: FontWeight.w600))
      ],
    );
  }

  Widget icons(text) {
    return SvgPicture.asset(
      text,
      width: 30.0,
      height: 30.0,
      color: Color(0xff7B4397),
    );
  }
}
