import 'package:car_mate/providers/auth.dart';
import 'package:car_mate/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';

import 'screens/signup_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/market_screen.dart';
import 'screens/map_screen.dart';
import 'screens/rents_screen.dart';
import 'screens/user_profile_screen.dart';
import 'screens/forget_password_screen.dart';
import 'screens/reset_password_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Product(),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
              title: 'CarMate',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  accentColor: Colors.grey[800],
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
              home: auth.isAuth ? TabsScreen() : SignInScreen(),
              routes: {
                SignUpScreen.routeName: (ctx) => SignUpScreen(),
                SignInScreen.routeName: (ctx) => SignInScreen(),
                TabsScreen.routeName : (ctx) => TabsScreen(),
                MapScreeen.routeName: (ctx) => MapScreeen(),
                ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
                RentsScreen.routeName: (ctx) => RentsScreen(),
                UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
                forget_password_screen.routeName:(ctx)  => forget_password_screen(),
                reset_password_screen.routeName:(ctx)  => reset_password_screen(),
                
              }),
        ));
  }
}
