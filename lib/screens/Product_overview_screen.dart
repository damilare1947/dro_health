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
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('Tap an item for add, delete, remove options')),
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

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home:
//           DraggableBottomSheetExample(title: 'Draggable Bottom Sheet Example'),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class DraggableBottomSheetExample extends StatelessWidget {
//   DraggableBottomSheetExample({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     List<IconData> icons = [
//       Icons.ac_unit,
//       Icons.account_balance,
//       Icons.adb,
//       Icons.add_photo_alternate,
//       Icons.format_line_spacing
//     ];

//     return Scaffold(
//         body: DraggableBottomSheet(
//       backgroundWidget: Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               appBar1('${product.length.toString()} item(s)'),
//               icons(),
//               if (expand)
//                 Container(
//                   margin: EdgeInsets.only(bottom: 20.0),
//                   child: TextField(
//                     controller: _searchQuery,
//                     decoration: InputDecoration(
//                         //labelText: "Search",
//                         //hintText: "Search",
//                         prefixIcon: Icon(Icons.search),
//                         suffixIcon: Icon(Icons.close),
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                   ),
//                 ),
//               Expanded(
//                 child: GridView.builder(
//                   itemCount: product.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 3,
//                       crossAxisSpacing: 3,
//                       childAspectRatio: 2 / 3),
//                   itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//                       value: product[i], child: ProductItem()),
//                 ),
//               ),
//               // DraggableBottomSheetExample(
//               //     title: 'Draggable Bottom Sheet Example')
//             ],
//           ),
//         ),
//       ),
//     ),
//       previewChild: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//             color: Colors.pink,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         child: Column(
//           children: <Widget>[
//             Container(
//               width: 40,
//               height: 6,
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(10)),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               'Drag Me',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: icons.map((icon) {
//                   return Container(
//                     width: 50,
//                     height: 50,
//                     margin: EdgeInsets.only(right: 16),
//                     child: Icon(
//                       icon,
//                       color: Colors.pink,
//                       size: 40,
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10)),
//                   );
//                 }).toList())
//           ],
//         ),
//       ),
//       expandedChild: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//             color: Colors.pink,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20), topRight: Radius.circular(20))),
//         child: Column(
//           children: <Widget>[
//             Icon(
//               Icons.keyboard_arrow_down,
//               size: 30,
//               color: Colors.white,
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             Text(
//               'Hey...I\'m expanding!!!',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//             Expanded(
//               child: GridView.builder(
//                   itemCount: icons.length,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) => Container(
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Icon(
//                           icons[index],
//                           color: Colors.pink,
//                           size: 40,
//                         ),
//                       )),
//             )
//           ],
//         ),
//       ),
//       minExtent: 150,
//       // maxExtent: MediaQuery.of(context).size.height * 0.8,
//     )
//     );
//   }
// }

class Product {
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

class SearchList extends StatefulWidget {
  SearchList({Key key}) : super(key: key);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  Widget appBarTitle = Text(
    "My Properties",
    style: TextStyle(color: Colors.white),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: Colors.orange,
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<Product> _list;
  List<Product> _searchList = List();

  bool _IsSearching;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    init();
  }

  void init() {
    //final products = Provider.of<Products>(context).loadedProducts;
    _list = List();
    _list.add(
      Product(
          id: 'p01',
          image: 'images/kezitil.png',
          productName: 'Kezitil Susp.',
          productDescription1: 'cerufoxime Axetil',
          productDescription2: 'oral suspension -125mg',
          price: 1820),
    );
    _list.add(
      Product(
          id: 'p02',
          image: 'images/kezitil_tab.png',
          productName: 'Kezitil',
          productDescription1: 'Cerufoxime Axetil',
          productDescription2: 'Tablet -250mg',
          price: 1140),
    );
    _list.add(
      Product(
          id: 'p03',
          image: 'images/garlic.png',
          productName: 'Garlic oil',
          productDescription1: 'Garlic oil',
          productDescription2: 'Soft gel-650mg',
          price: 385),
    );
    _list.add(
      Product(
          id: 'p04',
          image: 'images/folic_tab.jpg',
          productName: 'Folic-Acid(100)',
          productDescription1: 'Folic Acid',
          productDescription2: 'Tablet -5mg',
          price: 170),
    );
    _list.add(
      Product(
          id: 'p05',
          image: 'images/folic_acid_container.jpg',
          productName: 'Folic-Acid',
          productDescription1: 'Folic acid',
          productDescription2: 'oral suspension -125mg',
          price: 1820),
    );
    _searchList = _list;
  }

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);
    return Scaffold(
        key: key,
        appBar: buildBar(context),
        body: GridView.builder(
            itemCount: _searchList.length,
            itemBuilder: (context, index) {
              return Uiitem(_searchList[index]);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            )));
  }

  List<Product> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _searchList =
          _list; //_list.map((contact) =>  Uiitem(contact)).toList();
    } else {
      /*for (int i = 0; i < _list.length; i++) {
        String name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }*/

      _searchList = _list
          .where((element) =>
              element.productName
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()) ||
              element.productDescription1
                  .toLowerCase()
                  .contains(_searchText.toLowerCase()))
          .toList();
      print('${_searchList.length}');
      return _searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
    }
  }

  Widget buildBar(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: appBarTitle,
        iconTheme: IconThemeData(color: Colors.orange),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: Colors.orange,
                  );
                  this.appBarTitle = TextField(
                    controller: _searchQuery,
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                    decoration: InputDecoration(
                        hintText: "Search here..",
                        hintStyle: TextStyle(color: Colors.white)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color: Colors.orange,
      );
      this.appBarTitle = Text(
        "My Properties",
        style: TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
}

class Uiitem extends StatelessWidget {
  final Product product;
  Uiitem(this.product);

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 7),
      elevation: 10.0,
      child: InkWell(
        splashColor: Colors.orange,
        onTap: () {
          print(product.id);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18.0 / 11.0,
              child: Image.asset(
                product.image,
                fit: BoxFit.scaleDown,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    this.product.productName,
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                    maxLines: 1,
                  ),
                  SizedBox(height: 0.0),
                  Text(
                    product.productDescription1,
                    style: TextStyle(fontFamily: 'Roboto'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
