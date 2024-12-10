// ignore_for_file: inference_failure_on_instance_creation

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/theme-01/Theme_01_bottom_navigation_page.dart';
import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

class ThemePageTheme4 extends ConsumerStatefulWidget {
  const ThemePageTheme4({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThemePageTheme4State();
}

class _ThemePageTheme4State extends ConsumerState<ThemePageTheme4> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.primaryColorTheme4.createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: SvgPicture.asset(
                'assets/images/wave.svg',
                fit: BoxFit.fill,
                width: double.infinity,
                color: AppColors.whiteColor,
                colorBlendMode: BlendMode.srcOut,
              ),
            ),
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'THEME',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
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
                          'assets/images/theme04.png',
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
