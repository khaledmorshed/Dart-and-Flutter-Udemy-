import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import './cart.dart';
import 'dart:convert';

class OrderItem {
  final String? id;
  final double? amount;
  final List<CartItem>? products;
  final DateTime? dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  var authToken;
   var userId;

  Orders(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');

    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      //json have a map
      body: json.encode({
        'amount': total,
        //toIso8601String a uniform string representation of dates which can later easily convert back into
        //a datetime object
        'dateTime': timestamp.toIso8601String(),
        //our products actually a list that can be encoded to json just like a map.
        //'products': []
        //but that list here now needs to have our cartProducts.Now cartProducts is a list
        // but a list of cart items and we need to map these cart items into maps and
        //not have objects.So here, I will use cartProducts.map and then you call to list to get
        // a list again and in map, we get a function which runs on every cp,
        // on every cart product and there, I want to now return a new map, so
        //convert my objects here based on cart item into maps

        //convert my objects here based on cartItem into map
        'products': cartProducts
            .map((cart_product) => {
                  //it is as like as cartItem inot cart.dart
                  'id': cart_product.id,
                  'title': cart_product.title,
                  'quantity': cart_product.quantity,
                  'price': cart_product.price,
                })
            .toList(),
      }),
    );

    //'insert function' add at first inside of list and 'add function' insert at end
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }

  //fetch order
  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    //print(json.decode(response.body));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == 0) {
      return;
    }
    final List<OrderItem> loaderOrders = [];
    extractedData.forEach((orderId, orderData) {
      loaderOrders.add(OrderItem(
        id: orderId,
        amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['dateTime']),
        products: (orderData['products'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  quantity: item['quantity'],
                  price: item['price'],
                ))
            .toList(),
      ));
    });
    //it will set the lates order in top
    _orders = loaderOrders.reversed.toList();
    notifyListeners();
  }
}
