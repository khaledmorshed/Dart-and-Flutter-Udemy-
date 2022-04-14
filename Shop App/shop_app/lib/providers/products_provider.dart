import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//mixin is lite version of extend(inheritence)
//it doesnt nedd to create instance inside of other class

//ChangeNotifier is kind of ingherited widget it helps behidn the scenne
//communicattion tunnel with the help of context object which we are getting
//in every widget
class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   //isFavorite: null,
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   //isFavorite: null,
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   //isFavorite: null,
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   //isFavorite: null,
    // ),
  ];

  // var _showFavoritesOnly = false;

  var authToken;
  var userId;
  ProductsProvider(this.authToken, this.userId, this._items);
  //var authToken = Auth().token;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   //it will automaticly be added into _item list bellow(i)
    //   return _items.where((productItem) => productItem.isFavorite!).toList();
    // }

    // List<Product> li = [];
    // li.addAll(_items);
    // return li;

    //(i)spread orperator for copying _item list into another list which is inside of item
    return [..._items];
  }

  List<Product> get favoritesItem {
    return _items.where((productItem) => productItem.isFavorite!).toList();
  }

  /*void showFavoritesOnly() {
    _showFavoritesOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoritesOnly = false;
    notifyListeners();
  }*/
  // var GdImage;
  // downloadImage(dImage) {
  //   print(
  //       "SJDKLAAAAAFDSLKAJFLKDSJFLKSDJAFDOSIFJLSDAFJSDIAJFOSADJIFLSADIJFSOIDAJFSODIJFSDIAJFSOIADJFSADIFOJSADFIJSADOFJSAFJAS + DWONLOADiMAGE :$dImage");
  //   GdImage = dImage;
  // }

  Product findById(String productId) {
    return _items.firstWhere((pro) => pro.id == productId);
  }

  Future<void> addProduct(Product product) async {
    print(
        "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ + userId and token in addProduct: $userId + $authToken");
    // final url = Uri.https(
    //      'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/', '/products.json');
    final uri1 =
        'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken';
    final url = Uri.parse(uri1);
    // print(
    //     "LFJDLKSFJSDLKFJLSDKAJFLKSDAJFLDSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKLKSDFKLASJFLKASJFLKSDJFLKSDJFSLADF + Provider + add : ${product.imageUrl}");
    try {
      //this for adding into firebase
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          // 'imageUrl': upImage,
          'imageUrl': product.imageUrl,
          'price': product.price,
          //it will store only server site not in local store
          'creatorId': userId,
          //'isFavorite': product.isFavorite,
        }),
      );
      //response.body == its a map with name key
      //print(json.decode(response.body));
      // //this for adding into loacally after adding into firebase
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        //it is autgenerated id from firebase which is actullay same as firebase and local store
        //thats why json.decode(response.body)['name'] so that two id stay same
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  //'[bool filterByUser = false]' == here [] means optional positional argument
  //[bool filterByUser = false] == here defalut value is false
  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
        print(
        "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ + userId and token in fethcProducts: $userId + $authToken");
    //this url for only all authenticate users because '?auth=$authToken' is used after json
    //$orderBy="creatorId"&equalTo="$userId == only that product will be fetched which products
    // are create by a specefic user
    //here if filterByUser is true then first part otherwise second part
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=$authToken&$filterString');
    try {
      //for getting authenticate token for other api(except firbase) need to
      //add get(url, header:)
      final response = await http.get(url);
      //print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == 0) {
        return;
      }
      //to get all the favorite data for a specific user
      url = Uri.parse(
          'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/userFavorites/$userId.json?auth=$authToken');
      //to get all the favorite data for a specific user
      final favoriteResponse = await http.get(url);
      //this data is map where key is productId and value is true or false
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          //if favoriteData == null then false otherwise value of favoriteData[prodId] Again
          //favoriteData[prodId] is not exist then take value false otherwise take value
          //of favoriteData[prodId]
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
          //isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateProduct(String p_id, Product overrideProduct) async {
        print(
        "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ + userId and token in updateProducts: $userId + $authToken");
    final productIndex = _items.indexWhere((prod) => prod.id == p_id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$p_id.json?auth=$authToken');
      print(
          "LFJDLKSFJSDLKFJLSDKAJFLKSDAJFLDSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKLKSDFKLASJFLKASJFLKSDJFLKSDJFSLADF + Provider + Upadate : ${overrideProduct.title}}");
      print(
          "LFJDLKSFJSDLKFJLSDKAJFLKSDAJFLDSAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAKLKSDFKLASJFLKASJFLKSDJFLKSDJFSLADF + Provider + Upadate : ${overrideProduct.imageUrl}}");
      //patch = it merger with existing data and update the data.
      http.patch(url,
          body: json.encode({
            'title': overrideProduct.title,
            'description': overrideProduct.description,
            'imageUrl': overrideProduct.imageUrl,
            // 'imageUrl': upDateImageUrl,
            'price': overrideProduct.price,
            //'isFavorite': overrideProduct.isFavorite,
            //here isFavorite not sending
          }));
      _items[productIndex] = overrideProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String productId) async {
        print(
        "QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ + userId and token in deleteProduct: $userId + $authToken");
    /* //this is easy way. may it not delete from memory
    final url = Uri.parse(
        'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$productId.json');
    http.delete(url);*/

    final url = Uri.parse(
        'https://shop-app-abd1c-default-rtdb.asia-southeast1.firebasedatabase.app/products/$productId.json?auth=$authToken');
    //this give us index of the product that we want to remove
    final _existingProductIndex =
        _items.indexWhere((prod) => prod.id == productId);
    //it is pointer to reference which we want to delete.it is for storing data when someone
    // want restore data then it is possible beacuse it still in memorey
    Product? _existingProduct = _items[_existingProductIndex];
    //it only deletes from the list not from memory.
    _items.removeAt(_existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    //print("LDLDFDFDFDFDFDFDF DFDFDFDFDFDFDJ + ${response.statusCode}");
    //throw Exception();//we can also write it which is build in
    if (response.statusCode >= 400) {
      _items.insert(_existingProductIndex, _existingProduct);
      notifyListeners();
      throw HttpException('Couldnt delete product');
    }
    //if not delete then it will restore
    //if delete it succed then set it null
    _existingProduct = null;
  }
}
