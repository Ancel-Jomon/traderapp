import 'package:flutter/material.dart';

class Themes {
  ThemeData lightmode = ThemeData(
      colorScheme: ColorScheme.light(
          background: Colors.deepPurple,
          primary: Colors.deepPurple.shade300,
          secondary: Colors.deepPurple.shade100,
          tertiary: Colors.white,
          inversePrimary: Colors.deepPurple,
          ),
    );
}