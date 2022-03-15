import 'package:flutter/material.dart';
import 'package:task_application/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books',
      initialRoute: 'home',
      routes: {
        'home'  : (BuildContext context) => HomePage(),
      },
    );
  } 
}