import 'package:flutter/material.dart';
import 'package:scope_bloc_login/blocs/provider.dart';
import 'package:scope_bloc_login/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  build(context) {
    //when provider is created then we can acces instance of Bloc inside of our Provider
    //And all Widget will get instance of Bloc under MaterialApp.
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "bloc",
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),  
    );
  }
}
