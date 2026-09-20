import 'package:flutter/material.dart';

import '../models/evento.dart';

// Boton unico de registro: el mismo control marca y desmarca, y su texto dice en que estado esta.
class BotonInteres extends StatelessWidget {
  const BotonInteres({
    super.key,
    required this.evento,
    required this.interesado,
    required this.onPressed,
    this.compacto = false,
  });

  final Evento evento;
  final bool interesado;
  final VoidCallback onPressed;
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    // Un evento lleno no se cancela de la cartelera: se ofrece lista de espera para no dejar el boton muerto.
    final String texto = interesado
        ? 'En tu agenda'
        : evento.agotado
        ? 'Lista de espera'
        : 'Me interesa';

    final IconData icono = interesado
        ? Icons.bookmark
        : evento.agotado
        ? Icons.hourglass_empty
        : Icons.bookmark_border;

    final relleno = EdgeInsets.symmetric(
      horizontal: compacto ? 12 : 16,
      vertical: compacto ? 9 : 13,
    );

    final etiqueta = Text(
      texto,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: compacto ? 12.5 : 13.5),
    );

    if (interesado) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icono, size: compacto ? 15 : 17),
        label: etiqueta,
        style: OutlinedButton.styleFrom(padding: relleno),
      );
    }

    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icono, size: compacto ? 15 : 17),
      label: etiqueta,
      style: FilledButton.styleFrom(padding: relleno),
    );
  }
}
