
import 'package:project_ktp/domain/entities/person_entity.dart';

abstract class PersonRepository {
  Future<void> savePerson(PersonEntity person);
  Future<List<PersonEntity>> getPersons();
  Future<void> updatePerson(PersonEntity person);
  Future<void> deletePerson(int key);
}
