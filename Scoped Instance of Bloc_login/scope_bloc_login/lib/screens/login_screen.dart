import 'package:flutter/material.dart';
import 'package:scope_bloc_login/blocs/bloc.dart';
import 'package:scope_bloc_login/blocs/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //this is instance of Prvider.And it connect the all uper series of context such as MyApp
    //is connected with LoginScreen through the context
    final bloc = Provider.of(context);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            emailField(bloc),
            passwordField(bloc),
            Container(
              margin: EdgeInsets.only(top: 20),
            ),
            submitButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.email,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextField(
            onChanged: bloc.changeEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "you@example.com",
              label: Text("Email Address"),
              errorText: snapshot.error?.toString(),
            ),
          );
        });
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, AsyncSnapshot<String> snapshot) {
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

  Widget submitButton(Bloc bloc) {
    //var value = null;
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          child: Text("Login"),
          // onPressed: snapshot.hasError
          //     ? null
          //     : () {
          //         print("Hi there");
          //       },

          //snapshot.hasData = At first it checks that the data is present or not..then it will
          // check the error
          onPressed: snapshot.hasData ? bloc.submit : null,
        );
      },
    );
  }
}
