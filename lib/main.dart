import 'dart:convert';

import 'package:covid_app/municipio.dart';
import 'package:covid_app/ui/main/main_screen.dart';
import 'package:covid_app/ui/navigation/navigator_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: NavigationBar(),
    );
  }
}
