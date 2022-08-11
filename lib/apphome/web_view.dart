import 'package:flutter/material.dart';

import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/ui/main/body_container.dart';

class WebView extends StatelessWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: defaultPadding, horizontal: leftPadding),
    child: Column(
      children: <Widget>[
        Container(
          child: const Text(
            "Coding Challenge",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: logoTitle),
          ),
        ),
        const MainBody()
      ],
    ));
  }
}