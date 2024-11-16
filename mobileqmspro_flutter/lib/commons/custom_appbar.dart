import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final String label;

  CustomAppBar(
      {super.key, Widget? title, Widget? goBackButton, required this.label})
      : super(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(246, 247, 249, 0.3),
                border: BorderDirectional(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    (goBackButton == null)
                        ? const SizedBox(height: 0)
                        : goBackButton,
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          verticalDirection: VerticalDirection.up,
                          children: <Widget>[
                            Container(
                              alignment: AlignmentDirectional.centerStart,
                              child: title,
                            ),
                            Container(
                                alignment: AlignmentDirectional.centerStart,
                                child: Text(label,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold)))
                          ]),
                    ),
                    //button
                  ],
                )),
          ),
        );
}
