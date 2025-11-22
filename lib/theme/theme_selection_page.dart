import 'dart:developer';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sample/theme/dark_theme.dart';
import 'package:sample/theme/light_theme.dart';
import 'package:sample/theme/theme_provider.dart';

class ThemeSelectionPage extends StatefulWidget {
  const ThemeSelectionPage({super.key});

  @override
  ThemeSelectionPageState createState() => ThemeSelectionPageState();
}

class ThemeSelectionPageState extends State<ThemeSelectionPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final String text2;
    switch (themeProvider.themeMode) {
      case 0:
        text2 = 'Light Mode';
      case 1:
        text2 = 'Dark Mode';
      case 2:
        text2 = 'System Theme';
      default:
        text2 = 'System Theme'; // Fallback to system
    }
    // final String text3 = themeProvider.defaultIcon ? "Default" : "Theme Icon";

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Themes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Theme Mode Toggle (Light/Dark/System)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                AnimatedToggleSwitch<int>.rolling(
                  indicatorSize: const Size.fromWidth(64),
                  animationDuration: const Duration(milliseconds: 800),
                  current: themeProvider.themeMode,
                  values: const [0, 1, 2], // Light, Dark, System
                  onChanged: (value) {
                    HapticFeedback.mediumImpact();
                    setState(() {
                      themeProvider.setThemeMode(value);
                    });
                    log('Theme Mode: ${themeProvider.themeMode}, isDarkMode: ${themeProvider.isDarkMode}');
                  },
                  iconList: const [
                    Icon(Icons.brightness_7_rounded), // Light
                    Icon(Icons.brightness_3_rounded), // Dark
                    Icon(Icons.brightness_6_rounded), // System
                  ],
                  style: ToggleStyle(
                    indicatorGradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.inversePrimary,
                      ],
                      end: Alignment.bottomRight,
                      begin: Alignment.topLeft,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Icon Theme:',
            //       style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Theme.of(context).colorScheme.inverseSurface,
            //       ),
            //     ),
            //     Row(
            //       children: [
            //         Text(
            //           text3,
            //           style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Theme.of(context).colorScheme.inversePrimary,
            //           ),
            //         ),
            //         Checkbox(
            //           value: themeProvider.defaultIcon,
            //           onChanged: (value) {
            //             setState(() {
            //               HapticFeedback.mediumImpact();
            //               themeProvider.checkFordefaultIcon();
            //             });
            //             log("${themeProvider.defaultIcon}");
            //           },
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            //  SizedBox(height: 20),
            const Text(
              'Select Custom Theme:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Default', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? defaultDark : defaultLight,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Purple', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? darkPurple : lightPurple,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Green', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? darkGreen : lightGreen,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Teal', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? darkTeal : lightTeal,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Red', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? darkRed : lightRed,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Orange', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? darkOrange : lightOrange,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Blue', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? darkBlue : lightBlue,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                    Flexible(
                      child: RadioListTile<ColorScheme>(
                        title: const Text('Pink', style: TextStyle(fontWeight: FontWeight.bold)),
                        value: themeProvider.isDarkMode ? darkPink : lightPink,
                        groupValue: themeProvider.primaryColorScheme,
                        onChanged: (value) {
                          HapticFeedback.mediumImpact();
                          if (value != null) {
                            setState(() {
                              themeProvider.setColorScheme(value);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                themeProvider.saveTheme();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                elevation: 10,
                fixedSize: const Size(125, 50),
                backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
