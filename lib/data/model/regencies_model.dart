
import 'dart:convert';

List<RegenciesModel> regenciesFromJson(String str) => List<RegenciesModel>.from(json.decode(str).map((x) => RegenciesModel.fromJson(x)));

String regenciesToJson(List<RegenciesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegenciesModel{
  String id;
  String provinceId;
  String name;
  String altName;
  double latitude;
  double longitude;

  RegenciesModel({
    required this.id,
    required this.provinceId,
    required this.name,
    required this.altName,
    required this.latitude,
    required this.longitude,
  });

  factory RegenciesModel.fromJson(Map<String, dynamic> json) => RegenciesModel(
    id: json["id"],
    provinceId: json["province_id"],
    name: json["name"],
    altName: json["alt_name"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "province_id": provinceId,
    "name": name,
    "alt_name": altName,
    "latitude": latitude,
    "longitude": longitude,
  };

}