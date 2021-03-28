import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Vehicles extends StatefulWidget {
  static String tag = "/vehicles";

  @override
  _VehicleState createState() => _VehicleState();
}

class _VehicleState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vehicles Catalog'),
        ),
        //Replace the body to implement your own screen design
        body: Center(
          child: Text('No Vehicles Found!!', style: TextStyle(fontSize: 30.0)),
        )
    );
  }
}
