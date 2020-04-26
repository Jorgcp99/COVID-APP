
import 'dart:collection';
import 'dart:convert';

import 'package:covid_app/data/district.dart';
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

}