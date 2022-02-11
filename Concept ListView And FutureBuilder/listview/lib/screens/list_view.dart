import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    //ListView builder only attemp to render rows that are actually visible on the screen.means it works
    //with exactly that data which are showing on the screen right now.
    return ListView.builder(
      itemCount: 1000,
      //when we fetch id from repository one by one. itemBuilder build then one bye one. which id will
      //come first then that id will build first
      itemBuilder: (context, int index) {
        //FutureBuilder works as like as Stream
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return Container(
              height: 100,
              child: snapshot.hasData
                ? Text("I am visible $index")
                : Text("I havent fetched data yet $index"),
            );
          },
        );
      },
    );
  }

  getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'hi',
    );
  }
}
