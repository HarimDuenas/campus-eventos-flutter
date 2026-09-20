import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Renglon de icono mas texto que se repite en las dos tarjetas y en el detalle del evento.
class DatoEvento extends StatelessWidget {
  const DatoEvento({
    super.key,
    required this.icono,
    required this.texto,
    this.grande = false,
  });

  final IconData icono;
  final String texto;
  final bool grande;

  @override
  Widget build(BuildContext context) {
    final estilo = grande
        ? Theme.of(context).textTheme.bodyLarge
        : Theme.of(context).textTheme.bodySmall;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: grande ? 3 : 1.5),
          child: Icon(
            icono,
            size: grande ? 17 : 14,
            color: grande ? Paleta.tintaMedia : Paleta.tintaSuave,
          ),
        ),
        SizedBox(width: grande ? 10 : 7),
        Expanded(
          child: Text(
            texto,
            maxLines: grande ? 2 : 1,
            overflow: TextOverflow.ellipsis,
            style: estilo,
          ),
        ),
      ],
    );
  }
}
