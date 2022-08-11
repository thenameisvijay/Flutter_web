import 'package:flutter/material.dart';

import 'package:zensar_challenge/constant.dart';

class MobileView extends StatelessWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: leftPadding),
    child: Row(
      children: <Widget>[
        Container(
          child: const Text(
            "Coding Challenge",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: logoTitle),
          ),
        )
      ],
    ));
  }
}