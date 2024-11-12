import 'package:flutter/material.dart';
import 'package:mobileqmspro_flutter/styles.dart';

class CustomDivider extends StatelessWidget {
  final String? title;
  final double height;

  const CustomDivider({super.key, required this.height, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: _myBoxDecoration(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(title ?? "", style: Styles.customDivider),
        ));
  }

  BoxDecoration _myBoxDecoration(BuildContext context) {
    return const BoxDecoration(
      color: Colors.black12,
      border: Border(
        bottom: BorderSide(
          color: Colors.grey,
        ),
        top: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  }
}
