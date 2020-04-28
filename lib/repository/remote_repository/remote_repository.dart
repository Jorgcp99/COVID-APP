

import 'dart:collection';

import 'package:covid_app/data/district.dart';
import 'package:covid_app/data/event.dart';
import 'package:covid_app/data/global_data.dart';

abstract class RemoteRepository{
  Future<HashMap<String, District>> getDistrictsList();
  Future<List<District>> getDistrictInfo(String districtId);
  Future<List<GlobalData>> getMadridInfo();
  Future<List<Event>> getEventsInfo();
}