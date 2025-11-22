import 'package:flutter/material.dart';

ThemeData darkMode(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
  );
}

// Define the dark color schemes
ColorScheme defaultDark = const ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Color.fromARGB(255, 28, 83, 102), // Darker shade of navy blue
  inversePrimary: Color.fromARGB(255, 28, 83, 102), // Vibrant blue with a lighter tone
  secondary: Color.fromARGB(255, 28, 83, 102), // Slightly lighter navy blue
  tertiary: Color.fromARGB(255, 28, 83, 102), // Deep navy blue
);

ColorScheme darkPurple = const ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Color.fromARGB(255, 37, 14, 59),
  inversePrimary: Color.fromARGB(255, 57, 49, 134),
  secondary: Color.fromARGB(255, 47, 39, 114),
  tertiary: Color.fromARGB(255, 42, 29, 90),
);

ColorScheme darkTeal = ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Colors.teal.shade900,
  inversePrimary: Colors.teal.shade300,
  secondary: Colors.teal,
  tertiary: Colors.teal.shade700,
);

ColorScheme darkOrange = ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Colors.orange.shade900,
  inversePrimary: Colors.orange.shade300,
  secondary: Colors.orange,
  tertiary: Colors.orange.shade700,
);

ColorScheme darkRed = ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Colors.red.shade900,
  inversePrimary: Colors.red.shade300,
  secondary: Colors.red,
  tertiary: Colors.red.shade700,
);

ColorScheme darkGreen = ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Colors.green.shade900,
  inversePrimary: Colors.green.shade300,
  secondary: Colors.green,
  tertiary: Colors.green.shade700,
);

ColorScheme darkBlue = ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Colors.blue.shade900,
  inversePrimary: Colors.blue.shade300,
  secondary: Colors.blue,
  tertiary: Colors.blue.shade700,
);

ColorScheme darkPink = ColorScheme.dark(
  surface: Colors.black,
  inverseSurface: Colors.white,
  primary: Colors.pink.shade900,
  inversePrimary: Colors.pink.shade300,
  secondary: Colors.pink,
  tertiary: Colors.pink.shade700,
);
