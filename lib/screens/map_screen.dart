import 'package:flutter/material.dart';

class MapScreeen extends StatefulWidget {
  const MapScreeen({Key key}) : super(key: key);
  static const routeName = '/map-screen';

  @override
  _MapScreeenState createState() => _MapScreeenState();
}

class _MapScreeenState extends State<MapScreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text('maps page'),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
