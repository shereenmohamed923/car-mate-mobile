import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/authorization.dart';
import 'package:car_mate/screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarMate',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.white,
          //fontFamily: 'inter',
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            side: BorderSide(color: Colors.blue, width: 2),
            fixedSize: Size(140, 40),
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey[800],
            //disabledBackgroundColor: Colors.white,
          ))),
      home: authorizationScreen(),
      routes: {
        loginScreen.routeName: (ctx) => loginScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
    );
  }
}
//shereen mohamed
//gfjloh
