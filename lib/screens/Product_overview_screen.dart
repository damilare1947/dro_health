import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:dro_health/provider/bag.dart';
import 'package:dro_health/provider/product.dart';
import 'package:dro_health/provider/products.dart';
import 'package:dro_health/widget/bag_item.dart';
import 'package:dro_health/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = 'product_overview_screen';
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  final key = GlobalKey<ScaffoldState>();
  TextEditingController _searchQuery = TextEditingController();

  bool _IsSearching;
  String _searchText = "";
  List _searchList;
  @override
  void initState() {
    super.initState();
    _IsSearching = false;
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    final bag = Provider.of<Bag>(context);

    // List<Product> _buildSearchList() {
    //   //List product = Provider.of<Products>(context).loadedProducts;
    //   if (_searchText.isEmpty) {
    //     _searchList;
    //   } else {
    //     /*for (int i = 0; i < _list.length; i++) {
    //     String name = _list.elementAt(i);
    //     if (name.toLowerCase().contains(_searchText.toLowerCase())) {
    //       _searchList.add(name);
    //     }
    //   }*/

    //     _searchList = product
    //         .where((element) =>
    //             element.productName
    //                 .toLowerCase()
    //                 .contains(_searchText.toLowerCase()) ||
    //             element.productDescription1
    //                 .toLowerCase()
    //                 .contains(_searchText.toLowerCase()))
    //         .toList();
    //     print('${_searchList.length}');
    //     return _searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
    //   }
    // }

    return Scaffold(body: DraggableWidget());
  }
}

class DraggableWidget extends StatefulWidget {
  static const routeName = 'bag';

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  var expand = false;
  TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context);
    final bag = Provider.of<Bag>(context);

    return DraggableBottomSheet(
      backgroundWidget: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                appBar1('${product.loadedProducts.length.toString()} item(s)'),
                icons(),
                if (expand)
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: TextField(
                      controller: _searchQuery,
                      decoration: InputDecoration(
                          //labelText: "Search",
                          //hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: Icon(Icons.close),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
                    itemCount: product.loadedProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 3,
                        crossAxisSpacing: 3,
                        childAspectRatio: 2 / 3),
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: product.loadedProducts[i], child: ProductItem()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      previewChild: Flexible(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              color: Color(0xff7B4397),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: <Widget>[
              Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    SvgPicture.asset('images/bag.svg',
                        width: 30.0, height: 30.0, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Bag',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    Spacer(),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(bag.totalQuantity.toString()))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      expandedChild: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Color(0xff7B4397),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            children: <Widget>[
              Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Spacer(),
                    SvgPicture.asset('images/bag.svg',
                        width: 30.0, height: 30.0, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Bag',
                        style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    Spacer(),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(bag.totalQuantity.toString()))
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin:EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                child: Text('Tap an item for add, delete, remove options',style:TextStyle(fontWeight:FontWeight.w600))),
              SizedBox(
                height: 8,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: bag.items.length,
                    itemBuilder: (context, i) => BagItems(
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
        ),
      ),
      minExtent: 60,
    );
  }

  Widget appBar1(text) {
    return Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Row(
          children: [
            GestureDetector(onTap: () {}, child: Icon(Icons.arrow_back)),
            Spacer(),
            Text(text, style: TextStyle(fontFamily: 'proxima-Nova')),
            Spacer(),
          ],
        ));
  }

  Widget icons() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              backgroundColor: Colors.grey[350],
              child: SvgPicture.asset('images/sort.svg',
                  width: 20.0, height: 20.0)),
          SizedBox(width: 20.0),
          CircleAvatar(
            backgroundColor: Colors.grey[350],
            child: SvgPicture.asset('images/filter.svg',
                width: 20.0, height: 20.0),
          ),
          SizedBox(width: 20.0),
          GestureDetector(
            onTap: () {
              setState(() {
                if (expand == false) {
                  expand = true;
                } else {
                  expand = false;
                }
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.grey[350],
              child: SvgPicture.asset('images/search.svg',
                  width: 20.0, height: 20.0),
            ),
          )
        ],
      ),
    );
  }
}



