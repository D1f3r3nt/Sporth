// To parse this JSON data, do
//
//     final googleAutocomplete = googleAutocompleteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GoogleAutocomplete googleAutocompleteFromJson(String str) => GoogleAutocomplete.fromJson(json.decode(str));

String googleAutocompleteToJson(GoogleAutocomplete data) => json.encode(data.toJson());

class GoogleAutocomplete {
  GoogleAutocomplete({
    required this.predictions,
    required this.status,
  });

  final List<GooglePlaceAutocomplete> predictions;
  final String status;

  GoogleAutocomplete copyWith({
    List<GooglePlaceAutocomplete>? predictions,
    String? status,
  }) =>
      GoogleAutocomplete(
        predictions: predictions ?? this.predictions,
        status: status ?? this.status,
      );

  factory GoogleAutocomplete.fromJson(Map<String, dynamic> json) => GoogleAutocomplete(
        predictions: List<GooglePlaceAutocomplete>.from(json["predictions"].map((x) => GooglePlaceAutocomplete.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
        "status": status,
      };
}

class GooglePlaceAutocomplete {
  GooglePlaceAutocomplete({
    required this.description,
    required this.matchedSubstrings,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
    required this.terms,
    required this.types,
  });

  final String description;
  final List<MatchedSubstring> matchedSubstrings;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;
  final List<Term> terms;
  final List<String> types;

  GooglePlaceAutocomplete copyWith({
    String? description,
    List<MatchedSubstring>? matchedSubstrings,
    String? placeId,
    String? reference,
    StructuredFormatting? structuredFormatting,
    List<Term>? terms,
    List<String>? types,
  }) =>
      GooglePlaceAutocomplete(
        description: description ?? this.description,
        matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
        placeId: placeId ?? this.placeId,
        reference: reference ?? this.reference,
        structuredFormatting: structuredFormatting ?? this.structuredFormatting,
        terms: terms ?? this.terms,
        types: types ?? this.types,
      );

  factory GooglePlaceAutocomplete.fromJson(Map<String, dynamic> json) => GooglePlaceAutocomplete(
        description: json["description"],
        matchedSubstrings: List<MatchedSubstring>.from(json["matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        structuredFormatting: StructuredFormatting.fromJson(json["structured_formatting"]),
        terms: List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "matched_substrings": List<dynamic>.from(matchedSubstrings.map((x) => x.toJson())),
        "place_id": placeId,
        "reference": reference,
        "structured_formatting": structuredFormatting.toJson(),
        "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class MatchedSubstring {
  MatchedSubstring({
    required this.length,
    required this.offset,
  });

  final int length;
  final int offset;

  MatchedSubstring copyWith({
    int? length,
    int? offset,
  }) =>
      MatchedSubstring(
        length: length ?? this.length,
        offset: offset ?? this.offset,
      );

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) => MatchedSubstring(
        length: json["length"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "offset": offset,
      };
}

class StructuredFormatting {
  StructuredFormatting({
    required this.mainText,
    required this.mainTextMatchedSubstrings,
    required this.secondaryText,
    this.secondaryTextMatchedSubstrings,
  });

  final String mainText;
  final List<MatchedSubstring> mainTextMatchedSubstrings;
  final String secondaryText;
  final List<MatchedSubstring>? secondaryTextMatchedSubstrings;

  StructuredFormatting copyWith({
    String? mainText,
    List<MatchedSubstring>? mainTextMatchedSubstrings,
    String? secondaryText,
    List<MatchedSubstring>? secondaryTextMatchedSubstrings,
  }) =>
      StructuredFormatting(
        mainText: mainText ?? this.mainText,
        mainTextMatchedSubstrings: mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
        secondaryText: secondaryText ?? this.secondaryText,
        secondaryTextMatchedSubstrings: secondaryTextMatchedSubstrings ?? this.secondaryTextMatchedSubstrings,
      );

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) => StructuredFormatting(
        mainText: json["main_text"],
        mainTextMatchedSubstrings: List<MatchedSubstring>.from(json["main_text_matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
        secondaryText: json["secondary_text"],
        secondaryTextMatchedSubstrings: json["secondary_text_matched_substrings"] == null ? null : List<MatchedSubstring>.from(json["secondary_text_matched_substrings"].map((x) => MatchedSubstring.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "main_text": mainText,
        "main_text_matched_substrings": List<dynamic>.from(mainTextMatchedSubstrings.map((x) => x.toJson())),
        "secondary_text": secondaryText,
        "secondary_text_matched_substrings": secondaryTextMatchedSubstrings == null ? null : List<dynamic>.from(secondaryTextMatchedSubstrings!.map((x) => x.toJson())),
      };
}

class Term {
  Term({
    required this.offset,
    required this.value,
  });

  final int offset;
  final String value;

  Term copyWith({
    int? offset,
    String? value,
  }) =>
      Term(
        offset: offset ?? this.offset,
        value: value ?? this.value,
      );

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        offset: json["offset"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "value": value,
      };
}
