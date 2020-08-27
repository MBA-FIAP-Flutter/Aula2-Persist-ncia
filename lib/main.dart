import 'package:flutter/material.dart';
import 'package:flutter_fiap_aula_2_bd/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //rotas nomeadas
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //'/sqlite': (context) => ListPersons(),
        //'/nosql': (context) => ListBooks(),
        //'/firebase': (context) => ListCars(),
      },
    );
  }
}

