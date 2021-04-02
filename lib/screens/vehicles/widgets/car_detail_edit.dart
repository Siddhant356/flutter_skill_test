import 'package:flutter/material.dart';

class CarDetailEdit extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CarDetailEdit({@required this.label, @required this.controller}) : assert(label!=null), assert(controller!=null);
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Text("$label :", style: Theme.of(context).textTheme.subtitle1,), ),
      Expanded(
        flex: 1,
        child: TextField(
          textAlign: TextAlign.end,
          style: TextStyle(color: Theme.of(context).primaryColor),
          controller: controller,
        ),
      ),
    ]);
  }
}
