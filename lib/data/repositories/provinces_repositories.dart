

import 'dart:convert';

import '../data_source.dart';
import '../model/provinces_model.dart';
import '../model/regencies_model.dart';

class ProvinceRepository{
  var dataSource = DataSource();

  Future<List<ProvincesModel>> getProvinces() async{
    final result = await dataSource.loadProvinces();
    final jsonProvince = provincesFromJson(result);
    return jsonProvince;
  }

}