import 'package:flutter/material.dart';
import 'package:news_app/screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "News!",
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    //navigating just with the id = /$id
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name!.replaceFirst('/', ''));
        commentsBloc.fetchItemWithComments(itemId);
        return NewsDetail(
          itemId: itemId,
        );
      });
    }
  }
}
