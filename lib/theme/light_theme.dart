import 'package:flutter/material.dart';

ThemeData lightMode(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
  );
}

// Define the light color schemes
ColorScheme defaultLight = const ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Color.fromARGB(255, 28, 83, 102), // Vibrant blue with a lighter tone
  inversePrimary: Color.fromARGB(255, 28, 83, 102), // Darker shade of navy blue
  secondary: Color.fromARGB(255, 28, 83, 102), // Slightly lighter navy blue
  tertiary: Color.fromARGB(255, 28, 83, 102), // Deep navy blue
);

ColorScheme lightPurple = const ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Color.fromARGB(255, 57, 49, 134),
  inversePrimary: Color.fromARGB(255, 37, 14, 59),
  secondary: Color.fromARGB(255, 47, 39, 114),
  tertiary: Color.fromARGB(255, 42, 29, 90),
);

ColorScheme lightTeal = ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Colors.teal.shade300,
  inversePrimary: Colors.teal.shade900,
  secondary: Colors.teal,
  tertiary: Colors.teal.shade700,
);

ColorScheme lightOrange = ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Colors.orange.shade300,
  inversePrimary: Colors.orange.shade900,
  secondary: Colors.orange,
  tertiary: Colors.orange.shade700,
);

ColorScheme lightRed = ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Colors.red.shade300,
  inversePrimary: Colors.red.shade900,
  secondary: Colors.red,
  tertiary: Colors.red.shade700,
);

ColorScheme lightGreen = ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Colors.green.shade300,
  inversePrimary: Colors.green.shade900,
  secondary: Colors.green,
  tertiary: Colors.green.shade700,
);

ColorScheme lightBlue = ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Colors.blue.shade300,
  inversePrimary: Colors.blue.shade900,
  secondary: Colors.blue,
  tertiary: Colors.blue.shade700,
);

ColorScheme lightPink = ColorScheme.light(
  surface: Colors.white,
  inverseSurface: Colors.black,
  primary: Colors.pink.shade300,
  inversePrimary: Colors.pink.shade900,
  secondary: Colors.pink,
  tertiary: Colors.pink.shade700,
);
