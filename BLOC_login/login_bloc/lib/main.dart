import 'package:flutter/material.dart';
import 'package:login_bloc/screens/login_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "bloc",
    home: LoginScreen(),
  ));
}