//this for we can add @required befor this.something
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool? isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  // void toggleFavoriteStatus() {
  //   isFavorite = !isFavorite!;
  //   //it acts as like setState
  //   notifyListeners();
  // }

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String? token, String? userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite!;
    notifyListeners();
    final url = Uri.parse(
        'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(url,
          body: json.encode(
             isFavorite,
          ));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus!);
      }
    } catch (error) {
      _setFavValue(oldStatus!);
    }
  }
}