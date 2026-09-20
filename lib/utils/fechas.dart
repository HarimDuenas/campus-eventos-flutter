// Nombres en espanol escritos a mano para no arrastrar el paquete intl ni depender del locale del equipo.
const List<String> _mesesCortos = [
  'ene',
  'feb',
  'mar',
  'abr',
  'may',
  'jun',
  'jul',
  'ago',
  'sep',
  'oct',
  'nov',
  'dic',
];

const List<String> _mesesLargos = [
  'enero',
  'febrero',
  'marzo',
  'abril',
  'mayo',
  'junio',
  'julio',
  'agosto',
  'septiembre',
  'octubre',
  'noviembre',
  'diciembre',
];

// DateTime.weekday devuelve 1 para lunes, por eso la lista arranca en lunes y no en domingo.
const List<String> _diasSemana = [
  'lunes',
  'martes',
  'miércoles',
  'jueves',
  'viernes',
  'sábado',
  'domingo',
];

String mesCorto(DateTime f) => _mesesCortos[f.month - 1];

String diaSemana(DateTime f) => _diasSemana[f.weekday - 1];

// Formato largo para el detalle: "jueves 24 de septiembre".
String fechaLarga(DateTime f) =>
    '${diaSemana(f)} ${f.day} de ${_mesesLargos[f.month - 1]}';

// Formato corto para las tarjetas: "24 sep".
String fechaCorta(DateTime f) => '${f.day} ${mesCorto(f)}';

// Horario de 24 horas, que es como se publican los eventos escolares.
String hora(DateTime f) =>
    '${f.hour.toString().padLeft(2, '0')}:${f.minute.toString().padLeft(2, '0')}';

// Si el evento dura mas de un dia se muestra la hora de arranque en lugar de un rango imposible.
String rangoHorario(DateTime inicio, DateTime fin) {
  if (fin.day != inicio.day) return 'desde las ${hora(inicio)}';
  return '${hora(inicio)} – ${hora(fin)}';
}

// Se comparan solo las fechas, para que "hoy" no dependa de la hora en que se abre la app.
int _diasFaltantes(DateTime inicio, DateTime hoy) {
  final a = DateTime(inicio.year, inicio.month, inicio.day);
  final b = DateTime(hoy.year, hoy.month, hoy.day);
  return a.difference(b).inDays;
}

// Etiqueta de proximidad que acompana a la fecha en las tarjetas y en el detalle.
String cuentaRegresiva(DateTime inicio, DateTime hoy) {
  final dias = _diasFaltantes(inicio, hoy);
  if (dias < 0) return 'ya ocurrió';
  if (dias == 0) return 'es hoy';
  if (dias == 1) return 'es mañana';
  if (dias <= 7) return 'en $dias días';
  return 'en ${(dias / 7).floor()} semanas';
}
