import 'package:flutter/material.dart';
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

  // a build method build a widget and return a widget
  Widget build(context) {
    return MaterialApp(
        home: Scaffold(
          body: Text("$counter"),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          // setState method is provide to our app state class when we extend the state base class.
          setState(() {
            counter += 1;
          });
        },
      ),
      appBar: AppBar(
        title: Text("lets see some images!"),
      ),
    ));
  }
}
