import 'package:flutter/material.dart';
import 'package:zensar_challenge/pagination/data_table.dart';
import 'package:zensar_challenge/ui/home/home_screen.dart';
import 'package:zensar_challenge/ui/main/body_container.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zensar Coding Challenge',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const HomeScreen(),
      // home: const DataTableScreen(),
      // home: const MainBody(),
    );
  }
}