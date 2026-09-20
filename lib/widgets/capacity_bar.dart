import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../theme/app_theme.dart';

// Barra de ocupacion del cupo: de un vistazo se ve si al evento todavia le sobran lugares.
class BarraCupo extends StatelessWidget {
  const BarraCupo({super.key, required this.evento, this.conTexto = true});

  final Evento evento;
  final bool conTexto;

  @override
  Widget build(BuildContext context) {
    final sello = selloDe(evento.categoria);

    // El color cambia con la urgencia: lleno en gris, casi lleno en rojo, con lugares en su categoria.
    final Color relleno = evento.agotado
        ? Paleta.tintaSuave
        : evento.porAgotarse
        ? Paleta.alerta
        : sello.color;

    final String leyenda = evento.agotado
        ? 'Cupo lleno · ${evento.cupo} lugares'
        : 'Quedan ${evento.disponibles} de ${evento.cupo} lugares';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (conTexto) ...[
          Text(
            leyenda,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTheme.textos,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: evento.porAgotarse ? Paleta.alerta : Paleta.tintaSuave,
            ),
          ),
          const SizedBox(height: 5),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: evento.ocupacion,
            minHeight: 5,
            backgroundColor: Paleta.papelHundido,
            valueColor: AlwaysStoppedAnimation<Color>(relleno),
          ),
        ),
      ],
    );
  }
}
