import 'dart:convert';

import 'package:covid_app/municipio.dart';
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
      home: Covid(),
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
    List<Municipio> monte = [];
    jsonData.forEach((municipio){
      if(municipio['zona_basica_salud']== 'Montecarmelo'){
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
