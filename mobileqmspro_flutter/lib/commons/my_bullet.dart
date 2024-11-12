import 'package:flutter/material.dart';

class MyBullet extends StatelessWidget {
  final Color? color;

  const MyBullet({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
