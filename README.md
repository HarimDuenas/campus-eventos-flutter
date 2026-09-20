# Campus Eventos

Cartelera de eventos universitarios hecha en Flutter. Permite consultar las actividades del
semestre, filtrarlas por categoría, buscarlas por nombre o lugar y guardarlas en una agenda
personal.

## Cómo correrlo

```bash
flutter pub get
flutter run
```

Funciona en Android, iOS, Windows y web. No usa paquetes externos ni pide conexión a internet:
las 22 fotos y las dos tipografías están dentro del proyecto.

## Organización del código

```text
lib/
├── main.dart                     arranque de la app y MaterialApp
├── data/
│   └── event_data.dart           las 22 actividades y la lista de categorías
├── models/
│   └── evento.dart               clase Evento y los datos derivados del cupo
├── utils/
│   └── fechas.dart               formato de fechas en español, sin el paquete intl
├── theme/
│   └── app_theme.dart            paleta, tipografías y estilo de cada componente
├── screens/
│   └── home_page.dart            estado, filtrado y las dos distribuciones
└── widgets/
    ├── brand_header.dart         monograma, lema y píldora de "Mi agenda"
    ├── capacity_bar.dart         barra de ocupación del cupo
    ├── category_chip.dart        ChoiceChip de categoría con su contador
    ├── category_tag.dart         etiqueta de categoría y sello de aviso
    ├── data_row.dart             renglón de icono más texto
    ├── date_block.dart           bloque de fecha estilo taco de calendario
    ├── empty_state.dart          pantalla de "no hay resultados"
    ├── event_card.dart           tarjeta cartel para la rejilla
    ├── event_image.dart          foto con respaldo si el archivo falla
    ├── event_row_card.dart       tarjeta horizontal para celular
    ├── event_sheet.dart          ficha completa en hoja inferior
    ├── featured_card.dart        tarjeta del carrusel de destacados
    ├── interest_button.dart      botón "Me interesa" / "En tu agenda"
    └── section_header.dart       rótulo de sección con línea
```

## Diseño responsivo

La pantalla tiene tres estados, decididos con `MediaQuery.sizeOf(context).width`:

| Ancho | Distribución |
|---|---|
| menos de 700 px | una columna, tarjetas horizontales, cabecera que se encoge al hacer scroll |
| 700 a 979 px | una columna, rejilla de tarjetas cartel |
| 980 px o más | barra lateral fija de filtros más rejilla, con el contenido topado a 1400 px |

## Qué hace cada interacción

- **Categorías**: `ChoiceChip` en fila horizontal (celular) o en columna (escritorio). Cada chip
  muestra cuántos eventos trae con los filtros actuales. `Todos` deja pasar todo.
- **Buscar**: filtra por nombre del evento y por lugar, y se combina con la categoría activa.
- **Con lugares disponibles**: esconde los eventos con el cupo lleno.
- **Me interesa**: guarda el evento en la agenda, lanza un `SnackBar` con el nombre del evento y
  deja un botón de deshacer. El mismo botón lo quita.
- **Mi agenda**: la píldora del encabezado muestra cuántos llevas y filtra solo esos.
- **Tocar una tarjeta**: abre la ficha completa en una hoja inferior, sin salir de la cartelera.

## Elementos de Flutter que se usan

`StatefulWidget`, `setState()`, `ListView`, `GridView`, `Card`, `Image`, `Row`, `Column`,
`ChoiceChip` y `SnackBar`, además de `CustomScrollView`, `SliverAppBar`, `FilterChip`,
`LayoutBuilder` indirecto vía `MediaQuery`, `Stack` y `showModalBottomSheet`.

## Créditos

Fotografías de Unsplash, bajo su licencia de uso libre. Tipografías Zilla Slab y Barlow, bajo
licencia SIL Open Font License.
