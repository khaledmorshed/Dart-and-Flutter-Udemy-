import 'package:flutter/material.dart';
import 'stories_bloc.dart';
//when export a class inside of another class.And if we import that another class inside 
//of one more another class then a export class will not be necessay to import that one 
//more another class
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  StoriesBloc bloc;
  StoriesProvider({Key? key, required Widget child})
      : bloc = StoriesBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static StoriesBloc of(context){
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>()
     as StoriesProvider).bloc;
  }
}