import 'package:flutter/material.dart';
import 'package:mobflix/components/post.dart';
import 'package:mobflix/screens/edit_screen.dart';
import 'package:mobflix/screens/initial_screen.dart';
import 'package:mobflix/screens/form_post_screen.dart';


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
      initialRoute: "/initial_screen",
      routes: {
        "/initial_screen": (context) => InitialScreen(),
        "/post_screen": (context) => const FormPostScreen(),
      },
    );
  }
}