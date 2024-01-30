// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonHiveModelAdapter extends TypeAdapter<PersonHiveModel> {
  @override
  final int typeId = 0;

  @override
  PersonHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonHiveModel()
      ..name = fields[0] as String
      ..birthDate = fields[1] as String
      ..province = fields[2] as String
      ..regency = fields[3] as String
      ..occupation = fields[4] as String
      ..education = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, PersonHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.birthDate)
      ..writeByte(2)
      ..write(obj.province)
      ..writeByte(3)
      ..write(obj.regency)
      ..writeByte(4)
      ..write(obj.occupation)
      ..writeByte(5)
      ..write(obj.education);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
