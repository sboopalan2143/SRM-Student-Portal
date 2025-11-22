import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sample/theme/dark_theme.dart';
import 'package:sample/theme/light_theme.dart';

class ThemeProvider with ChangeNotifier, WidgetsBindingObserver {
  // Track the selected color family (default, orange, red, green)

  ThemeProvider()
      : _themeData = lightMode(defaultLight),
        _primaryColorScheme = defaultLight {
    _loadTheme();
    WidgetsBinding.instance.addObserver(this);
  }
  ThemeData _themeData;
  ColorScheme _primaryColorScheme;
  int _themeMode = 2; // Default to System Theme (0: Light, 1: Dark, 2: System)
  // bool _defaultIcon = true;
  bool _isLoading = true;
  int? selectedIndex;
  String _colorFamily = 'default';

  @override
  void didChangePlatformBrightness() {
    if (_themeMode == 2) {
      // log("System brightness changed, updating theme");
      _updateColorSchemeForMode(); // Update ColorScheme based on new system brightness
      _updateTheme();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      // textTheme: GoogleFonts.openSansTextTheme(),
      colorScheme: _themeData.colorScheme,
      scaffoldBackgroundColor: _themeData.scaffoldBackgroundColor,
    );
  }

  ColorScheme get primaryColorScheme => _primaryColorScheme;
  bool get isDarkMode => _themeMode == 1 || (_themeMode == 2 && _isSystemDarkMode());
  // bool get defaultIcon => _defaultIcon;
  int get themeMode => _themeMode;
  bool get isLoading => _isLoading;
  String get colorFamily => _colorFamily;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void setThemeMode(int mode) {
    _themeMode = mode;
    // log('Setting themeMode: $mode');
    _updateColorSchemeForMode(); // Update ColorScheme based on mode and family
    _updateTheme();
    saveTheme();
  }

  bool _isSystemDarkMode() {
    final isDark = PlatformDispatcher.instance.platformBrightness == Brightness.dark;
    // log('System Dark Mode: $isDark');
    return isDark;
  }

  void _updateTheme() {
    // log('Updating theme: themeMode=$_themeMode, primaryColorScheme=$_primaryColorScheme, colorFamily=$_colorFamily');
    // log('System Theme: ${_isSystemDarkMode()}');

    if (_themeMode == 2) {
      _themeData = _isSystemDarkMode() ? darkMode(_primaryColorScheme) : lightMode(_primaryColorScheme);
    } else if (_themeMode == 1) {
      _themeData = darkMode(_primaryColorScheme);
    } else {
      _themeData = lightMode(_primaryColorScheme);
    }

    // log('Theme applied: isDarkMode=$isDarkMode');
    notifyListeners();
  }

  void _updateColorSchemeForMode() {
    // Update _primaryColorScheme to the light or dark variant of the current color family
    final useDark = _themeMode == 1 || (_themeMode == 2 && _isSystemDarkMode());
    switch (_colorFamily) {
      case 'orange':
        _primaryColorScheme = useDark ? darkOrange : lightOrange;
      case 'purple':
        _primaryColorScheme = useDark ? darkPurple : lightPurple;
      case 'teal':
        _primaryColorScheme = useDark ? darkTeal : lightTeal;
      case 'red':
        _primaryColorScheme = useDark ? darkRed : lightRed;
      case 'green':
        _primaryColorScheme = useDark ? darkGreen : lightGreen;
      case 'blue':
        _primaryColorScheme = useDark ? darkBlue : lightBlue;
      case 'pink':
        _primaryColorScheme = useDark ? darkPink : lightPink;
      case 'default':
      default:
        _primaryColorScheme = useDark ? defaultDark : defaultLight;
    }
    // log('Updated ColorScheme for mode: $_primaryColorScheme');
  }

  void checkFordefaultIcon() {
    // _defaultIcon = !_defaultIcon;
    notifyListeners();
    saveTheme();
  }

  void setColorScheme(ColorScheme colorScheme) {
    _primaryColorScheme = colorScheme;
    _colorFamily = _getFamilyFromColorScheme(colorScheme); // Update color family
    // log('Setting color scheme: $colorScheme, family: $_colorFamily');
    _updateTheme();
    saveTheme();
  }

  Future<void> _loadTheme() async {
    final themeBox = await Hive.openBox('themeBox');
    _themeMode = (themeBox.get('themeMode') as int?) ?? 2;

    // log('Loaded themeMode from Hive: $_themeMode');

    final colorFamily = themeBox.get('colorFamily').toString();
    _colorFamily = colorFamily;
    // log('Loaded colorFamily from Hive: $_colorFamily');

    _updateColorSchemeForMode(); // Set initial ColorScheme based on loaded family and mode
    _updateTheme();
    await Future.delayed(const Duration(seconds: 2));
    _isLoading = false;
    notifyListeners();
  }

  ColorScheme getColorSchemeFromKey(String? key) {
    // log('Getting color scheme for key: $key');
    switch (key) {
      case 'lightOrange':
        return lightOrange;
      case 'lightPurple':
        return lightOrange;
      case 'lightTeal':
        return lightOrange;
      case 'lightRed':
        return lightRed;
      case 'lightGreen':
        return lightGreen;
      case 'lightBlue':
        return lightBlue;
      case 'lightPink':
        return lightPink;
      case 'darkOrange':
        return darkOrange;
      case 'darkPurple':
        return darkOrange;
      case 'darkTeal':
        return darkOrange;
      case 'darkRed':
        return darkRed;
      case 'darkGreen':
        return darkGreen;
      case 'darkBlue':
        return darkBlue;
      case 'darkPink':
        return darkPink;
      case 'defaultDark':
        return defaultDark;
      case 'defaultLight':
        return defaultLight;
      default:
        return defaultLight; // Initial default
    }
  }

  Future<void> saveTheme() async {
    final themeBox = Hive.box('themeBox');
    await themeBox.put('themeMode', _themeMode);
    await themeBox.put('colorFamily', _colorFamily); // Save family instead of full scheme
    // await themeBox.put('defaultIcon', _defaultIcon);
    // log('Saved themeMode: $_themeMode');
    // log('Saved colorFamily: $_colorFamily');
  }

  String _getFamilyFromColorScheme(ColorScheme colorScheme) {
    if (_isColorSchemeEqual(colorScheme, lightOrange) || _isColorSchemeEqual(colorScheme, darkOrange)) {
      return 'orange';
    }
    if (_isColorSchemeEqual(colorScheme, lightPurple) || _isColorSchemeEqual(colorScheme, darkPurple)) {
      return 'purple';
    }
    if (_isColorSchemeEqual(colorScheme, lightTeal) || _isColorSchemeEqual(colorScheme, darkTeal)) {
      return 'teal';
    }
    if (_isColorSchemeEqual(colorScheme, lightRed) || _isColorSchemeEqual(colorScheme, darkRed)) {
      return 'red';
    }
    if (_isColorSchemeEqual(colorScheme, lightGreen) || _isColorSchemeEqual(colorScheme, darkGreen)) {
      return 'green';
    }
    if (_isColorSchemeEqual(colorScheme, lightBlue) || _isColorSchemeEqual(colorScheme, darkBlue)) {
      return 'blue';
    }
    if (_isColorSchemeEqual(colorScheme, lightPink) || _isColorSchemeEqual(colorScheme, darkPink)) {
      return 'pink';
    }
    return 'default';
  }

  bool _isColorSchemeEqual(ColorScheme a, ColorScheme b) {
    return a.primary == b.primary &&
        a.inversePrimary == b.inversePrimary &&
        a.secondary == b.secondary &&
        a.surface == b.surface &&
        a.inverseSurface == b.inverseSurface &&
        a.tertiary == b.tertiary;
  }
}
