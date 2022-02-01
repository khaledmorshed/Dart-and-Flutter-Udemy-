import 'package:flutter/material.dart';
import 'package:stateful_login/src/mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

// all the method inside of ValidationMixin now are copied to the LiginScreenState
class LoginScreenState extends State<LoginScreen> with ValidationMixin{
  // creating an instance of GlobalKey with generic
  final formKey = GlobalKey<FormState>();
  //intance variable
  String email = '';
  String password = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20),
      //Form widget acutally Stateful widget. when it will be called then it will not be dircet called.
      //First From widget call its FormSate object as like as Statfull widget.
      child: Form(
        key: formKey,
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
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: "Email Address", hintText: "you@example.com"),
      
      // not callin validateEmail function. it just passing the refernce of validateEmail to the validator
      validator: validateEmail,
      // dynamic is optional
      onSaved: (dynamic value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Password", hintText: "password"),
      validator: validatePassword,
      onSaved: (value) {
        password = value!;
      },
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        //formKey.currentState!.reset();
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          print("Time to post $email and $password to my API");
        }
      },
      child: Text("Submit"),
    );
  }
}
