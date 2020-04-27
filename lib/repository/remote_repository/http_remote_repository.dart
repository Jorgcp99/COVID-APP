
import 'dart:collection';
import 'dart:convert';

import 'package:covid_app/data/district.dart';
import 'package:covid_app/data/global_data.dart';
import 'package:covid_app/repository/remote_repository/remote_repository.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show rootBundle;

class HttpRemoteRepository implements RemoteRepository{

  Client _client;

  HttpRemoteRepository(this._client);
  @override
  Future<HashMap<String, District>>  getDistrictsList() async{
    String jsonString = await rootBundle.loadString('assets/json_data.json');
    var jsonBody = json.decode(jsonString);
    HashMap districtsMap = HashMap<String, District>();
    List jsonData = jsonBody['data'];
    jsonData.forEach((district){
      var dist = District.fromMap(district);
      districtsMap.putIfAbsent(dist.id, ()=> dist);
      //print(districtsMap.values.toList()[0].name);

    });
    return districtsMap;
  }
  @override
  Future<List<District>> getDistrictInfo(String districtId)async{
    String jsonString = await rootBundle.loadString('assets/json_data.json');
    var jsonBody = json.decode(jsonString);
    List<District> districtList = [];
    List jsonData = jsonBody['data'];
    int cont = 0;
    jsonData.forEach((district){
      var dist = District.fromMap(district);
      if(dist.id == districtId && cont<3){
        districtList.add(dist);
        cont ++;
      }
    });
    return districtList;
  }

  @override
  Future<List<GlobalData>> getMadridInfo() async{
    String url = 'https://services7.arcgis.com/lTrEzFGSU2ayogtj/arcgis/rest/services/COMPLETA_Afectados_por_coronavirus_por_provincia_en_España_Vista_Solo_lectura/FeatureServer/0/query?where=CodigoProv%20%3D%20%2728%27&outFields=CodigoProv,Texto,Fecha,CasosConfirmados,Fallecidos,NombreCCAA,Recuperados,HoraActualizacion,Infectados,Hospitalizados,UCI,CreationDate,EditDate&returnGeometry=false&outSR=4326&f=json';
    var response = await _client.get(url);
    var jsonBody = json.decode(response.body);
    List daylyData = jsonBody['features'];
    List<GlobalData> dataList = [];
    daylyData.forEach((data){
      var attributes = data['attributes'];
      GlobalData daylyData = GlobalData.fromMap(attributes);
      dataList.add(daylyData);
    });
    return dataList;

  }


}