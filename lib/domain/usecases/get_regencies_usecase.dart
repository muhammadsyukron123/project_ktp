

import 'package:project_ktp/data/model/regencies_model.dart';
import 'package:project_ktp/data/repositories/regencies_repositories.dart';

class GetRegenciesUseCase {
  var repository = RegenciesRepository();

  Future<List<RegenciesModel>> execute(String id) async {
    final result = await repository.getRegencies(id);
    return result;
  }
}