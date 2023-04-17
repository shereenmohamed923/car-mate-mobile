import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  static const routeName = '/market-screen';

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('market page'),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
