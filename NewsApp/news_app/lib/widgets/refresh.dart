import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class Refresh extends StatelessWidget {
  Widget child;
  Refresh({required this.child});
  Widget build(context) {
    //to connect with stories_bloc
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      onRefresh: () async {
        await bloc.clearCache();
        await bloc.fetchTopIds();
      },
      child: child,
    );
  }
}
