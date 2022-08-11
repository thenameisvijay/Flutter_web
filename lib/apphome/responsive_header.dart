import 'package:flutter/material.dart';
import 'package:zensar_challenge/apphome/mobile_view.dart';
import 'package:zensar_challenge/apphome/web_view.dart';

class ResponsiveHeader extends StatelessWidget {
  const ResponsiveHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1200) {
        return const WebView();
      } else if (constraints.maxWidth > 800 && constraints.maxWidth < 1200) {
        return const WebView();
      } else {
        return const MobileView();
      }
    });
  }
}

