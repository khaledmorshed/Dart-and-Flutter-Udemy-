import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  Widget build(context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),

        ),
      ],
    );
  }
  Widget buildContainer(){
    return Container(
      color: Colors.grey[200],
      height: 24,
      width:  150,
      margin: EdgeInsets.only(top: 5, bottom: 5),
    );
  }
}
