import 'package:flutter/material.dart';
import 'package:mobflix/screens/dashboard.dart';
import 'package:mobflix/screens/form_post.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobflix',
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      initialRoute: "/dashboard",
      routes: {
        "/dashboard": (context) => const Dashboard(),
        "/post": (context) => const FormPost(),
      },
    );
  }
}
