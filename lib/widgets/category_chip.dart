import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Filtro de categoria. Es un ChoiceChip porque solo puede haber una categoria activa a la vez.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.texto,
    required this.seleccionado,
    required this.onTap,
    this.conteo,
    this.ocupaTodoElAncho = false,
  });

  final String texto;
  final bool seleccionado;
  final VoidCallback onTap;

  // Cuantos eventos caen en esta categoria con los filtros actuales; null lo oculta.
  final int? conteo;

  // En la barra lateral los chips se alinean a la izquierda y ocupan el ancho completo.
  final bool ocupaTodoElAncho;

  @override
  Widget build(BuildContext context) {
    final esTodos = texto == 'Todos';

    // 'Todos' no es una categoria real, asi que toma la tinta en lugar de inventarle un color.
    final color = esTodos ? Paleta.tinta : selloDe(texto).color;
    final icono = esTodos ? Icons.grid_view_outlined : selloDe(texto).icono;
    final colorTexto = seleccionado ? Paleta.papel : Paleta.tinta;

    final contenido = Row(
      mainAxisSize: ocupaTodoElAncho ? MainAxisSize.max : MainAxisSize.min,
      children: [
        Icon(icono, size: 15, color: seleccionado ? Paleta.papel : color),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            texto,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTheme.textos,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: colorTexto,
            ),
          ),
        ),
        if (conteo != null) ...[
          const SizedBox(width: 8),
          Text(
            '$conteo',
            style: TextStyle(
              fontFamily: AppTheme.textos,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorTexto.withValues(alpha: 0.6),
            ),
          ),
        ],
      ],
    );

    return ChoiceChip(
      selected: seleccionado,
      onSelected: (_) => onTap(),
      selectedColor: color,
      backgroundColor: Paleta.lienzo,
      side: BorderSide(color: seleccionado ? color : Paleta.trazo),
      label: contenido,
      labelPadding: EdgeInsets.zero,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
    );
  }
}
