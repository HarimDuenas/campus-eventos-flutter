import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Foto del evento con un respaldo del color de su categoria por si el archivo no llegara a cargar.
class ImagenEvento extends StatelessWidget {
  const ImagenEvento({super.key, required this.ruta, required this.categoria});

  final String ruta;
  final String categoria;

  @override
  Widget build(BuildContext context) {
    final sello = selloDe(categoria);

    return Image.asset(
      ruta,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => ColoredBox(
        color: sello.color.withValues(alpha: 0.14),
        child: Center(child: Icon(sello.icono, size: 26, color: sello.color)),
      ),
    );
  }
}
