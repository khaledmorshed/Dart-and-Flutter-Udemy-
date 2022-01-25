//importing third party package not from dart library
import 'package:flutter/material.dart';

void main() {
  // assigned a instance of widget named Material(instance) and passing a
  //name parameter named home(name parameter)
  var app = MaterialApp(
    // also home parameter works routing by default
    home: Text("Hi there!"), // assinged a text widget in name paremeter(home)
  );

  runApp(app);
}
