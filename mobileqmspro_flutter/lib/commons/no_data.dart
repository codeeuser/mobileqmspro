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
            const Icon(CupertinoIcons.nosign,
                size: 100, color: Colors.red, semanticLabel: 'No Data'),
            const SizedBox(height: 30),
            (message != null)
                ? Center(
                    child: Text('$message',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium),
                  )
                : const Center(
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
