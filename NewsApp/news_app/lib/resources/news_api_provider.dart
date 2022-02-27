//Client class use instead of get, put, delete etc
import 'package:http/http.dart' show Client;
//for decodeing  json into usable json data
import 'dart:convert';
import '../models/item_model.dart';
import 'dart:async';
import 'repository.dart';

// //https://github.com/HackerNews/API (github)
// //https://news.ycombinator.com/ (website)

class NewsApiProvider implements Source {
  // it is necessary.because although the function type is futute but it return type
  // is different from repository class and NewsApiProvider class
  @override
  Future<ItemModel?> fethcItem(int id){
    // TODO: implement fethcItem
    throw UnimplementedError();
    // ItemModel? n = await fetchItem(id);
    //  return n;
  }

  //for Declare Client classs here we create a instance of Client
  //this only for writing code inside of test folder of the right side.
  Client client = Client();
  Future<List<int>> fetchTopIds() async {
    var url = 'https://hacker-news.firebaseio.com/v0/topstories.json';
    //for fetching id from api
    final response = await client.get(Uri.parse(url));
    //for decoding
    //ids = list of integer
    final ids = json.decode(response.body);

    //and retuurn list of id that we fetched
    //And it is dart doesn't know what type of list. so for type casting
    return ids.cast<int>();
  }

  Future<ItemModel?> fetchItem(int id) async {
    var url = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final response = await client.get(Uri.parse(url));
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
