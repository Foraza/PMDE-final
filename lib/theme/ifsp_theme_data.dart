// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import 'package:ifsp_aluno/theme/color_schemes.g.dart';

enum IFSPThemeMode {
  lightMode,
  darkMode,
}

class IFSPThemeData {
  static bool isLightMode(IFSPThemeMode themeMode) {
    return themeMode == IFSPThemeMode.lightMode;
  }

  static AppBarTheme _appBarTheme(IFSPThemeMode themeMode) {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: isLightMode(themeMode) ? Colors.black : Colors.white,
      iconTheme: IconThemeData(color: isLightMode(themeMode) ? Colors.black : Colors.white),
      elevation: 0,
      centerTitle: true,
    );
  }

  static TextTheme _textTheme(IFSPThemeMode themeMode) {
    return const TextTheme(
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
    ).apply(
      bodyColor: isLightMode(themeMode) ? Colors.black : Colors.white,
      displayColor: isLightMode(themeMode) ? Colors.black : Colors.white,
    );
  }

  static ThemeData theme({IFSPThemeMode themeMode = IFSPThemeMode.lightMode, bool useMaterial3 = true}) {
    return ThemeData(
      useMaterial3: useMaterial3,
      colorScheme: isLightMode(themeMode) ? lightColorScheme : darkColorScheme,
      fontFamily: GoogleFonts.openSans().fontFamily,
      textTheme: _textTheme(themeMode),
      appBarTheme: _appBarTheme(themeMode),
    );
  }

  ThemeData get themeData => ThemeData();
}
