import 'dart:async';

void main() {
  final bloc = new Bloc();
  // bloc.emailController.stream.listen((value) {
  //   print(value);
  // });
  bloc.email.listen((value) {
    print(value);
  });

  //(i)
  //bloc.emailController.sink.add("my new eamil");
  //instead of (i)
  bloc.changeEmail("my new email");
}

class Bloc {
  final emailController = StreamController<String>();
  final passwordController = StreamController<String>();

  //get is the shortened form of getter
  // get changeEmail {
  //   return emailController.sink.add;
  // }

  //it gives data to the stream. means change or add data.
  Function(String) get changeEmail => emailController.sink.add;//Function(String) = optional
  Function(String) get changePassword => passwordController.sink.add;

  //it retrieves or emits data from the stream email
  Stream<String> get email => emailController.stream;// Stream<String> = optional
  get password => passwordController.stream;
}
