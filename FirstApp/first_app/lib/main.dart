//importing third party package not from dart library
import 'package:flutter/material.dart';

void main() {
  // assigned a instance of widget named Material(instance) and passing a
  //name parameter named home(name parameter)
  var app = MaterialApp(
      // also home parameter works routing by default
      home: Scaffold(
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add, // it is positonal argument not name parameter. Icon is exceptional from others
      ),
      onPressed: () {
        // (){} it is as like as a function
        print("Hi there!");
      },
    ),
    appBar: AppBar(
      title: Text("lets see some images!"),
    ),
  ));

  runApp(app);// it run a widget or some similar things
}



//
// //importing third party package not from dart library
// import 'package:flutter/material.dart';

// void main() {
//   // assigned a instance of widget named Material(instance) and passing a
//   //name parameter named home(name parameter)
//   var app = MaterialApp(
//     // also home parameter works routing by default
//     home: Text("Hi there!"), // assinged a text widget in name paremeter(home)
//   );

//   runApp(app);
// }
