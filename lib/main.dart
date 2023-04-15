import 'package:car_mate/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/signup_screen.dart';
import './screens/signin_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: MaterialApp(
          title: 'CarMate',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.white,
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
          home: SignUpScreen(),
          routes: {
            SignUpScreen.routeName: (ctx) => SignUpScreen(),
            SignInScreen.routeName: (ctx) => SignInScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
          }),
    );
  }
}
