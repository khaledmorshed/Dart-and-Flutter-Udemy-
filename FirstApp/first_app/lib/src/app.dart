import 'dart:convert';

import 'package:flutter/material.dart';
//if i just decleare http it will import all functionality inside of http but
//when we just mention that we need get function then we can write as like bellow code
import 'package:http/http.dart' show get;
import 'model/image_model.dart';
// it contains the json object
import 'dart:convert';
import 'widgets/image_list.dart';
// what is widget?

// a widget not only a concept of something that controls some elements that it gets
// displayed on the screen of our mobile device but it's also a class.
//in flutter there is a class called widget and it contains a bunch of functions
//and different instance  variable that assisted in showing some content on the screen
// of our device

// this class is widget class
class App extends StatefulWidget {
  createState() {
    return AppState();
  }
}

// this class is widget state class
class AppState extends State<App> {
  //instance variable
  int counter = 0;
  List<ImageModel> images = [];

  Future fetchImage() async {
    counter++;
    var url = "http://jsonplaceholder.typicode.com/photos/";
    var response = await get(Uri.parse(url + "$counter"));

    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      images.add(imageModel);
    });
  }

  // a build method build a widget and return a widget
  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
      body: ImageList(images),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        // no parenthis need to call fetchImage function.
        // if I do then it means build widget calling fetchImage function that we don't want
        // now it is under of FloatingActionbutton
        onPressed: fetchImage,
      ),
      appBar: AppBar(
        title: Text("lets see some images!"),
      ),
    ));
  }
}