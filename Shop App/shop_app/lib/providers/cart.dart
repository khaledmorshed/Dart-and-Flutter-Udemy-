import 'package:flutter/foundation.dart';

class CartItem {
  //cart id is different from the product id
  final String? id;
  final String? title;
  final int? quantity;
  final double? price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    var totalQuantity = 0;
    _items.forEach((key, cartItem) {
      totalQuantity += cartItem.quantity!;
    });
    return totalQuantity;

    //two are valid
    // return items.length;
    //return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price! * cartItem.quantity!;
    });
    return total;
  }

  void addItemIntoCart(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        //old Item = existingCartItem
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity! + 1,
        ),
      );
    }
    //first time added into CartItem
    else {
      _items.putIfAbsent(
        productId,
        //() =>CartItem() == it is a function for creating a value not taking a value inside of this
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }


  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItemFromCart(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity! > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity! - 1,
              ));
    } else {
      //if one product stay inside of cart
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
