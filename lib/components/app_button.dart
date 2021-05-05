import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const AppButton({
    Key key,
    @required this.label,
    @required this.icon,
    @required this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: this.onPressed,
      child: Center(
        child: Column(
          children: [
            Icon(
              this.icon,
              color: this.color,
              size: 40,
            ),
            Text(
              this.label,
              style: TextStyle(color: this.color),
            ),
          ],
        ),
      ),
    );
  }
}
