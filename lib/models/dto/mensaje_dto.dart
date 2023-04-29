import 'package:sporth/models/dto/user_dto.dart';

class MensajeDto {
  MensajeDto({
    required this.editor,
    required this.mensaje,
    required this.creacion,
  });

  final UserDto editor;
  final String mensaje;
  final DateTime creacion;

  MensajeDto copyWith({
    UserDto? editor,
    String? mensaje,
    DateTime? creacion,
  }) =>
      MensajeDto(
        editor: editor ?? this.editor,
        mensaje: mensaje ?? this.mensaje,
        creacion: creacion ?? this.creacion,
      );
}
