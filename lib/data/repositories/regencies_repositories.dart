

import 'package:project_ktp/data/data_source.dart';
import 'package:project_ktp/data/model/regencies_model.dart';

class RegenciesRepository{
  var dataSource = DataSource();

  Future<List<RegenciesModel>> getRegencies(String id) async{
    final result = await dataSource.loadRegencies();
    final List<RegenciesModel>jsonRegency = regenciesFromJson(result);
    final List<RegenciesModel> filteredRegency =
          jsonRegency.where((regency) => regency.provinceId == id).toList();
    return filteredRegency;
  }

}