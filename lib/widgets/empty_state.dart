import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Se muestra cuando la combinacion de filtros no deja ningun evento, con la salida a un clic.
class SinResultados extends StatelessWidget {
  const SinResultados({
    super.key,
    required this.mensaje,
    required this.onLimpiar,
  });

  final String mensaje;
  final VoidCallback onLimpiar;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        border: Border.all(color: Paleta.trazo),
        borderRadius: BorderRadius.circular(AppTheme.radio),
        color: Paleta.lienzo.withValues(alpha: 0.5),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_outlined,
            size: 34,
            color: Paleta.tintaSuave,
          ),
          const SizedBox(height: 14),
          Text(
            'Nada por aquí',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 6),
          Text(
            mensaje,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: onLimpiar,
            child: const Text('Quitar los filtros'),
          ),
        ],
      ),
    );
  }
}
