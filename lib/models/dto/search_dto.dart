class SearchDto {
  String? nombre;
  List<int>? deporte;
  int maxPersonas;
  int precio;
  String? hora;
  String? dia;

  SearchDto({
    this.nombre,
    this.deporte,
    this.maxPersonas = 100,
    this.precio = 100,
    this.hora,
    this.dia,
  });
}
