// Evento de la cartelera: es una clase y no un Map para que el compilador cache las llaves mal escritas.
class Evento {
  const Evento({
    required this.titulo,
    required this.categoria,
    required this.inicio,
    required this.duracion,
    required this.lugar,
    required this.cupo,
    required this.inscritos,
    required this.resumen,
    required this.imagen,
    this.destacado = false,
  });

  final String titulo;
  final String categoria;

  // Fecha y hora viven juntas en un DateTime para poder ordenar la cartelera cronologicamente.
  final DateTime inicio;
  final Duration duracion;

  final String lugar;
  final int cupo;
  final int inscritos;
  final String resumen;
  final String imagen;
  final bool destacado;

  DateTime get fin => inicio.add(duracion);

  // Se recorta a cero por si un dato viniera con mas inscritos que cupo.
  int get disponibles => (cupo - inscritos).clamp(0, cupo);

  // Fraccion de 0 a 1 que llena la barra de ocupacion de la tarjeta.
  double get ocupacion =>
      cupo == 0 ? 1 : (inscritos / cupo).clamp(0.0, 1.0).toDouble();

  bool get agotado => disponibles == 0;

  // Desde el 85% se avisa "ultimos lugares" para que se note antes de que el cupo se cierre.
  bool get porAgotarse => !agotado && ocupacion >= 0.85;
}
