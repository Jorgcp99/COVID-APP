

import 'dart:collection';

import 'package:covid_app/data/chart.dart';
import 'package:covid_app/data/district.dart';
import 'package:covid_app/data/district_data.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';
import 'package:flutter/material.dart';

class MainPresenter{
  MainView _view;
  HttpRemoteRepository _remoteRepository;
  MainPresenter(this._view, this._remoteRepository);
  List<String> _days = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'];
  List<String> _months = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];
  HashMap _districts;


  String getFormattedDate(){
    int weekDay = DateTime.now().weekday;
    int yearMonth = DateTime.now().month;
    int monthDay= DateTime.now().day;
    return _days[weekDay-1] + ' ' + monthDay.toString() + ' de ' + _months[yearMonth-1];
  }

  getDistrictList()async{
    List<District> districtList = [];
    _districts = await _remoteRepository.getDistrictsList();
    _districts.values.toList().forEach((district){
       districtList.add(district);
     });
       print(districtList[0].name);
       _view.showDistrictList(districtList);
  }

  getChartsData(){
    List<Chart> charts = [Chart('Infectados', 36409, 1, Colors.yellow),Chart('Fallecidos', 8472, 0.15, Colors.red),Chart('Recuperados', 16320, 0.36, Color.fromRGBO(101, 199, 178, 1.0)), ];
    _view.showChartList(charts);
  }

  getDistrictInfo(String districtId) async{
    List<District> compareDistricts = await _remoteRepository.getDistrictInfo(districtId);
    String distId = compareDistricts[0].id;
    String distName= compareDistricts[0].name;
    int todayNewCases = compareDistricts[0].numCasos-compareDistricts[1].numCasos;
    int yesterdatNewCases = compareDistricts[1].numCasos-compareDistricts[2].numCasos;
    double differencePercentage = todayNewCases==yesterdatNewCases?0.0:(1- (todayNewCases/yesterdatNewCases))*100;
    print(todayNewCases);
    print(yesterdatNewCases);
    print(differencePercentage);
    _view.showSelectedDistrict(DistrictData(distId, distName, todayNewCases, yesterdatNewCases, differencePercentage));

  }
}

abstract class MainView{
  showDistrictList(List<District> districts);
  showChartList(List<Chart> charts);
  showSelectedDistrict(DistrictData district);
}