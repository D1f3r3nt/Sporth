import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:sporth/models/models.dart';

GoogleGeolocation googleGeolocationFromJson(String str) => GoogleGeolocation.fromJson(json.decode(str));

String googleGeolocationToJson(GoogleGeolocation data) => json.encode(data.toJson());

class GoogleGeolocation {
  GoogleGeolocation({
    required this.plusCode,
    required this.results,
    required this.status,
  });

  final PlusCode plusCode;
  final List<ResultGeolocation> results;
  final String status;

  GoogleGeolocation copyWith({
    PlusCode? plusCode,
    List<ResultGeolocation>? results,
    String? status,
  }) =>
      GoogleGeolocation(
        plusCode: plusCode ?? this.plusCode,
        results: results ?? this.results,
        status: status ?? this.status,
      );

  factory GoogleGeolocation.fromJson(Map<String, dynamic> json) => GoogleGeolocation(
        plusCode: PlusCode.fromJson(json["plus_code"]),
        results: List<ResultGeolocation>.from(json["results"].map((x) => ResultGeolocation.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "plus_code": plusCode.toJson(),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "status": status,
      };
}

class ResultGeolocation {
  ResultGeolocation({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.types,
    this.plusCode,
  });

  final List<AddressComponent> addressComponents;
  final String formattedAddress;
  final GeometryGeolocation geometry;
  final String placeId;
  final List<String> types;
  final PlusCode? plusCode;

  ResultGeolocation copyWith({
    List<AddressComponent>? addressComponents,
    String? formattedAddress,
    GeometryGeolocation? geometry,
    String? placeId,
    List<String>? types,
    PlusCode? plusCode,
  }) =>
      ResultGeolocation(
        addressComponents: addressComponents ?? this.addressComponents,
        formattedAddress: formattedAddress ?? this.formattedAddress,
        geometry: geometry ?? this.geometry,
        placeId: placeId ?? this.placeId,
        types: types ?? this.types,
        plusCode: plusCode ?? this.plusCode,
      );

  factory ResultGeolocation.fromJson(Map<String, dynamic> json) => ResultGeolocation(
        addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        formattedAddress: json["formatted_address"],
        geometry: GeometryGeolocation.fromJson(json["geometry"]),
        placeId: json["place_id"],
        types: List<String>.from(json["types"].map((x) => x)),
        plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
      );

  Map<String, dynamic> toJson() => {
        "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "formatted_address": formattedAddress,
        "geometry": geometry.toJson(),
        "place_id": placeId,
        "types": List<dynamic>.from(types.map((x) => x)),
        "plus_code": plusCode?.toJson(),
      };
}

class GeometryGeolocation {
  GeometryGeolocation({
    this.bounds,
    required this.location,
    this.locationType,
    required this.viewport,
  });

  final Viewport? bounds;
  final Location location;
  final LocationType? locationType;
  final Viewport viewport;

  GeometryGeolocation copyWith({
    Viewport? bounds,
    Location? location,
    LocationType? locationType,
    Viewport? viewport,
  }) =>
      GeometryGeolocation(
        bounds: bounds ?? this.bounds,
        location: location ?? this.location,
        locationType: locationType ?? this.locationType,
        viewport: viewport ?? this.viewport,
      );

  factory GeometryGeolocation.fromJson(Map<String, dynamic> json) => GeometryGeolocation(
        bounds: json["bounds"] == null ? null : Viewport.fromJson(json["bounds"]),
        location: Location.fromJson(json["location"]),
        locationType: locationTypeValues.map[json["location_type"]],
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "bounds": bounds?.toJson(),
        "location": location.toJson(),
        "location_type": locationTypeValues.reverse[locationType],
        "viewport": viewport.toJson(),
      };
}

enum LocationType { ROOFTOP, GEOMETRIC_CENTER, APPROXIMATE }

final locationTypeValues = EnumValues({"APPROXIMATE": LocationType.APPROXIMATE, "GEOMETRIC_CENTER": LocationType.GEOMETRIC_CENTER, "ROOFTOP": LocationType.ROOFTOP});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
