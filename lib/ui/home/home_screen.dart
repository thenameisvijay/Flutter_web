import 'package:flutter/material.dart';
import 'package:zensar_challenge/apphome/responsive_header.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(195, 20, 50, 1.0),
              Color.fromRGBO(36, 11, 54, 1.0)])),
      child: Scaffold(
          // By defaut, Scaffold background is white
          // Set its value to transparent
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: const [
                ResponsiveHeader(),
                Padding(padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0)),
              ],
            ),
          )),
    );
  }
}