import 'package:flutter/material.dart';

import '../models/evento.dart';
import '../theme/app_theme.dart';
import '../utils/fechas.dart';
import 'capacity_bar.dart';
import 'category_tag.dart';
import 'data_row.dart';
import 'event_image.dart';
import 'interest_button.dart';

// Ficha completa del evento. Se abre como hoja inferior para no sacar al usuario de la cartelera.
class DetalleEvento extends StatelessWidget {
  const DetalleEvento({
    super.key,
    required this.evento,
    required this.interesado,
    required this.onInteres,
  });

  final Evento evento;
  final bool interesado;
  final VoidCallback onInteres;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final falta = cuentaRegresiva(evento.inicio, DateTime.now());

    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.88,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ImagenEvento(
                            ruta: evento.imagen,
                            categoria: evento.categoria,
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 16,
                          child: EtiquetaCategoria(categoria: evento.categoria),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: IconButton.filled(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close, size: 18),
                            style: IconButton.styleFrom(
                              backgroundColor: Paleta.papel,
                              foregroundColor: Paleta.tinta,
                            ),
                          ),
                        ),
                        if (evento.agotado || evento.porAgotarse)
                          Positioned(
                            left: 16,
                            bottom: 12,
                            child: EtiquetaAviso(
                              texto: evento.agotado
                                  ? 'Cupo lleno'
                                  : 'Últimos lugares',
                              lleno: evento.agotado,
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(falta.toUpperCase(), style: textos.labelSmall),
                          const SizedBox(height: 8),
                          Text(evento.titulo, style: textos.headlineMedium),
                          const SizedBox(height: 18),
                          const Divider(),
                          const SizedBox(height: 16),
                          DatoEvento(
                            icono: Icons.event_outlined,
                            texto: fechaLarga(evento.inicio),
                            grande: true,
                          ),
                          const SizedBox(height: 10),
                          DatoEvento(
                            icono: Icons.schedule_outlined,
                            texto: rangoHorario(evento.inicio, evento.fin),
                            grande: true,
                          ),
                          const SizedBox(height: 10),
                          DatoEvento(
                            icono: Icons.place_outlined,
                            texto: evento.lugar,
                            grande: true,
                          ),
                          const SizedBox(height: 10),
                          DatoEvento(
                            icono: Icons.groups_outlined,
                            texto:
                                '${evento.inscritos} inscritos de ${evento.cupo} lugares',
                            grande: true,
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          Text(evento.resumen, style: textos.bodyLarge),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // El pie queda fijo para que el boton siga a la vista aunque el resumen sea largo.
            Container(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
              decoration: const BoxDecoration(
                color: Paleta.lienzo,
                border: Border(top: BorderSide(color: Paleta.trazo)),
              ),
              child: Row(
                children: [
                  Expanded(child: BarraCupo(evento: evento)),
                  const SizedBox(width: 16),
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
