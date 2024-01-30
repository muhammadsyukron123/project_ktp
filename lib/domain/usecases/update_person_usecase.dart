import 'package:project_ktp/domain/entities/person_entity.dart';

import '../../data/repositories/person_repository.dart';

class UpdatePersonUseCase {
  final PersonRepository repository;

  UpdatePersonUseCase({required this.repository});

  Future<void> execute(PersonEntity person) async {
    await repository.updatePerson(person);
  }
}
