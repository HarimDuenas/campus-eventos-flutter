import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../theme/app_theme.dart';
import '../utils/fechas.dart';
import 'capacity_bar.dart';
import 'category_tag.dart';
import 'data_row.dart';
import 'date_block.dart';
import 'event_image.dart';
import 'interest_button.dart';

// Tarjeta horizontal para celular: la foto se achica y los datos se apilan para que quepan mas eventos.
class EventRowCard extends StatelessWidget {
  const EventRowCard({
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
    // Solo es una pista visual, por eso se calcula aqui y no se sube al estado de la pantalla.
    final falta = cuentaRegresiva(evento.inicio, DateTime.now());

    return Card(
      child: InkWell(
        onTap: onAbrir,
        // IntrinsicHeight deja que la foto crezca hasta la altura real del texto, sin alturas fijas.
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 112,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ImagenEvento(
                        ruta: evento.imagen,
                        categoria: evento.categoria,
                      ),
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: BloqueFecha(fecha: evento.inicio),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: EtiquetaCategoria(
                              categoria: evento.categoria,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            falta,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: AppTheme.textos,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Paleta.tintaSuave,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Text(
                        evento.titulo,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      DatoEvento(
                        icono: Icons.schedule_outlined,
                        texto: rangoHorario(evento.inicio, evento.fin),
                      ),
                      const SizedBox(height: 4),
                      DatoEvento(
                        icono: Icons.place_outlined,
                        texto: evento.lugar,
                      ),
                      const SizedBox(height: 11),
                      BarraCupo(evento: evento),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BotonInteres(
                          evento: evento,
                          interesado: interesado,
                          onPressed: onInteres,
                          compacto: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
