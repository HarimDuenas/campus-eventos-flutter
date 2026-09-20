import 'package:flutter/material.dart';

// Paleta de la cartelera: papel calido, tinta verdosa y un solo acento reservado para las acciones.
class Paleta {
  const Paleta._();

  static const tinta = Color(0xFF16221F);
  static const tintaMedia = Color(0xFF4A5551);
  static const tintaSuave = Color(0xFF7C837E);
  static const papel = Color(0xFFF3EFE7);
  static const papelHundido = Color(0xFFE9E3D6);
  static const lienzo = Color(0xFFFFFFFF);
  static const trazo = Color(0xFFDCD5C6);
  static const acento = Color(0xFFC1552B);
  static const acentoTenue = Color(0xFFF7E7DE);
  static const alerta = Color(0xFF9A3412);
}

// Color e icono con los que se reconoce una categoria en toda la app sin leer su nombre.
class SelloCategoria {
  const SelloCategoria(this.color, this.icono);

  final Color color;
  final IconData icono;
}

const Map<String, SelloCategoria> _sellos = {
  'Académicos': SelloCategoria(Color(0xFF2F5D8C), Icons.school_outlined),
  'Deportivos': SelloCategoria(Color(0xFF3B7A57), Icons.sports_soccer_outlined),
  'Culturales': SelloCategoria(
    Color(0xFFA8433A),
    Icons.theater_comedy_outlined,
  ),
  'Tecnología': SelloCategoria(Color(0xFF574B9E), Icons.memory_outlined),
  'Talleres': SelloCategoria(Color(0xFFB07B22), Icons.handyman_outlined),
};

// Si llega una categoria que no esta en el mapa se devuelve el acento, asi nunca truena por una llave nueva.
SelloCategoria selloDe(String categoria) =>
    _sellos[categoria] ??
    const SelloCategoria(Paleta.acento, Icons.event_outlined);

class AppTheme {
  const AppTheme._();

  // Serif con remate cuadrado para los titulos y grotesca estrecha para el texto corrido.
  static const String titulos = 'ZillaSlab';
  static const String textos = 'Barlow';

  // Radio chico a proposito: la esquina casi recta es lo que hace que se lea como cartel impreso.
  static const double radio = 3;

  static ThemeData get cartelera {
    const esquema = ColorScheme.light(
      primary: Paleta.tinta,
      onPrimary: Paleta.papel,
      secondary: Paleta.acento,
      onSecondary: Colors.white,
      surface: Paleta.lienzo,
      onSurface: Paleta.tinta,
      surfaceContainerHighest: Paleta.papelHundido,
      outline: Paleta.trazo,
      outlineVariant: Paleta.trazo,
      error: Paleta.alerta,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: esquema,
      fontFamily: textos,
      scaffoldBackgroundColor: Paleta.papel,
      textTheme: _tipografia,
      dividerTheme: const DividerThemeData(
        color: Paleta.trazo,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardThemeData(
        color: Paleta.lienzo,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radio),
          side: const BorderSide(color: Paleta.trazo),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Paleta.lienzo,
        selectedColor: Paleta.tinta,
        disabledColor: Paleta.papelHundido,
        side: const BorderSide(color: Paleta.trazo),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radio),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Paleta.lienzo,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        hintStyle: const TextStyle(color: Paleta.tintaSuave, fontSize: 14),
        border: _borde(Paleta.trazo),
        enabledBorder: _borde(Paleta.trazo),
        focusedBorder: _borde(Paleta.tinta, grosor: 1.6),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: Paleta.tinta,
          foregroundColor: Paleta.papel,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radio),
          ),
          textStyle: const TextStyle(
            fontFamily: textos,
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Paleta.tinta,
          side: const BorderSide(color: Paleta.tinta, width: 1.3),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radio),
          ),
          textStyle: const TextStyle(
            fontFamily: textos,
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Paleta.tinta,
        actionTextColor: const Color(0xFFE8A57C),
        elevation: 6,
        insetPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radio),
        ),
        contentTextStyle: const TextStyle(
          fontFamily: textos,
          fontSize: 14,
          color: Paleta.papel,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Paleta.papel,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radio)),
        ),
      ),
    );
  }

  static OutlineInputBorder _borde(Color color, {double grosor = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radio),
      borderSide: BorderSide(color: color, width: grosor),
    );
  }

  // Los tamanos suben de golpe entre niveles para que la jerarquia se note sin negritas de mas.
  static const TextTheme _tipografia = TextTheme(
    headlineMedium: TextStyle(
      fontFamily: titulos,
      fontSize: 26,
      fontWeight: FontWeight.w700,
      height: 1.1,
      letterSpacing: -0.3,
      color: Paleta.tinta,
    ),
    headlineSmall: TextStyle(
      fontFamily: titulos,
      fontSize: 21,
      fontWeight: FontWeight.w600,
      height: 1.15,
      color: Paleta.tinta,
    ),
    titleLarge: TextStyle(
      fontFamily: titulos,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      height: 1.2,
      color: Paleta.tinta,
    ),
    titleMedium: TextStyle(
      fontFamily: titulos,
      fontSize: 15.5,
      fontWeight: FontWeight.w600,
      height: 1.25,
      color: Paleta.tinta,
    ),
    bodyLarge: TextStyle(
      fontFamily: textos,
      fontSize: 15,
      height: 1.45,
      color: Paleta.tintaMedia,
    ),
    bodyMedium: TextStyle(
      fontFamily: textos,
      fontSize: 13.5,
      height: 1.4,
      color: Paleta.tintaMedia,
    ),
    bodySmall: TextStyle(
      fontFamily: textos,
      fontSize: 12,
      height: 1.35,
      color: Paleta.tintaSuave,
    ),
    labelLarge: TextStyle(
      fontFamily: textos,
      fontSize: 13.5,
      fontWeight: FontWeight.w600,
      color: Paleta.tinta,
    ),
    // Version versalita para las etiquetas cortas: mayusculas chicas muy espaciadas.
    labelSmall: TextStyle(
      fontFamily: textos,
      fontSize: 10.5,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: Paleta.tintaSuave,
    ),
  );
}
