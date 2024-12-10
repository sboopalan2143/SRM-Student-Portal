import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/theme-01/Theme_01_bottom_navigation_page.dart';
import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

class Theme02Page extends ConsumerStatefulWidget {
  const Theme02Page({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme02PageState();
}

class _Theme02PageState extends ConsumerState<Theme02Page> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // late String selectedTheme;

  @override
  Widget build(BuildContext context) {
    // final themeReadProvider = ref.read(themeProvider.notifier);
    // final selectedTheme = ref.watch(themeProvider).selectedTheme;

    //     Future<void> _saveSelectedTheme(int theme) async {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setInt('selectedTheme', theme);
    //   setState(() {
    //     selectedTheme = theme;
    //   });
    // }

    // TokensManagement.setTheme(
    //   selectedTheme: '$selectedTheme',
    // );

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.theme02secondaryColor1,
              elevation: 0,
              title: const Text(
                'THEME',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ),
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: AppColors.whiteColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Select Your Preferred Theme',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 20,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await TokensManagement.setTheme(
                            selectedTheme: 'Theme1',
                          );
                          log('Theme 02 : ${TokensManagement.storedselectedTheme}');
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const Theme02MainScreenPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/theme02.png',
                          width: 150,
                          height: 250,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await TokensManagement.setTheme(
                            selectedTheme: 'Theme2',
                          );
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const Theme01MainScreenPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/unselectedtheme01.png',
                          width: 150,
                          height: 250,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await TokensManagement.setTheme(
                            selectedTheme: 'Theme3',
                          );

                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const MainScreenPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/unselectedtheme03.png',
                          width: 150,
                          height: 250,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await TokensManagement.setTheme(
                            selectedTheme: 'Theme4',
                          );
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const MainScreenPage4(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/unselectedtheme04.png',
                          width: 150,
                          height: 250,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
