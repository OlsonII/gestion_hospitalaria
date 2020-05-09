
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'ProductSans'
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home' : (BuildContext context) => HomePage()
      }
    );
  }
}