import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const CustomIconButton({@required this.icon, @required this.onPressed}) : assert(icon != null), assert(onPressed!=null);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).accentColor.withOpacity(0.75),
      ),
      child: Center(
        child: IconButton(
          icon: Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          onPressed: onPressed,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
