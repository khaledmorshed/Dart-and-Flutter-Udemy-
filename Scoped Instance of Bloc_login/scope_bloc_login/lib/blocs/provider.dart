import 'package:flutter/material.dart';
import 'bloc.dart';

class Provider extends InheritedWidget {
  // this for child class is Provider
  //this is actually normal contstrutor passing with some arguments.we are not passing data
  //directly.At first we pass our data to the super class InheritedWidget
  Provider({Key? key, required Widget child})
      : super(key: key, child: child); //this for super class is InheritedWidget

  bool updateShouldNotify(_) => true;
  final bloc = Bloc();

  //of(context)=  others bellow context of widget goes back until it
  //gets the instance of provider which stays most top position.And one more things a context of
  //widget knows its exact immidiate context and this immidiate knows its imidiate context
  //and so one.
  static Bloc of(context) {
    // it return of instance of provider.
    // And this instance of provider has the bloc property
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider).bloc;
    
    //Provider? provider = context.dependOnInheritedWidgetOfExactType<Provider>();
    //return provider!.bloc;
  }
}