import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/drawer_pages/theme/screens/riverpod/theme_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/screen/theme05_bottom_navigation_page.dart.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-01/Theme_01_bottom_navigation_page.dart';
import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';
import 'package:sample/theme-06/theme_06_bottom_navigation_page.dart';
import 'package:sample/theme-07/theme07_homepage.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Theme03Page extends ConsumerStatefulWidget {
  const Theme03Page({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme03PageState();
}

class _Theme03PageState extends ConsumerState<Theme03Page> {
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
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
               leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primaryColorTheme3,
              elevation: 0,
              title: const Text(
                'THEME',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ),
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: AppColors.secondaryColorTheme3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Select Your Preferred Theme',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColorTheme3,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const Theme02MainScreenPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/unselectedtheme02.png',
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
                          'assets/images/unselectedthemeback01.png',
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
                          'assets/images/theme03.png',
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
                      GestureDetector(
                        onTap: () async {
                          await TokensManagement.setTheme(
                            selectedTheme: 'Theme5',
                          );
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const Theme05MainScreenPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/unselectedtheme05.png',
                          width: 150,
                          height: 250,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await TokensManagement.setTheme(
                            selectedTheme: 'Theme6',
                          );
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const Theme06MainScreenPage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/unselectedtheme06.png',
                          width: 150,
                          height: 250,
                        ),
                      ),
                       GestureDetector(
                        onTap: () async {
                          await TokensManagement.setTheme(
                            selectedTheme: 'Theme7',
                          );
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const Theme07HomePage(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/theme07_unselect.png',
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
