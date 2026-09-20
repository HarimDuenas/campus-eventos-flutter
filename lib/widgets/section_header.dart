import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Rotulo de seccion con una linea que se estira hasta el borde; es el recurso que le da aire de cartelera.
class EncabezadoSeccion extends StatelessWidget {
  const EncabezadoSeccion({super.key, required this.titulo, this.apunte});

  final String titulo;

  // Texto opcional al final de la linea, por ejemplo cuantos resultados hay.
  final String? apunte;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          titulo.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(width: 12),
        const Expanded(child: Divider(color: Paleta.trazo)),
        if (apunte != null) ...[
          const SizedBox(width: 12),
          Text(
            apunte!,
            style: const TextStyle(
              fontFamily: AppTheme.textos,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Paleta.tintaMedia,
            ),
          ),
        ],
      ],
    );
  }
}
