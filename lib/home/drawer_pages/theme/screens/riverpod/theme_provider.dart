// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sample/home/drawer_pages/theme/screens/riverpod/theme_state.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ThemeProvider extends StateNotifier<ThemeState>{
//   ThemeProvider():super(ThemeInitial());

//    Future<void> setTheme(int theme) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('theme', theme);
//     state = state.copyWith(selectedTheme: theme);
//   }

//    Future<void> getTheme() async {
//     final prefs = await SharedPreferences.getInstance();
//     final theme = prefs.getInt('theme') ?? 0;
//     state = state.copyWith(selectedTheme: theme);
//   }
// }