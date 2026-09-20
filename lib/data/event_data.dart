import '../models/evento.dart';

// 'Todos' va primero porque es el filtro por defecto al abrir la app.
const List<String> categorias = [
  'Todos',
  'Académicos',
  'Deportivos',
  'Culturales',
  'Tecnología',
  'Talleres',
];

// Ruta base de las fotos; estan en assets y no en internet para que la app se vea igual sin conexion.
const String _fotos = 'assets/imagenes';

// Cartelera del semestre agosto-diciembre 2026, ordenada por fecha de inicio.
final List<Evento> eventos = [
  Evento(
    titulo: 'Taller de Flutter desde cero',
    categoria: 'Talleres',
    inicio: DateTime(2026, 9, 21, 12, 0),
    duracion: const Duration(hours: 4),
    lugar: 'Laboratorio de Cómputo A, Edificio 47',
    cupo: 30,
    inscritos: 28,
    resumen:
        'Se arma una app completa en una sola sesión: widgets, estado y navegación. '
        'Hay que traer laptop con el SDK ya instalado.',
    imagen: '$_fotos/taller-flutter.jpg',
  ),
  Evento(
    titulo: 'Muestra de cine latinoamericano',
    categoria: 'Culturales',
    inicio: DateTime(2026, 9, 23, 18, 0),
    duracion: const Duration(hours: 3),
    lugar: 'Teatro Universitario',
    cupo: 200,
    inscritos: 154,
    resumen:
        'Tres cortometrajes premiados y una charla con el director invitado al cierre. '
        'Entrada libre para comunidad universitaria.',
    imagen: '$_fotos/muestra-cine.jpg',
    destacado: true,
  ),
  Evento(
    titulo: 'Congreso de Ingeniería de Software',
    categoria: 'Académicos',
    inicio: DateTime(2026, 9, 24, 9, 0),
    duracion: const Duration(hours: 8),
    lugar: 'Auditorio Dr. Pedro de Alba',
    cupo: 180,
    inscritos: 142,
    resumen:
        'Ocho ponencias sobre arquitectura, pruebas automatizadas y equipos distribuidos. '
        'Se entrega constancia con valor curricular.',
    imagen: '$_fotos/congreso-software.jpg',
    destacado: true,
  ),
  Evento(
    titulo: 'Torneo interfacultades de futbol',
    categoria: 'Deportivos',
    inicio: DateTime(2026, 9, 26, 16, 0),
    duracion: const Duration(hours: 3),
    lugar: 'Cancha Universitaria',
    cupo: 120,
    inscritos: 120,
    resumen:
        'Fase de grupos entre las doce facultades. Los equipos se registran completos, '
        'con mínimo dos jugadoras en cancha.',
    imagen: '$_fotos/torneo-futbol.jpg',
  ),
  Evento(
    titulo: 'Hackathon universitario 36 horas',
    categoria: 'Tecnología',
    inicio: DateTime(2026, 9, 27, 9, 0),
    duracion: const Duration(hours: 36),
    lugar: 'Laboratorio de Cómputo B, Edificio 47',
    cupo: 60,
    inscritos: 54,
    resumen:
        'Equipos de cuatro resolviendo un reto de movilidad urbana. Se entrega cena, '
        'desayuno y un jurado de tres empresas locales.',
    imagen: '$_fotos/hackathon.jpg',
    destacado: true,
  ),
  Evento(
    titulo: 'Taller de serigrafía en textil',
    categoria: 'Talleres',
    inicio: DateTime(2026, 9, 28, 15, 0),
    duracion: const Duration(hours: 3),
    lugar: 'Taller de Artes Visuales',
    cupo: 20,
    inscritos: 12,
    resumen:
        'Del diseño al estampado en una tarde. Cada quien se lleva puesta su playera; '
        'el material está incluido.',
    imagen: '$_fotos/taller-serigrafia.jpg',
  ),
  Evento(
    titulo: 'Noche de danza universitaria',
    categoria: 'Culturales',
    inicio: DateTime(2026, 9, 30, 19, 0),
    duracion: const Duration(hours: 2),
    lugar: 'Plaza de las Artes',
    cupo: 250,
    inscritos: 189,
    resumen:
        'Los cuatro grupos representativos presentan el repertorio que llevarán al '
        'encuentro nacional de noviembre.',
    imagen: '$_fotos/danza-universitaria.jpg',
  ),
  Evento(
    titulo: 'Coloquio de investigación estudiantil',
    categoria: 'Académicos',
    inicio: DateTime(2026, 10, 1, 11, 0),
    duracion: const Duration(hours: 4),
    lugar: 'Sala de Usos Múltiples',
    cupo: 90,
    inscritos: 61,
    resumen:
        'Veinte proyectos de licenciatura presentados en formato cartel, con ronda de '
        'preguntas de investigadores del área.',
    imagen: '$_fotos/coloquio-investigacion.jpg',
  ),
  Evento(
    titulo: 'Charla de ciberseguridad ofensiva',
    categoria: 'Tecnología',
    inicio: DateTime(2026, 10, 2, 13, 0),
    duracion: const Duration(hours: 2),
    lugar: 'Sala Audiovisual',
    cupo: 70,
    inscritos: 38,
    resumen:
        'Cómo se ve un ataque real desde el lado del atacante, con una demostración en '
        'vivo sobre un laboratorio controlado.',
    imagen: '$_fotos/ciberseguridad.jpg',
  ),
  Evento(
    titulo: 'Carrera atlética 5K Campus',
    categoria: 'Deportivos',
    inicio: DateTime(2026, 10, 4, 7, 0),
    duracion: const Duration(hours: 3),
    lugar: 'Pista de Tartán, Ciudad Universitaria',
    cupo: 400,
    inscritos: 268,
    resumen:
        'Ruta de cinco kilómetros dentro del campus, con categorías libre y estudiantil. '
        'Incluye playera y chip de cronometraje.',
    imagen: '$_fotos/carrera-5k.jpg',
    destacado: true,
  ),
  Evento(
    titulo: 'Taller de finanzas personales',
    categoria: 'Talleres',
    inicio: DateTime(2026, 10, 5, 16, 0),
    duracion: const Duration(hours: 2),
    lugar: 'Aula 205, Edificio 46',
    cupo: 45,
    inscritos: 19,
    resumen:
        'Presupuesto, deuda estudiantil y primeras inversiones, con ejercicios sobre el '
        'ingreso real de un estudiante.',
    imagen: '$_fotos/taller-finanzas.jpg',
  ),
  Evento(
    titulo: 'Exposición fotográfica: Rostros del Campus',
    categoria: 'Culturales',
    inicio: DateTime(2026, 10, 7, 11, 0),
    duracion: const Duration(hours: 8),
    lugar: 'Galería del Edificio 1',
    cupo: 80,
    inscritos: 23,
    resumen:
        'Cuarenta retratos del personal que sostiene la universidad y casi nadie ve. '
        'La visita guiada sale cada hora.',
    imagen: '$_fotos/expo-fotografica.jpg',
  ),
  Evento(
    titulo: 'Conferencia: inteligencia artificial y ética',
    categoria: 'Académicos',
    inicio: DateTime(2026, 10, 8, 10, 0),
    duracion: const Duration(hours: 2),
    lugar: 'Auditorio Central',
    cupo: 120,
    inscritos: 118,
    resumen:
        'Qué decide un modelo y quién responde por esa decisión, con casos de sistemas '
        'ya en uso en el sector público.',
    imagen: '$_fotos/conferencia-ia.jpg',
    destacado: true,
  ),
  Evento(
    titulo: 'Demo Day de robótica',
    categoria: 'Tecnología',
    inicio: DateTime(2026, 10, 9, 16, 0),
    duracion: const Duration(hours: 3),
    lugar: 'Nave de Manufactura, Edificio 63',
    cupo: 100,
    inscritos: 47,
    resumen:
        'Los seis prototipos del semestre funcionando frente a público, incluida la celda '
        'de clasificación que compitió en Querétaro.',
    imagen: '$_fotos/demo-robotica.jpg',
  ),
  Evento(
    titulo: 'Clínica de voleibol de playa',
    categoria: 'Deportivos',
    inicio: DateTime(2026, 10, 11, 9, 0),
    duracion: const Duration(hours: 3),
    lugar: 'Canchas de Arena',
    cupo: 48,
    inscritos: 31,
    resumen:
        'Entrenamiento abierto con el cuerpo técnico de la selección universitaria. '
        'No se necesita experiencia previa.',
    imagen: '$_fotos/voleibol-playa.jpg',
  ),
  Evento(
    titulo: 'Taller de primeros auxilios',
    categoria: 'Talleres',
    inicio: DateTime(2026, 10, 12, 9, 0),
    duracion: const Duration(hours: 5),
    lugar: 'Centro de Ciencias de la Salud',
    cupo: 35,
    inscritos: 35,
    resumen:
        'Certificación básica en RCP y manejo de heridas, con práctica en maniquí y '
        'evaluación al final de la sesión.',
    imagen: '$_fotos/primeros-auxilios.jpg',
  ),
  Evento(
    titulo: 'Feria de posgrados 2026',
    categoria: 'Académicos',
    inicio: DateTime(2026, 10, 15, 10, 0),
    duracion: const Duration(hours: 6),
    lugar: 'Explanada del Edificio 46',
    cupo: 300,
    inscritos: 97,
    resumen:
        'Treinta programas de maestría y doctorado con asesoría directa de los '
        'coordinadores, más una mesa de becas CONAHCYT.',
    imagen: '$_fotos/feria-posgrados.jpg',
  ),
  Evento(
    titulo: 'Panel: empleabilidad en desarrollo de software',
    categoria: 'Tecnología',
    inicio: DateTime(2026, 10, 16, 17, 0),
    duracion: const Duration(hours: 2),
    lugar: 'Auditorio de Informática',
    cupo: 110,
    inscritos: 72,
    resumen:
        'Cuatro egresados cuentan cómo consiguieron su primer trabajo y qué les preguntaron '
        'en la entrevista técnica.',
    imagen: '$_fotos/panel-empleabilidad.jpg',
  ),
  Evento(
    titulo: 'Reto de ajedrez relámpago',
    categoria: 'Deportivos',
    inicio: DateTime(2026, 10, 18, 12, 0),
    duracion: const Duration(hours: 4),
    lugar: 'Vestíbulo del Edificio 8',
    cupo: 64,
    inscritos: 52,
    resumen:
        'Sistema suizo a cinco minutos por jugador. Los tableros y relojes los pone el '
        'club de ajedrez.',
    imagen: '$_fotos/ajedrez-relampago.jpg',
  ),
  Evento(
    titulo: 'Jornada de titulación y servicio social',
    categoria: 'Académicos',
    inicio: DateTime(2026, 10, 22, 9, 0),
    duracion: const Duration(hours: 4),
    lugar: 'Aula Magna',
    cupo: 150,
    inscritos: 44,
    resumen:
        'Todas las modalidades de titulación explicadas con sus tiempos y requisitos, '
        'y una mesa para dudas de servicio social.',
    imagen: '$_fotos/jornada-titulacion.jpg',
  ),
  Evento(
    titulo: 'Concierto de la orquesta universitaria',
    categoria: 'Culturales',
    inicio: DateTime(2026, 10, 24, 19, 30),
    duracion: const Duration(hours: 2),
    lugar: 'Teatro Universitario',
    cupo: 220,
    inscritos: 205,
    resumen:
        'Programa de música mexicana del siglo XX con dos solistas invitados del '
        'conservatorio.',
    imagen: '$_fotos/orquesta-universitaria.jpg',
  ),
  Evento(
    titulo: 'Exposición de arte contemporáneo',
    categoria: 'Culturales',
    inicio: DateTime(2026, 10, 28, 11, 0),
    duracion: const Duration(hours: 7),
    lugar: 'Galería Universitaria',
    cupo: 90,
    inscritos: 37,
    resumen:
        'Obra reciente de estudiantes de artes visuales, con piezas de gran formato '
        'hechas para este espacio.',
    imagen: '$_fotos/arte-contemporaneo.jpg',
  ),
];
