import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/fechas.dart';

// Bloque de fecha estilo taco de calendario; es el ancla visual que se repite en toda la cartelera.
class BloqueFecha extends StatelessWidget {
  const BloqueFecha({super.key, required this.fecha, this.grande = false});

  final DateTime fecha;
  final bool grande;

  @override
  Widget build(BuildContext context) {
    final medida = grande ? 62.0 : 48.0;

    return Container(
      width: medida,
      padding: EdgeInsets.symmetric(vertical: grande ? 8 : 6),
      decoration: const BoxDecoration(
        color: Paleta.tinta,
        borderRadius: BorderRadius.all(Radius.circular(AppTheme.radio)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            fecha.day.toString(),
            style: TextStyle(
              fontFamily: AppTheme.titulos,
              fontSize: grande ? 26 : 20,
              height: 1,
              fontWeight: FontWeight.w700,
              color: Paleta.papel,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            mesCorto(fecha).toUpperCase(),
            style: TextStyle(
              fontFamily: AppTheme.textos,
              fontSize: grande ? 11 : 9.5,
              height: 1,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
              color: Paleta.papel.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }
}
