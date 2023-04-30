import 'dart:convert';

List<LogrosAsset> logrosAssetFromJson(String str) => List<LogrosAsset>.from(
    json.decode(str).map((x) => LogrosAsset.fromJson(x)));

String logrosAssetToJson(List<LogrosAsset> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogrosAsset {
  final int id;
  final String name;
  final String description;
  final String image;

  LogrosAsset({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  LogrosAsset copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
  }) =>
      LogrosAsset(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        image: image ?? this.image,
      );

  factory LogrosAsset.fromJson(Map<String, dynamic> json) => LogrosAsset(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
      };
}
