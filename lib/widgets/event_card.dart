import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../utils/fechas.dart';
import 'capacity_bar.dart';
import 'category_tag.dart';
import 'data_row.dart';
import 'date_block.dart';
import 'event_image.dart';
import 'interest_button.dart';

// Tarjeta cartel: la version vertical que se usa en la rejilla de tablet y escritorio.
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.evento,
    required this.interesado,
    required this.onInteres,
    required this.onAbrir,
  });

  final Evento evento;
  final bool interesado;
  final VoidCallback onInteres;
  final VoidCallback onAbrir;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onAbrir,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // La foto se queda con el alto sobrante de la celda, asi la tarjeta nunca se desborda.
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ImagenEvento(
                      ruta: evento.imagen,
                      categoria: evento.categoria,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: EtiquetaCategoria(categoria: evento.categoria),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: BloqueFecha(fecha: evento.inicio),
                  ),
                  if (evento.agotado || evento.porAgotarse)
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: EtiquetaAviso(
                        texto: evento.agotado
                            ? 'Cupo lleno'
                            : 'Últimos lugares',
                        lleno: evento.agotado,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dos renglones fijos: si no, las fotos de una fila cierran a distinta altura.
                  SizedBox(
                    height: 44,
                    child: Text(
                      evento.titulo,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DatoEvento(
                    icono: Icons.schedule_outlined,
                    texto:
                        '${fechaCorta(evento.inicio)} · '
                        '${rangoHorario(evento.inicio, evento.fin)}',
                  ),
                  const SizedBox(height: 5),
                  DatoEvento(icono: Icons.place_outlined, texto: evento.lugar),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  BarraCupo(evento: evento),
                  const SizedBox(height: 12),
                  BotonInteres(
                    evento: evento,
                    interesado: interesado,
                    onPressed: onInteres,
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
