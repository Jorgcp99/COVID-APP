

import 'dart:collection';

import 'package:covid_app/data/district.dart';

abstract class RemoteRepository{
  Future<HashMap<String, District>> getDistrictsList();
}