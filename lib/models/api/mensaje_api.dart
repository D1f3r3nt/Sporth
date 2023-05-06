class MensajeApi {
  MensajeApi({
    required this.editor,
    required this.mensaje,
    required this.creacion,
  });

  final String editor;
  final String mensaje;
  final DateTime creacion;

  MensajeApi copyWith({
    String? idChat,
    String? editor,
    String? mensaje,
    DateTime? creacion,
  }) =>
      MensajeApi(
        editor: editor ?? this.editor,
        mensaje: mensaje ?? this.mensaje,
        creacion: creacion ?? this.creacion,
      );

  factory MensajeApi.fromJson(Map<String, dynamic> json) => MensajeApi(
        editor: json["editor"],
        mensaje: json["mensaje"],
        creacion: json["creacion"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "editor": editor,
        "mensaje": mensaje,
        "creacion": creacion,
      };
}
