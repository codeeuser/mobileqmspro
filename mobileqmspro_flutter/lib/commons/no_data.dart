import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String? message;

  const NoData({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            (message != null)
                ? Text('$message',
                    style: Theme.of(context).textTheme.headlineMedium)
                : const SizedBox(height: 0),
            const Icon(CupertinoIcons.nosign,
                size: 100, color: Colors.red, semanticLabel: 'No Data'),
            const Center(
              child: SizedBox(
                  width: 200,
                  child: Text(
                      'Oop!  Look like we don\'t have any data to show you.',
                      textAlign: TextAlign.center)),
            )
          ],
        ),
      ),
    );
  }
}
