import 'package:sporth/models/models.dart';

class SearchDto {
  String? nombre;
  List<int>? deporte;
  int maxPersonas;
  int precio;
  String? hora;
  String? dia;
  GeograficoDto? ubicacion;

  SearchDto({
    this.nombre,
    this.deporte,
    this.maxPersonas = 25,
    this.precio = 50,
    this.hora,
    this.dia,
    this.ubicacion,
  });

  SearchDto copyOf({
    List<int>? deporte,
    String? nombre,
    String? hora,
    String? dia,
    int? maxPersonas,
    int? precio,
    GeograficoDto? ubicacion,
  }) {
    return SearchDto(
      deporte: deporte ?? this.deporte,
      dia: dia ?? this.dia,
      hora: hora ?? this.hora,
      maxPersonas: maxPersonas ?? this.maxPersonas,
      nombre: nombre ?? this.nombre,
      precio: precio ?? this.precio,
      ubicacion: ubicacion ?? this.ubicacion,
    );
  }
}
