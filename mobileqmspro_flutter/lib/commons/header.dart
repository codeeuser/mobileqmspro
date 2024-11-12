import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:mobileqmspro_flutter/generated/l10n.dart';
import 'package:mobileqmspro_flutter/utils/functions.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 50, right: 50, top: 30, bottom: 50),
              width: MediaQuery.of(context).size.width,
              color: Colors.yellow,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(S.of(context).title,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 40)),
                      ),
                      Text('v2.0',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.apply(color: Colors.black)),
                    ],
                  )),
            ),
          ),
          Utils.buildDesc(20),
        ],
      ),
    );
  }
}
