import 'dart:convert';

import 'package:sporth/models/models.dart';

GoogleDetails googleDetailsFromJson(String str) => GoogleDetails.fromJson(json.decode(str));

String googleDetailsToJson(GoogleDetails data) => json.encode(data.toJson());

class GoogleDetails {
  GoogleDetails({
    required this.htmlAttributions,
    required this.result,
    required this.status,
  });

  final List<dynamic> htmlAttributions;
  final ResultDetails result;
  final String status;

  GoogleDetails copyWith({
    List<dynamic>? htmlAttributions,
    ResultDetails? result,
    String? status,
  }) =>
      GoogleDetails(
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        result: result ?? this.result,
        status: status ?? this.status,
      );

  factory GoogleDetails.fromJson(Map<String, dynamic> json) => GoogleDetails(
        htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
        result: ResultDetails.fromJson(json["result"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "result": result.toJson(),
        "status": status,
      };
}

class ResultDetails {
  ResultDetails({
    required this.addressComponents,
    required this.adrAddress,
    required this.businessStatus,
    required this.currentOpeningHours,
    required this.formattedAddress,
    this.formattedPhoneNumber,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    this.internationalPhoneNumber,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    this.rating,
    required this.reference,
    required this.reviews,
    required this.types,
    required this.url,
    required this.userRatingsTotal,
    required this.utcOffset,
    required this.vicinity,
    this.website,
    required this.wheelchairAccessibleEntrance,
  });

  final List<AddressComponent> addressComponents;
  final String adrAddress;
  final String businessStatus;
  final CurrentOpeningHours currentOpeningHours;
  final String formattedAddress;
  final String? formattedPhoneNumber;
  final GeometryDetails geometry;
  final String icon;
  final String iconBackgroundColor;
  final String iconMaskBaseUri;
  final String? internationalPhoneNumber;
  final String name;
  final OpeningHours openingHours;
  final List<Photo> photos;
  final String placeId;
  final PlusCode plusCode;
  final double? rating;
  final String reference;
  final List<Review> reviews;
  final List<String> types;
  final String url;
  final int userRatingsTotal;
  final int utcOffset;
  final String vicinity;
  final String? website;
  final bool wheelchairAccessibleEntrance;

  ResultDetails copyWith({
    List<AddressComponent>? addressComponents,
    String? adrAddress,
    String? businessStatus,
    CurrentOpeningHours? currentOpeningHours,
    String? formattedAddress,
    String? formattedPhoneNumber,
    GeometryDetails? geometry,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    String? internationalPhoneNumber,
    String? name,
    OpeningHours? openingHours,
    List<Photo>? photos,
    String? placeId,
    PlusCode? plusCode,
    double? rating,
    String? reference,
    List<Review>? reviews,
    List<String>? types,
    String? url,
    int? userRatingsTotal,
    int? utcOffset,
    String? vicinity,
    String? website,
    bool? wheelchairAccessibleEntrance,
  }) =>
      ResultDetails(
        addressComponents: addressComponents ?? this.addressComponents,
        adrAddress: adrAddress ?? this.adrAddress,
        businessStatus: businessStatus ?? this.businessStatus,
        currentOpeningHours: currentOpeningHours ?? this.currentOpeningHours,
        formattedAddress: formattedAddress ?? this.formattedAddress,
        formattedPhoneNumber: formattedPhoneNumber ?? this.formattedPhoneNumber,
        geometry: geometry ?? this.geometry,
        icon: icon ?? this.icon,
        iconBackgroundColor: iconBackgroundColor ?? this.iconBackgroundColor,
        iconMaskBaseUri: iconMaskBaseUri ?? this.iconMaskBaseUri,
        internationalPhoneNumber: internationalPhoneNumber ?? this.internationalPhoneNumber,
        name: name ?? this.name,
        openingHours: openingHours ?? this.openingHours,
        photos: photos ?? this.photos,
        placeId: placeId ?? this.placeId,
        plusCode: plusCode ?? this.plusCode,
        rating: rating ?? this.rating,
        reference: reference ?? this.reference,
        reviews: reviews ?? this.reviews,
        types: types ?? this.types,
        url: url ?? this.url,
        userRatingsTotal: userRatingsTotal ?? this.userRatingsTotal,
        utcOffset: utcOffset ?? this.utcOffset,
        vicinity: vicinity ?? this.vicinity,
        website: website ?? this.website,
        wheelchairAccessibleEntrance: wheelchairAccessibleEntrance ?? this.wheelchairAccessibleEntrance,
      );

  factory ResultDetails.fromJson(Map<String, dynamic> json) => ResultDetails(
        addressComponents: List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"],
        businessStatus: json["business_status"],
        currentOpeningHours: CurrentOpeningHours.fromJson(json["current_opening_hours"]),
        formattedAddress: json["formatted_address"],
        formattedPhoneNumber: json["formatted_phone_number"],
        geometry: GeometryDetails.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        internationalPhoneNumber: json["international_phone_number"],
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        plusCode: PlusCode.fromJson(json["plus_code"]),
        rating: json["rating"].toDouble(),
        reference: json["reference"],
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        types: List<String>.from(json["types"].map((x) => x)),
        url: json["url"],
        userRatingsTotal: json["user_ratings_total"],
        utcOffset: json["utc_offset"],
        vicinity: json["vicinity"],
        website: json["website"],
        wheelchairAccessibleEntrance: json["wheelchair_accessible_entrance"],
      );

  Map<String, dynamic> toJson() => {
        "address_components": List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "adr_address": adrAddress,
        "business_status": businessStatus,
        "current_opening_hours": currentOpeningHours.toJson(),
        "formatted_address": formattedAddress,
        "formatted_phone_number": formattedPhoneNumber,
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "international_phone_number": internationalPhoneNumber,
        "name": name,
        "opening_hours": openingHours.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode.toJson(),
        "rating": rating,
        "reference": reference,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x)),
        "url": url,
        "user_ratings_total": userRatingsTotal,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
        "website": website,
        "wheelchair_accessible_entrance": wheelchairAccessibleEntrance,
      };
}

class CurrentOpeningHours {
  CurrentOpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  final bool openNow;
  final List<CurrentOpeningHoursPeriod> periods;
  final List<String> weekdayText;

  CurrentOpeningHours copyWith({
    bool? openNow,
    List<CurrentOpeningHoursPeriod>? periods,
    List<String>? weekdayText,
  }) =>
      CurrentOpeningHours(
        openNow: openNow ?? this.openNow,
        periods: periods ?? this.periods,
        weekdayText: weekdayText ?? this.weekdayText,
      );

  factory CurrentOpeningHours.fromJson(Map<String, dynamic> json) => CurrentOpeningHours(
        openNow: json["open_now"],
        periods: List<CurrentOpeningHoursPeriod>.from(json["periods"].map((x) => CurrentOpeningHoursPeriod.fromJson(x))),
        weekdayText: List<String>.from(json["weekday_text"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
      };
}

class CurrentOpeningHoursPeriod {
  CurrentOpeningHoursPeriod({
    required this.close,
    required this.open,
  });

  final PurpleClose close;
  final PurpleClose open;

  CurrentOpeningHoursPeriod copyWith({
    PurpleClose? close,
    PurpleClose? open,
  }) =>
      CurrentOpeningHoursPeriod(
        close: close ?? this.close,
        open: open ?? this.open,
      );

  factory CurrentOpeningHoursPeriod.fromJson(Map<String, dynamic> json) => CurrentOpeningHoursPeriod(
        close: PurpleClose.fromJson(json["close"]),
        open: PurpleClose.fromJson(json["open"]),
      );

  Map<String, dynamic> toJson() => {
        "close": close.toJson(),
        "open": open.toJson(),
      };
}

class PurpleClose {
  PurpleClose({
    required this.date,
    required this.day,
    required this.time,
    this.truncated,
  });

  final DateTime date;
  final int day;
  final String time;
  final bool? truncated;

  PurpleClose copyWith({
    DateTime? date,
    int? day,
    String? time,
    bool? truncated,
  }) =>
      PurpleClose(
        date: date ?? this.date,
        day: day ?? this.day,
        time: time ?? this.time,
        truncated: truncated ?? this.truncated,
      );

  factory PurpleClose.fromJson(Map<String, dynamic> json) => PurpleClose(
        date: DateTime.parse(json["date"]),
        day: json["day"],
        time: json["time"],
        truncated: json["truncated"],
      );

  Map<String, dynamic> toJson() => {
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "day": day,
        "time": time,
        "truncated": truncated,
      };
}

class GeometryDetails {
  GeometryDetails({
    required this.location,
    required this.viewport,
  });

  final Location location;
  final Viewport viewport;

  GeometryDetails copyWith({
    Location? location,
    Viewport? viewport,
  }) =>
      GeometryDetails(
        location: location ?? this.location,
        viewport: viewport ?? this.viewport,
      );

  factory GeometryDetails.fromJson(Map<String, dynamic> json) => GeometryDetails(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  final bool openNow;
  final List<OpeningHoursPeriod> periods;
  final List<String> weekdayText;

  OpeningHours copyWith({
    bool? openNow,
    List<OpeningHoursPeriod>? periods,
    List<String>? weekdayText,
  }) =>
      OpeningHours(
        openNow: openNow ?? this.openNow,
        periods: periods ?? this.periods,
        weekdayText: weekdayText ?? this.weekdayText,
      );

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
        periods: List<OpeningHoursPeriod>.from(json["periods"].map((x) => OpeningHoursPeriod.fromJson(x))),
        weekdayText: List<String>.from(json["weekday_text"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
      };
}

class OpeningHoursPeriod {
  OpeningHoursPeriod({
    this.close,
    required this.open,
  });

  final FluffyClose? close;
  final FluffyClose open;

  OpeningHoursPeriod copyWith({
    FluffyClose? close,
    FluffyClose? open,
  }) =>
      OpeningHoursPeriod(
        close: close ?? this.close,
        open: open ?? this.open,
      );

  factory OpeningHoursPeriod.fromJson(Map<String, dynamic> json) => OpeningHoursPeriod(
        close: json["close"] == null ? null : FluffyClose.fromJson(json["close"]),
        open: FluffyClose.fromJson(json["open"]),
      );

  Map<String, dynamic> toJson() => {
        "close": close?.toJson(),
        "open": open.toJson(),
      };
}

class FluffyClose {
  FluffyClose({
    required this.day,
    required this.time,
  });

  final int day;
  final String time;

  FluffyClose copyWith({
    int? day,
    String? time,
  }) =>
      FluffyClose(
        day: day ?? this.day,
        time: time ?? this.time,
      );

  factory FluffyClose.fromJson(Map<String, dynamic> json) => FluffyClose(
        day: json["day"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
      };
}

class Photo {
  Photo({
    required this.height,
    required this.htmlAttributions,
    required this.photoReference,
    required this.width,
  });

  final int height;
  final List<String> htmlAttributions;
  final String photoReference;
  final int width;

  Photo copyWith({
    int? height,
    List<String>? htmlAttributions,
    String? photoReference,
    int? width,
  }) =>
      Photo(
        height: height ?? this.height,
        htmlAttributions: htmlAttributions ?? this.htmlAttributions,
        photoReference: photoReference ?? this.photoReference,
        width: width ?? this.width,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}

class Review {
  Review({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.originalLanguage,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
    required this.translated,
  });

  final String authorName;
  final String authorUrl;
  final String language;
  final String originalLanguage;
  final String profilePhotoUrl;
  final int rating;
  final String relativeTimeDescription;
  final String text;
  final int time;
  final bool translated;

  Review copyWith({
    String? authorName,
    String? authorUrl,
    String? language,
    String? originalLanguage,
    String? profilePhotoUrl,
    int? rating,
    String? relativeTimeDescription,
    String? text,
    int? time,
    bool? translated,
  }) =>
      Review(
        authorName: authorName ?? this.authorName,
        authorUrl: authorUrl ?? this.authorUrl,
        language: language ?? this.language,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
        rating: rating ?? this.rating,
        relativeTimeDescription: relativeTimeDescription ?? this.relativeTimeDescription,
        text: text ?? this.text,
        time: time ?? this.time,
        translated: translated ?? this.translated,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        language: json["language"],
        originalLanguage: json["original_language"],
        profilePhotoUrl: json["profile_photo_url"],
        rating: json["rating"],
        relativeTimeDescription: json["relative_time_description"],
        text: json["text"],
        time: json["time"],
        translated: json["translated"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "original_language": originalLanguage,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
        "translated": translated,
      };
}
