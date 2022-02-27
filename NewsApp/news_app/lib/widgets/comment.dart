import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/loading_container.dart';
import '../models/item_model.dart';

class Comment extends StatelessWidget {
  int? itemId;
  Map<int, Future<ItemModel?>>? itemMap;
  //for nested comment
  final int? depth;

  Comment({this.itemId, this.itemMap, this.depth});

  Widget build(context) {
    return FutureBuilder(
      future: itemMap![itemId],
      builder: (context, AsyncSnapshot<ItemModel?> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        final children = <Widget>[
          //Text(snapshot.data!.text),
          ListTile(
            title: buildText(snapshot.data!),
            subtitle: snapshot.data!.by! == ""
                ? Text("Deleted")
                : Text(snapshot.data!.by!),
            contentPadding: EdgeInsets.only(
              right: 16,
              left: (depth! + 1) * 16,
            ),
          ),
          Divider(
            thickness: 2,
          ),
        ];
        snapshot.data!.kids!.forEach(
          (kidId) {
            children.add(
              Comment(
                itemId: kidId,
                itemMap: itemMap,
                depth: depth! + 1,
              ),
            );
          },
        );
        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel? item) {
    final text = item!.text!
        .replaceAll('&#x27;', "'")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
    return Text(text);
  }
}
