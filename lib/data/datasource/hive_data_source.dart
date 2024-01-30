// Dalam file hive_data_source.dart
import 'package:hive/hive.dart';
import 'package:project_ktp/data/model/person_hive_model.dart';

class HiveDataSource {
  static const String boxName = 'persons';

  Future<void> init() async {
    await Hive.openBox<PersonHiveModel>(boxName);
  }

  Future<void> savePerson(PersonHiveModel person) async {
    final box = await Hive.openBox<PersonHiveModel>(boxName);
    await box.add(person);
  }

  Future<List<PersonHiveModel>> getPersons() async {
    final box = await Hive.openBox<PersonHiveModel>(boxName);
    return box.values.toList();
  }

  Future<void> updatePerson(PersonHiveModel person) async {
    final box = await Hive.openBox<PersonHiveModel>(boxName);
    await box.put(person.key, person);
  }

  Future<void> deletePerson(int key) async {
    final box = await Hive.openBox<PersonHiveModel>(boxName);
    await box.delete(key);
  }
}
