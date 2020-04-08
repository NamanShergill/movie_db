import 'package:flutter/material.dart';
import 'package:movie_db/Frontend/list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.redAccent,
        primarySwatch: Colors.red,
      ),
      home: ListPage(),
    );
  }
}
