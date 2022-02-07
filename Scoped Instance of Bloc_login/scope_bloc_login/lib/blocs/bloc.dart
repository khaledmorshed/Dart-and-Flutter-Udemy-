import 'dart:async';
import 'package:scope_bloc_login/blocs/validator.dart';
// third party package which combine all stream into an one stream
import 'package:rxdart/rxdart.dart';

// Object is here root class of all classs in dart. Object doesn't havy any method
//class Bloc extends Validators{}// this is also right
//class Bloc extends Object with Validators {}//this is also right
class Bloc with Validators {
  // uderscore("_") == private
  //There are two kinds of streams: "Single-subscription" streams and "broadcast" streams.
  //BehaviorSubject = A special StreamController that captures the latest item that
  //has been added to the controller.
  //And BehaviorSubject is, by default, a broadcast
  //controller, in order to fulfill the Rx Subject contract. This means the Subject's stream can
  //be listened to multiple times.
  // here broadcast() controller not necessasy when we use BehaviorSubject
  //BehaviorSubject == StreamController .but some features has less in StreamController
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Add changed email == it may not be correct
  //Function(String) == optional
  //Change data to stream == it may be accurate
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //extract or retrieve or return data from stream == it may not be correct
  //Add data to stream after calling Validators class which data comes from TextField == it may be accurate
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  //combine two stream into an one stream
  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (e, p) => true);

  // we will pass latest email and password into our submit button
  //And latest email and password comes from BehaviorSubject
  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print("email is $validEmail");
    print("password is $validPassword");
  }

  //when i create a StreamController dart alawys open up and check the value.
  // but don't want to stay up forever. so when we are done with the class Bloc
  // then we need to close it for clean up.
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}
