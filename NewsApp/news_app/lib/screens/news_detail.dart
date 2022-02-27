import 'dart:async';
import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/item_model.dart';
import '../widgets/comment.dart';

class NewsDetail extends StatelessWidget {
  late int itemId;
  NewsDetail({required this.itemId});
  Widget build(context) {
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Loading");
        }
        final itemFuture = snapshot.data![itemId];
        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("Loading");
            }
            return buildList(itemSnapshot.data!, snapshot.data!);
          },
        );
      },
    );
  }

  Widget buildList(ItemModel? item, Map<int, Future<ItemModel?>> itemMap) {
    //list of children
    final children = <Widget>[];
    children.add(buildTitle(item));
    //comment list
    //at first it stays inside of map then it is needed type casting with list
    final commentList = item!.kids!.map((kidId){
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();
    //just first level comment is added
    //addAll takes other list and add that list in children list
    children.addAll(commentList);

    return ListView(
      //children = list of widget
      children: children,
    );
  }

  Widget buildTitle(ItemModel? item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item!.title!,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
