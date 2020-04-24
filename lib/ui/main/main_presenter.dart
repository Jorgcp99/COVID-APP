

import 'dart:collection';

import 'package:covid_app/data/district.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';

class MainPresenter{
  MainView _view;
  HttpRemoteRepository _remoteRepository;
  MainPresenter(this._view, this._remoteRepository);
  List<String> _days = ['Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado', 'Domingo'];
  List<String> _months = ['enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio', 'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre'];

  String getFormattedDate(){
    int weekDay = DateTime.now().weekday;
    int yearMonth = DateTime.now().month;
    int monthDay= DateTime.now().day;
    return _days[weekDay-1] + ' ' + monthDay.toString() + ' de ' + _months[yearMonth-1];
  }

  getDistrictList()async{
    print('-----------');
    List<District> districtList = [];
     HashMap districts = await _remoteRepository.getDistrictsList();
     districts.values.toList().forEach((district){
       districtList.add(district);
     });
       print(districtList[0].name);
       _view.showDistrictList(districtList);


  }
}

abstract class MainView{
  showDistrictList(List<District> districts);
}