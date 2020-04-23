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


class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {
  
  Client _client;
  
  @override
  void initState() {
    _client = Client();
    getData();
  }

  Future<String> _loadAStudentAsset() async {
    return await rootBundle.loadString('assets/json_data.json');
  }
  
  getData()async{

    String jsonString = await _loadAStudentAsset();
    var jsonBody = json.decode(jsonString);
    List jsonData = jsonBody['data'];
    jsonData.forEach((municipio){
      if(municipio['municipio_distrito']== 'Madrid-Fuencarral-El Pardo'){
        print('------------------');
        print(municipio['fecha_informe']);
        print(municipio['casos_confirmados_totales']);
      }
    });

   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COVID-APP'),
      ),
      body: Container(),
    );
  }
}
