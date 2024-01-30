import 'dart:convert';

import 'package:project_ktp/data/datasource/data_source.dart';


DataSource dataSource = DataSource();

List<ProvincesModel> provincesFromJson(String str) => List<ProvincesModel>.from(json.decode(str).map((x) => ProvincesModel.fromJson(x)));

String provincesToJson(List<ProvincesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProvincesModel{
  String id;
  String name;
  String altName;
  double latitude;
  double longitude;

  ProvincesModel({
    required this.id,
    required this.name,
    required this.altName,
    required this.latitude,
    required this.longitude,
  });

  factory ProvincesModel.fromJson(Map<String, dynamic> json) => ProvincesModel(
    id: json["id"],
    name: json["name"],
    altName: json["alt_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alt_name": altName,
    "latitude": latitude,
    "longitude": longitude,
  };

}