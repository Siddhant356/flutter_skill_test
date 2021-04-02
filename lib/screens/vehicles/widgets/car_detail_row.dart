import 'package:flutter/material.dart';

class CarDetailRow extends StatelessWidget {
  final String label;
  final String data;

  const CarDetailRow({@required this.label, @required this.data})
      : assert(label != null),
        assert(data != null);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.75)),
            ),
          ),
          SizedBox(width: 50,),
          Expanded(
            flex: 1,
            child: Text(
              data,
              style: TextStyle(fontSize: 20, color: Colors.black.withOpacity(0.75),
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
