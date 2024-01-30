
import 'package:project_ktp/domain/entities/person_entity.dart';

import '../../data/repositories/person_repository.dart';

class AddPersonUseCase {
  final PersonRepository repository;

  AddPersonUseCase({required this.repository});

  Future<void> execute(PersonEntity person) async {
    await repository.savePerson(person);
  }
}
