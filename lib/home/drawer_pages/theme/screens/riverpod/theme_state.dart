// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:sample/home/drawer_pages/theme/screens/riverpod/theme_provider.dart';

// final themeProvider =
//     StateNotifierProvider<ThemeProvider, ThemeState>((ref) => ThemeProvider());

// class ThemeState {
//   const ThemeState({
//     required this.selectedTheme,
//   });

//   final int selectedTheme;

//   ThemeState copyWith({
//     int? selectedTheme,
//   }) =>
//       ThemeState(
//         selectedTheme: selectedTheme ?? this.selectedTheme,
//       );
// }

// class ThemeInitial extends ThemeState {
//   ThemeInitial()
//       : super(
//           selectedTheme: 0,
//         );
// }

// class ThemeLoading extends ThemeState {
//   ThemeLoading({
//     required super.selectedTheme,
//   });
// }

// class ThemeLoaded extends ThemeState {
//   ThemeLoaded({
//     required super.selectedTheme,
//   });
// }