import 'dart:async';
import 'package:login_bloc/blocs/validators.dart';

// Object is here root class of all classs in dart. Object doesn't havy any method
//class Bloc extends Validators{}// this is also right
//class Bloc extends Object with Validators {}//this is also right
class Bloc with Validators {
  // uderscore("_") == private
  final _emailController = StreamController<String /*can be dynamci*/ >();
  final _passwordController = StreamController<String>();

  //Add changed email == it may not be correct
  //Function(String) == optional
  //Change data to stream == it may be accurate
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //extract or retrieve or return data from stream == it may not be correct
  //Add data to stream after calling Validators class which data comes from TextField == it may be accurate
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);

  //when i create a StreamController dart alawys open up and check the value.
  // but don't want to stay up forever. so when we are done with the class Bloc
  // then we need to close it for clean up.
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

//signle gloabal instance for Applying a Bloc
final bloc = Bloc();
