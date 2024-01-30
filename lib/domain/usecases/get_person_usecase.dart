// File: get_person_usecase.dart
import 'package:project_ktp/domain/entities/person_entity.dart';

import '../../data/repositories/person_repository.dart';

class GetPersonUseCase {
  final PersonRepository repository;

  GetPersonUseCase({required this.repository});

  Future<List<PersonEntity>> execute() async {
    return await repository.getPersons();
  }
}
