class GeograficoDto {
  static const String SEPARATOR = '<->';
  final double lat;
  final double lng;

  GeograficoDto({
    required this.lat,
    required this.lng,
  });

  GeograficoDto copyOf({
    double? lat,
    double? lng,
  }) {
    return GeograficoDto(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  String toString() => '$lat$SEPARATOR$lng';

  static GeograficoDto fromString(String string) {
    var data = string.split(SEPARATOR);
    return GeograficoDto(lat: double.parse(data[0]), lng: double.parse(data[1]));
  }
}
