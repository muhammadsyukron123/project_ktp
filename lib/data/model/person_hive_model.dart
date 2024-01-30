
// File: person_hive_model.dart
import 'package:hive/hive.dart';
part 'person_hive_model.g.dart';

@HiveType(typeId: 0)
class PersonHiveModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String birthDate;

  @HiveField(2)
  late String province;

  @HiveField(3)
  late String regency;

  @HiveField(4)
  late String occupation;

  @HiveField(5)
  late String education;
}
