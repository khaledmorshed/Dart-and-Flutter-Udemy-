import 'package:flutter/material.dart';
import 'package:login_bloc/blocs/bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            emailField(),
            passwordField(),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    //stream take two name parameter stream and builder
    return StreamBuilder(
        //any time update or comes data into StreamBuilder through stream parameter
        //from stream(eamil/password variable) of Bloc class
        //bloc.email == inside of this data is stream. it is not extracted.like the data is not string or int etc.
        stream: bloc.email,
        //after comming data by stream builder run itself aumatically
        //And it return a widgets like TextField here
        builder: (context, snapshot) {
          return TextField(
            // onChanged: (newEmail) {
            //   bloc.changeEmail(newEmail);
            // },
            //1.onChange function takes new value or email and it sents _emailController.sink.add in Bloc Class
            //2.here if user types then in onChanged chageEmail is called which has sink.add and it 
            //forwards the  new data into stream. the stream sent data into our transformer. And 
            //transformer emits the stream with valid data and this stream is caught  
            //by "stream: bloc.email".Finaly StreamBuilder calls the bulider function agian.
            //Actually when user types then this input continuously is added in sink.add And it sents
            //the data continously into our streamTransformer who also continuosly response that Actually
            // data is valid or not
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "you@example.com",
              //labelText: "Email Address",
              label: Text("Email Address"),
              //InputDecoration takes errText from stream
              //snapshot extract the type may be. here snaptshot is object
              errorText: snapshot.error?.toString(),
            ),
          );
        });
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "password",
             label: Text("Password"),
            errorText: snapshot.error?.toString(),
          ),
        );
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Login"),
    );
  }
}
