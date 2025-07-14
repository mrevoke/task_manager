import 'package:flutter/material.dart';
import 'custom_theme.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    colorScheme: CustomTheme.lightColorScheme,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
  );
}
