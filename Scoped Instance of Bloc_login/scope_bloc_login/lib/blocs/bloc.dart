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
  final _emailController = StreamController<String /*can be dynamci*/ >.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  //Add changed email == it may not be correct
  //Function(String) == optional
  //Change data to stream == it may be accurate
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //extract or retrieve or return data from stream == it may not be correct
  //Add data to stream after calling Validators class which data comes from TextField == it may be accurate
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  //combine two stream into an one stream
  Stream<bool> get submitValid => Rx.combineLatest2(email, password, (e, p)=> true);

  //when i create a StreamController dart alawys open up and check the value.
  // but don't want to stay up forever. so when we are done with the class Bloc
  // then we need to close it for clean up.
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

