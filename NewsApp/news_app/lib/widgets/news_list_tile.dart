import 'package:flutter/material.dart';
import 'package:news_app/models/item_model.dart';
import 'package:news_app/widgets/loading_container.dart';
import '../blocs/stories_provider.dart';
import 'dart:async';

//it has to know which id it is responsible for looking for.
//the ListView has to tell it hey you are responsible for showing item id 1 or id 2
//or id 3
//So I think that our Newsless tile is going to have to have an instance variable that will be
// passed in from the parent as a constructor argument.
// ignore: must_be_immutable
class NewsListTile extends StatelessWidget {
  //const NewsListTile({Key? key}) : super(key: key);
  int? itemId;

  NewsListTile({Key? key, this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }
        return FutureBuilder(
          future: snapshot.data![itemId],
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            //bloc.fetchItem(itemSnapshot.data.id);
            // if (itemSnapshot.data != null) {
            //   return Text("fdfdf : ${itemSnapshot.data}");
            // }
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }
            return buidlTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buidlTile(BuildContext context, ItemModel? item) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/${item!.id}');
          },
          title: Text(item!.title!),
          subtitle: Text("${item.score} points"),
          trailing: Column(
            children: [
              Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}
