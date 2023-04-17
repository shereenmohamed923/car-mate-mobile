import 'package:flutter/material.dart';

class RentsScreen extends StatefulWidget {
  static const routeName = '/rents-screen';

  @override
  _RentsScreenState createState() => _RentsScreenState();
}

class _RentsScreenState extends State<RentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('rents page'),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
