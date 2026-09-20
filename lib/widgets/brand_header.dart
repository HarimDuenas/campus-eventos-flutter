import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Monograma mas nombre de la app. Es la firma de la cartelera y aparece igual en las dos distribuciones.
class MarcaCampus extends StatelessWidget {
  const MarcaCampus({super.key, this.pequena = false});

  final bool pequena;

  @override
  Widget build(BuildContext context) {
    final lado = pequena ? 32.0 : 44.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: lado,
          height: lado,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Paleta.acento,
            borderRadius: BorderRadius.all(Radius.circular(AppTheme.radio)),
          ),
          child: Text(
            'CE',
            style: TextStyle(
              fontFamily: AppTheme.titulos,
              fontSize: pequena ? 14 : 19,
              height: 1,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: Paleta.papel,
            ),
          ),
        ),
        SizedBox(width: pequena ? 11 : 14),
        Flexible(
          child: Text(
            'Campus Eventos',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTheme.titulos,
              fontSize: pequena ? 18 : 27,
              height: 1.1,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: Paleta.papel,
            ),
          ),
        ),
      ],
    );
  }
}

// Descripcion corta y cifras del semestre, lo que la practica pide como encabezado de la pantalla.
class LemaCampus extends StatelessWidget {
  const LemaCampus({
    super.key,
    required this.totalEventos,
    required this.totalCategorias,
  });

  final int totalEventos;
  final int totalCategorias;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Todo lo que pasa en la universidad, en un solo lugar.',
          style: TextStyle(
            fontFamily: AppTheme.textos,
            fontSize: 14.5,
            height: 1.35,
            color: Paleta.papel.withValues(alpha: 0.78),
          ),
        ),
        const SizedBox(height: 14),
        // Wrap y no Row: en pantallas angostas las cifras bajan de renglon en vez de desbordarse.
        Wrap(
          spacing: 18,
          runSpacing: 8,
          children: [
            _Cifra(valor: '$totalEventos', etiqueta: 'actividades'),
            _Cifra(valor: '$totalCategorias', etiqueta: 'categorías'),
            const _Cifra(valor: 'Ago–Dic', etiqueta: '2026'),
          ],
        ),
      ],
    );
  }
}

class _Cifra extends StatelessWidget {
  const _Cifra({required this.valor, required this.etiqueta});

  final String valor;
  final String etiqueta;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          valor,
          style: const TextStyle(
            fontFamily: AppTheme.titulos,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Paleta.papel,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          etiqueta.toUpperCase(),
          style: TextStyle(
            fontFamily: AppTheme.textos,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
            color: Paleta.papel.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

// Contador de eventos guardados que ademas sirve de filtro rapido hacia la agenda personal.
class PildoraAgenda extends StatelessWidget {
  const PildoraAgenda({
    super.key,
    required this.cantidad,
    required this.activa,
    required this.onTap,
  });

  final int cantidad;
  final bool activa;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: activa ? Paleta.acento : Colors.transparent,
      borderRadius: BorderRadius.circular(AppTheme.radio),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radio),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radio),
            border: Border.all(
              color: activa
                  ? Paleta.acento
                  : Paleta.papel.withValues(alpha: 0.32),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                activa ? Icons.bookmark : Icons.bookmark_border,
                size: 15,
                color: Paleta.papel,
              ),
              const SizedBox(width: 7),
              Text(
                'Mi agenda',
                style: const TextStyle(
                  fontFamily: AppTheme.textos,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: Paleta.papel,
                ),
              ),
              if (cantidad > 0) ...[
                const SizedBox(width: 7),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: Paleta.papel.withValues(alpha: activa ? 0.9 : 0.16),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    '$cantidad',
                    style: TextStyle(
                      fontFamily: AppTheme.textos,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: activa ? Paleta.acento : Paleta.papel,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
