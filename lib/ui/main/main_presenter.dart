import 'dart:collection';

import 'package:covid_app/data/district.dart';
import 'package:covid_app/data/district_data.dart';
import 'package:covid_app/data/global_data.dart';
import 'package:covid_app/data/global_show_info.dart';
import 'package:covid_app/repository/remote_repository/http_remote_repository.dart';
import 'package:flutter/material.dart';

class MainPresenter {
  MainView _view;
  HttpRemoteRepository _remoteRepository;

  MainPresenter(this._view, this._remoteRepository);

  List<String> _days = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];
  List<String> _months = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre'
  ];
  HashMap _districts;

  String getFormattedDate() {
    int weekDay = DateTime.now().weekday;
    int yearMonth = DateTime.now().month;
    int monthDay = DateTime.now().day;
    return _days[weekDay - 1] +
        ' ' +
        monthDay.toString() +
        ' de ' +
        _months[yearMonth - 1];
  }

  getDistrictList() async {
    List<District> districtList = [];
    _districts = await _remoteRepository.getDistrictsList();
    _districts.values.toList().forEach((district) {
      districtList.add(district);
    });
    print(districtList[0].name);
    _view.showDistrictList(districtList);
  }

  getDistrictInfo(String districtId) async {
    List<District> compareDistricts =
        await _remoteRepository.getDistrictInfo(districtId);
    String distId = compareDistricts[0].id;
    String distName = compareDistricts[0].name;
    int todayNewCases =
        compareDistricts[0].numCasos - compareDistricts[1].numCasos;
    int yesterdayNewCases =
        compareDistricts[1].numCasos - compareDistricts[2].numCasos;
    double differencePercentage = todayNewCases == yesterdayNewCases
        ? 0.0
        : (1 - (todayNewCases / yesterdayNewCases)) * 100;
    _view.showSelectedDistrict(DistrictData(distId, distName, todayNewCases,
        yesterdayNewCases, differencePercentage));
  }

  getGlobalData() async {
    List<GlobalData> data = await _remoteRepository.getMadridInfo();
    GlobalData currData = data[data.length - 3];
    int todayNewCases =
        currData.casosConfirmados - data[data.length - 4].casosConfirmados;
    int yesterdayNewCases = data[data.length - 4].casosConfirmados -
        data[data.length - 5].casosConfirmados;
    double differencePercentage = todayNewCases == yesterdayNewCases
        ? 0.0
        : (1 - (todayNewCases / yesterdayNewCases)) * 100;
    int totalCases = currData.casosConfirmados;

    int todayFallecidos = currData.fallecidos == data[data.length - 4].fallecidos?0:currData.fallecidos - data[data.length - 4].fallecidos;
    int todayRecuperados = currData.recuperados == data[data.length - 4].recuperados?0:currData.recuperados - data[data.length - 4].recuperados;
    print(currData.fallecidos);
    print(data[data.length-3].fallecidos);
    GlobalShowInfo globalData = GlobalShowInfo(
        todayNewCases,
        todayFallecidos,
        todayRecuperados,
        yesterdayNewCases,
        totalCases,
        differencePercentage,
        currData.fallecidos,
        currData.recuperados);
    _view.showGlobalData(globalData);
  }
}

abstract class MainView {
  showDistrictList(List<District> districts);

  showSelectedDistrict(DistrictData district);

  showGlobalData(GlobalShowInfo data);
}
