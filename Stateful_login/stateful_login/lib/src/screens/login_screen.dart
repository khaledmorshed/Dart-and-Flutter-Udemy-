import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
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

      //At fist FormState call the validate() function and validate() function call the all property
      //of Form widget such as here are Two TextFormField.And TextFormField call validator name
      //parameter which is kind of function
      //validoto function return null if valid.ohtherwise return an error massage
      validator: (value) {
        //here value comes from the user when one writes inside textfield
        if (!value!.contains('@')) {
          return "please enter a valid email";
        }
        //it is optional
        return null;
      },
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
      validator: (value) {
        if (value!.length < 4) {
          return "Password must be at least 4 characters";
        }
      },
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
