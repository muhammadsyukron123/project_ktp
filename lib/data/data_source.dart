
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_ktp/data/model/provinces_model.dart';

class DataSource{

  Future<String> loadProvinces() async {
    String provinceToLoad = await rootBundle.loadString('assets/json/provinces.json');
    provincesFromJson(provinceToLoad);
    return provinceToLoad;
  }

  Future<String> loadRegencies() async {
    return await rootBundle.loadString('assets/json/regencies.json');
  }


}