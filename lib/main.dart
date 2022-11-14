import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/utilities/colors_and_vars.dart';
import 'screens/form_post_screen.dart';
import 'screens/initial_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Mobflix',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: stanColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
        fontFamily: 'Roboto',
        primaryColor: Colors.blue.shade600,
        brightness: Brightness.dark,
      ),
      initialRoute: "/initial_screen",
      routes: {
        "/initial_screen": (context) => InitialScreen(),
        "/form_screen": (context) => const FormPostScreen(),
      },
    );
  }
}
