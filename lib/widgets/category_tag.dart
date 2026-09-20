import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Etiqueta con el color y el icono de la categoria; va encima de la foto para leerse antes que el titulo.
class EtiquetaCategoria extends StatelessWidget {
  const EtiquetaCategoria({
    super.key,
    required this.categoria,
    this.sobreFoto = true,
  });

  final String categoria;

  // Sobre la foto va en fondo claro; dentro de una ficha va en el color de la categoria al 10%.
  final bool sobreFoto;

  @override
  Widget build(BuildContext context) {
    final sello = selloDe(categoria);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: sobreFoto ? Paleta.papel : sello.color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(AppTheme.radio),
        border: Border.all(color: sello.color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(sello.icono, size: 12, color: sello.color),
          const SizedBox(width: 5),
          Text(
            categoria.toUpperCase(),
            style: TextStyle(
              fontFamily: AppTheme.textos,
              fontSize: 9.5,
              height: 1.2,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.9,
              color: sello.color,
            ),
          ),
        ],
      ),
    );
  }
}

// Sello rojo de urgencia; solo aparece cuando el cupo ya se cerro o esta por cerrarse.
class EtiquetaAviso extends StatelessWidget {
  const EtiquetaAviso({super.key, required this.texto, required this.lleno});

  final String texto;
  final bool lleno;

  @override
  Widget build(BuildContext context) {
    final color = lleno ? Paleta.tinta : Paleta.alerta;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppTheme.radio),
      ),
      child: Text(
        texto.toUpperCase(),
        style: const TextStyle(
          fontFamily: AppTheme.textos,
          fontSize: 9.5,
          height: 1.2,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.9,
          color: Paleta.papel,
        ),
      ),
    );
  }
}
