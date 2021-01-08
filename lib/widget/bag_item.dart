import 'package:dro_health/provider/bag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BagItems extends StatefulWidget {
  final String title;
  final String id;
  final String productId;
  final int price;
  int quantity;
  final String image;
  BagItems(this.title, this.id, this.productId, this.price, this.quantity,
      this.image);

  @override
  _BagItemsState createState() => _BagItemsState();
}

class _BagItemsState extends State<BagItems> {
  var expanded = false;
  @override
  Widget build(BuildContext context) {
    final bag = Provider.of<Bag>(context);
    return Card(
        elevation: 0,
        color: Color(0xff7B4397),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (expanded == false) {
                  setState(() {
                    expanded = true;
                  });
                } else {
                  setState(() {
                    expanded = false;
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (!expanded)
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          //   radius: 50.0,
                          child: Image.asset(widget.image,
                              width: 30.0, height: 30.0, fit: BoxFit.contain)),
                    SizedBox(width: 15.0),
                    Text('${widget.quantity} X',
                        style: TextStyle(color: Colors.white)),
                    SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,
                            style: TextStyle(color: Colors.white)),
                        Text('capsule', style: TextStyle(color: Colors.white))
                      ],
                    ),
                    Spacer(),
                    Text("${widget.price * widget.quantity}",
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ),
            ),
            if (expanded)
              Container(
                  child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.quantity < 2) {
                          widget.quantity = 1;
                        } else {
                          widget.quantity--;
                          bag.removeSingleItem(
                              widget.productId, widget.quantity);
                        }
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text('${widget.quantity.toString()}',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.quantity++;
                        bag.addItem(widget.productId, widget.price,
                            widget.title, widget.quantity, widget.image);
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ))
          ],
        ));
  }
}
// ListTile(
//         leading: CircleAvatar(
//           child: FittedBox(
//             child: Text('${quantity}X'),
//           ),
//         ),
//         title: Text(title),
//         subtitle: Text('capsule'),
//         trailing: Text("${price * quantity}"),
//       ),
