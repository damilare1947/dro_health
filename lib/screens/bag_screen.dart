import 'package:dro_health/provider/bag.dart';
import 'package:dro_health/widget/bag_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagScreen extends StatefulWidget {
  static const routeName = 'bag_screen';
  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  @override
  Widget build(BuildContext context) {
    final bag = Provider.of<Bag>(context);
    return Scaffold(
        backgroundColor: Color(0xff7B4397),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: bag.items.length,
                    itemBuilder: (ctx, i) => BagItems(
                        bag.items.values.toList()[i].title,
                        bag.items.values.toList()[i].id,
                        bag.items.keys.toList()[i],
                        bag.items.values.toList()[i].price,
                        bag.items.values.toList()[i].quantity,
                        bag.items.values.toList()[i].image)),
              ),
              Container(
                  child: Row(
                children: [
                  Text('Total',
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  Spacer(),
                  Text(bag.totalAmountItem.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                ],
              )),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('Checkout',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w600)),
                ),
              )
            ],
          ),
        )));
  }
}
