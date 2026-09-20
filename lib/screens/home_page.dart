import 'package:flutter/material.dart';

import '../data/event_data.dart';
import '../models/evento.dart';
import '../theme/app_theme.dart';
import '../widgets/brand_header.dart';
import '../widgets/category_chip.dart';
import '../widgets/empty_state.dart';
import '../widgets/event_card.dart';
import '../widgets/event_row_card.dart';
import '../widgets/event_sheet.dart';
import '../widgets/featured_card.dart';
import '../widgets/section_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Desde este ancho cabe la barra lateral de filtros al lado del contenido.
  static const double _anchoConBarra = 980;

  // Debajo de este ancho las tarjetas se vuelven horizontales porque una rejilla ya no se lee.
  static const double _anchoConRejilla = 700;

  static const double _anchoMaximoContenido = 1400;

  String categoriaSeleccionada = 'Todos';
  String _busqueda = '';
  bool _soloConLugares = false;
  bool _soloAgenda = false;

  // Se guardan titulos y no objetos Evento: el titulo es lo unico que no cambia al recargar los datos.
  final Set<String> _agenda = <String>{};

  final TextEditingController _buscador = TextEditingController();

  @override
  void dispose() {
    _buscador.dispose();
    super.dispose();
  }

  bool get _hayFiltros =>
      categoriaSeleccionada != 'Todos' ||
      _busqueda.trim().isNotEmpty ||
      _soloConLugares ||
      _soloAgenda;

  // Filtros que no dependen de la categoria; van aparte para poder contar cuantos eventos trae cada chip.
  bool _pasaFiltrosGenerales(Evento evento) {
    final texto = _busqueda.trim().toLowerCase();
    final coincideTexto =
        texto.isEmpty ||
        evento.titulo.toLowerCase().contains(texto) ||
        evento.lugar.toLowerCase().contains(texto);
    final hayLugares = !_soloConLugares || !evento.agotado;
    final estaGuardado = !_soloAgenda || _agenda.contains(evento.titulo);
    return coincideTexto && hayLugares && estaGuardado;
  }

  // Aqui vive el filtrado que pide la practica: 'Todos' deja pasar todo y cualquier otra categoria recorta.
  List<Evento> get _eventosFiltrados => eventos
      .where(
        (evento) =>
            _pasaFiltrosGenerales(evento) &&
            (categoriaSeleccionada == 'Todos' ||
                evento.categoria == categoriaSeleccionada),
      )
      .toList();

  int _conteoDe(String categoria) => eventos
      .where(
        (evento) =>
            _pasaFiltrosGenerales(evento) &&
            (categoria == 'Todos' || evento.categoria == categoria),
      )
      .length;

  void _limpiarFiltros() {
    setState(() {
      categoriaSeleccionada = 'Todos';
      _busqueda = '';
      _soloConLugares = false;
      _soloAgenda = false;
      _buscador.clear();
    });
  }

  void _alternarInteres(Evento evento) {
    final estaba = _agenda.contains(evento.titulo);

    setState(() {
      if (estaba) {
        _agenda.remove(evento.titulo);
      } else {
        _agenda.add(evento.titulo);
      }
    });

    // clearSnackBars evita que se encimen avisos si se marcan varios eventos seguidos.
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          // Sin esto no se cierra solo: desde Flutter 3.47 un SnackBar con accion nace con persist en true.
          persist: false,
          content: Row(
            children: [
              Icon(
                estaba ? Icons.bookmark_remove_outlined : Icons.bookmark_added,
                size: 19,
                color: Paleta.papel,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  estaba
                      ? 'Quitaste "${evento.titulo}" de tu agenda'
                      : 'Guardaste "${evento.titulo}" en tu agenda',
                ),
              ),
            ],
          ),
          action: SnackBarAction(
            label: 'Deshacer',
            onPressed: () => _deshacer(evento, volverAGuardar: estaba),
          ),
        ),
      );
  }

  // El deshacer no vuelve a lanzar un SnackBar, si no se quedarian encadenandose uno tras otro.
  void _deshacer(Evento evento, {required bool volverAGuardar}) {
    if (!mounted) return;
    setState(() {
      if (volverAGuardar) {
        _agenda.add(evento.titulo);
      } else {
        _agenda.remove(evento.titulo);
      }
    });
  }

  void _abrirDetalle(Evento evento) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(maxWidth: 560),
      // StatefulBuilder deja que la hoja se redibuje sola al marcar interes sin cerrarla.
      builder: (_) => StatefulBuilder(
        builder: (_, redibujarHoja) => DetalleEvento(
          evento: evento,
          interesado: _agenda.contains(evento.titulo),
          onInteres: () {
            _alternarInteres(evento);
            redibujarHoja(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.sizeOf(context).width;
    final conBarra = ancho >= _anchoConBarra;
    final conRejilla = ancho >= _anchoConRejilla;

    final filtrados = _eventosFiltrados;

    // Los destacados solo aparecen sin filtros: con un filtro activo estorban y confunden el conteo.
    final destacados = _hayFiltros
        ? const <Evento>[]
        : eventos.where((e) => e.destacado).toList();

    return Scaffold(
      body: conBarra
          ? _vistaEscritorio(filtrados, destacados)
          : _vistaApilada(filtrados, destacados, conRejilla: conRejilla),
    );
  }

  // Distribucion de celular y tablet: todo en una columna, con la cabecera que se encoge al hacer scroll.
  Widget _vistaApilada(
    List<Evento> filtrados,
    List<Evento> destacados, {
    required bool conRejilla,
  }) {
    final margenSuperior =
        MediaQuery.paddingOf(context).top + kToolbarHeight + 14;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 196,
          backgroundColor: Paleta.tinta,
          foregroundColor: Paleta.papel,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 16,
          title: const MarcaCampus(pequena: true),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: PildoraAgenda(
                cantidad: _agenda.length,
                activa: _soloAgenda,
                onTap: () => setState(() => _soloAgenda = !_soloAgenda),
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: Paleta.tinta,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.fromLTRB(16, margenSuperior, 16, 20),
              child: LemaCampus(
                totalEventos: eventos.length,
                totalCategorias: categorias.length - 1,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
            child: _campoBusqueda(),
          ),
        ),
        SliverToBoxAdapter(child: _filaCategorias()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
            child: _filtrosRapidos(),
          ),
        ),
        if (destacados.isNotEmpty)
          SliverToBoxAdapter(child: _bloqueDestacados(destacados, sangria: 16)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 26, 16, 16),
            child: EncabezadoSeccion(
              titulo: 'Cartelera',
              apunte: 'Eventos encontrados: ${filtrados.length}',
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
          sliver: SliverToBoxAdapter(
            child: filtrados.isEmpty
                ? SinResultados(
                    mensaje: _mensajeVacio(),
                    onLimpiar: _limpiarFiltros,
                  )
                : conRejilla
                ? _rejillaEventos(filtrados)
                : _listaEventos(filtrados),
          ),
        ),
      ],
    );
  }

  // Escritorio: cabecera de ancho completo, filtros fijos a la izquierda y rejilla a la derecha.
  Widget _vistaEscritorio(List<Evento> filtrados, List<Evento> destacados) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Paleta.tinta,
          padding: const EdgeInsets.fromLTRB(32, 28, 32, 28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MarcaCampus(),
                    const SizedBox(height: 16),
                    LemaCampus(
                      totalEventos: eventos.length,
                      totalCategorias: categorias.length - 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              PildoraAgenda(
                cantidad: _agenda.length,
                activa: _soloAgenda,
                onTap: () => setState(() => _soloAgenda = !_soloAgenda),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _barraLateral(),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: _anchoMaximoContenido,
                    ),
                    child: CustomScrollView(
                      slivers: [
                        if (destacados.isNotEmpty)
                          SliverToBoxAdapter(
                            child: _bloqueDestacados(destacados, sangria: 28),
                          ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(28, 28, 28, 18),
                            child: EncabezadoSeccion(
                              titulo: 'Cartelera',
                              apunte:
                                  'Eventos encontrados: ${filtrados.length}',
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(28, 0, 28, 36),
                          sliver: SliverToBoxAdapter(
                            child: filtrados.isEmpty
                                ? SinResultados(
                                    mensaje: _mensajeVacio(),
                                    onLimpiar: _limpiarFiltros,
                                  )
                                : _rejillaEventos(filtrados),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _barraLateral() {
    return Container(
      width: 296,
      decoration: const BoxDecoration(
        color: Paleta.lienzo,
        border: Border(right: BorderSide(color: Paleta.trazo)),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(22, 26, 22, 26),
        children: [
          const EncabezadoSeccion(titulo: 'Buscar'),
          const SizedBox(height: 14),
          _campoBusqueda(),
          const SizedBox(height: 28),
          const EncabezadoSeccion(titulo: 'Categorías'),
          const SizedBox(height: 14),
          for (final categoria in categorias)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CategoryChip(
                texto: categoria,
                seleccionado: categoriaSeleccionada == categoria,
                conteo: _conteoDe(categoria),
                ocupaTodoElAncho: true,
                onTap: () => setState(() => categoriaSeleccionada = categoria),
              ),
            ),
          const SizedBox(height: 22),
          const EncabezadoSeccion(titulo: 'Disponibilidad'),
          const SizedBox(height: 14),
          Align(alignment: Alignment.centerLeft, child: _chipConLugares()),
          if (_hayFiltros) ...[
            const SizedBox(height: 28),
            OutlinedButton.icon(
              onPressed: _limpiarFiltros,
              icon: const Icon(Icons.restart_alt, size: 17),
              label: const Text('Limpiar filtros'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _campoBusqueda() {
    return TextField(
      controller: _buscador,
      onChanged: (valor) => setState(() => _busqueda = valor),
      textInputAction: TextInputAction.search,
      style: const TextStyle(fontSize: 14, color: Paleta.tinta),
      decoration: InputDecoration(
        hintText: 'Buscar por nombre o lugar',
        prefixIcon: const Icon(
          Icons.search,
          size: 19,
          color: Paleta.tintaSuave,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 42),
        suffixIcon: _busqueda.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close, size: 17),
                color: Paleta.tintaSuave,
                onPressed: () => setState(() {
                  _busqueda = '';
                  _buscador.clear();
                }),
              ),
      ),
    );
  }

  // ListView horizontal para que los seis chips siempre quepan aunque la pantalla sea muy angosta.
  Widget _filaCategorias() {
    return SizedBox(
      height: 62,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categorias.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, indice) {
          final categoria = categorias[indice];

          return Center(
            child: CategoryChip(
              texto: categoria,
              seleccionado: categoriaSeleccionada == categoria,
              conteo: _conteoDe(categoria),
              onTap: () => setState(() => categoriaSeleccionada = categoria),
            ),
          );
        },
      ),
    );
  }

  Widget _filtrosRapidos() {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _chipConLugares(),
          ),
        ),
        if (_hayFiltros)
          TextButton.icon(
            onPressed: _limpiarFiltros,
            icon: const Icon(Icons.restart_alt, size: 16),
            label: const Text('Limpiar'),
            style: TextButton.styleFrom(foregroundColor: Paleta.acento),
          ),
      ],
    );
  }

  Widget _chipConLugares() {
    return FilterChip(
      selected: _soloConLugares,
      onSelected: (valor) => setState(() => _soloConLugares = valor),
      showCheckmark: false,
      selectedColor: Paleta.acentoTenue,
      side: BorderSide(color: _soloConLugares ? Paleta.acento : Paleta.trazo),
      avatar: Icon(
        Icons.event_available_outlined,
        size: 15,
        color: _soloConLugares ? Paleta.acento : Paleta.tintaSuave,
      ),
      label: Text(
        'Con lugares disponibles',
        style: TextStyle(
          fontFamily: AppTheme.textos,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
          color: _soloConLugares ? Paleta.acento : Paleta.tinta,
        ),
      ),
    );
  }

  Widget _bloqueDestacados(List<Evento> destacados, {required double sangria}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(sangria, 26, sangria, 14),
          child: const EncabezadoSeccion(
            titulo: 'No te los pierdas',
            apunte: 'Desliza para ver más',
          ),
        ),
        SizedBox(
          height: 208,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: sangria),
            itemCount: destacados.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, indice) {
              final evento = destacados[indice];

              return SizedBox(
                width: 268,
                child: FeaturedCard(
                  evento: evento,
                  onAbrir: () => _abrirDetalle(evento),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // shrinkWrap porque la rejilla vive dentro del scroll de la pantalla y no se desplaza por su cuenta.
  Widget _rejillaEventos(List<Evento> lista) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: lista.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 332,
        mainAxisExtent: 386,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, indice) {
        final evento = lista[indice];

        return EventCard(
          evento: evento,
          interesado: _agenda.contains(evento.titulo),
          onInteres: () => _alternarInteres(evento),
          onAbrir: () => _abrirDetalle(evento),
        );
      },
    );
  }

  Widget _listaEventos(List<Evento> lista) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: lista.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, indice) {
        final evento = lista[indice];

        return EventRowCard(
          evento: evento,
          interesado: _agenda.contains(evento.titulo),
          onInteres: () => _alternarInteres(evento),
          onAbrir: () => _abrirDetalle(evento),
        );
      },
    );
  }

  // El texto del estado vacio nombra el filtro culpable para que se sepa cual soltar.
  String _mensajeVacio() {
    final donde = categoriaSeleccionada == 'Todos'
        ? ''
        : ' en $categoriaSeleccionada';

    if (_soloAgenda) {
      return _agenda.isEmpty
          ? 'Todavía no guardas ningún evento. Marca "Me interesa" en los que quieras seguir.'
          : 'No tienes eventos guardados$donde.';
    }
    if (_busqueda.trim().isNotEmpty) {
      return 'Ningún evento coincide con "${_busqueda.trim()}"$donde.';
    }
    if (_soloConLugares) {
      return 'Todos los eventos$donde tienen el cupo lleno.';
    }
    return 'No hay eventos registrados$donde.';
  }
}
