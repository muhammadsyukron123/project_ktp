

import 'package:project_ktp/data/model/provinces_model.dart';

import '../../data/repositories/provinces_repositories.dart';

class GetProvincesUseCase {
  var repository = ProvinceRepository();

  Future<List<ProvincesModel>> execute() async {
    final result = await repository.getProvinces();
    return result;
  }
}