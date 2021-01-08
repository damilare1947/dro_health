import 'package:flutter/material.dart';

class BagItem with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String image;
  BagItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price,
      @required this.image});
}

class Bag with ChangeNotifier {
  Map<String, BagItem> _items = {};

  Map<String, BagItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  get totalAmountItem {
    var total = 0;
    _items.forEach((productId, BagItem) {
      total += BagItem.price * BagItem.quantity;
    });
    return total;
  }

  get totalQuantity {
    var total = 0;
    _items.forEach((productId, BagItem) {
      total += BagItem.quantity;
    });
    return total;
  }

  void removeSingleItem(String productId, int quantity) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => BagItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: quantity,
              price: existingCartItem.price,
              image: existingCartItem.image));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
addSingleItem(String productId, int price, String title, int quantity, String image){
 _items.update(
        productId,
        (existingItem) => BagItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
            image: existingItem.image),
      );
      notifyListeners();

}
  addItem(
      String productId, int price, String title, int quantity, String image) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => BagItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity + quantity,
            price: existingItem.price,
            image: existingItem.image),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => BagItem(
            id: DateTime.now().toString(),
            title: title,
            quantity: quantity,
            price: price,
            image: image),
      );
    }
    notifyListeners();
  }
}
