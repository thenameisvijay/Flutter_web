import 'package:flutter/material.dart';
import 'package:zensar_challenge/constant.dart';
import 'package:zensar_challenge/styles/themes.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key? key,
    this.titleText = 'Your Title',
    required this.child,
    this.showAppBar = true,
    this.showDrawer = false,
    this.showAppBarActions = false,
    this.enableDarkMode = false,
    // this.drawerChild,
    Widget? bottomSheet,
    this.actions,
    // this.actions,
  })  : _bottomSheet = bottomSheet,
        super(key: key);

  final String titleText;
  final Widget child;
  final bool showAppBar;
  final bool showAppBarActions;
  final bool showDrawer;
  final bool enableDarkMode;
  // final Widget drawerChild;
  final Widget? _bottomSheet;
  final List<Widget>? actions;

  /*List<Widget> get _showActions {
    if (showAppBarActions) {
      return actions;
    }

    return [];
  }*/

  @override
  Widget build(BuildContext context) {
    //

    return Theme(
      data: enableDarkMode
          ? ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: fontFamily,
        ),
      )
          : AppTheme.darkTheme,
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
          // actions: _showActions,
          title: Text(titleText),
        )
            : null,
        body: child,
        // endDrawer: showDrawer ? drawerChild : null,
        bottomSheet: _bottomSheet,
      ),
    );
  }
}
