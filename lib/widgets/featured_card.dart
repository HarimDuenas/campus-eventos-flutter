import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../theme/app_theme.dart';
import '../utils/fechas.dart';
import 'category_tag.dart';
import 'event_image.dart';

// Tarjeta del carrusel de destacados: foto a sangre con el texto encima, para que contraste con la rejilla.
class FeaturedCard extends StatelessWidget {
  const FeaturedCard({super.key, required this.evento, required this.onAbrir});

  final Evento evento;
  final VoidCallback onAbrir;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onAbrir,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImagenEvento(ruta: evento.imagen, categoria: evento.categoria),
            // Degradado oscuro de abajo hacia arriba: sin el, el texto blanco se pierde en fotos claras.
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.25, 1],
                  colors: [Colors.transparent, Color(0xEE101A18)],
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: EtiquetaCategoria(categoria: evento.categoria),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    evento.titulo,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTheme.titulos,
                      fontSize: 17,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Paleta.papel,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${fechaCorta(evento.inicio)} · ${hora(evento.inicio)} · ${evento.lugar}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppTheme.textos,
                      fontSize: 12,
                      color: Paleta.papel.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
