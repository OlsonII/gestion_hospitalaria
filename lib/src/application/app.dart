
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_hospitalaria/src/presentation/pages/home_page.dart';

class App extends StatelessWidget {

  Map<int, Color> color =
  {
    50:Color.fromRGBO(78, 76, 173, .1),
    100:Color.fromRGBO(78, 76, 173, .2),
    200:Color.fromRGBO(78, 76, 173, .3),
    300:Color.fromRGBO(78, 76, 173, .4),
    400:Color.fromRGBO(78, 76, 173, .5),
    500:Color.fromRGBO(78, 76, 173, .6),
    600:Color.fromRGBO(78, 76, 173, .7),
    700:Color.fromRGBO(78, 76, 173, .8),
    800:Color.fromRGBO(78, 76, 173, .9),
    900:Color.fromRGBO(78, 76, 173, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Servicios Medicos',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF82B1FF, color),
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