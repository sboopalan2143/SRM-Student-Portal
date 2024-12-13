// ignore_for_file: inference_failure_on_instance_creation

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class ThemePage extends ConsumerStatefulWidget {
  const ThemePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ThemePageState();
}

class _ThemePageState extends ConsumerState<ThemePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.theme01primaryColor,
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
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'THEME',
                style: TextStyles.fontStyle01theme,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // scaffoldKey.currentState?.openEndDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        size: 35,
                        color: AppColors.theme01primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              const Text(
                'Select your prefered theme color',
                style: TextStyles.smallBlackColorFontStyle,
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Wrap(
                  spacing: 30,
                  runSpacing: 20,
                  children: [
                    button('Blue', '0xff236EDE'),
                    button('Red', '0xffdc2626'),
                    button('Green', '0xff16a34a'),
                    button('Sky Blue', '0xff0ea5e9'),
                    button('Orange', '0xffea580c'),
                    button('Black', '0xff030712'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget button(String text, String color) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            width: width * 0.30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(14),
                  ),
                ),
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: Color(int.parse(color)),
                shadowColor: Colors.transparent,
              ),
              onPressed: () async {
                if (text == 'Red') {
                  log('Color $color');
                  await AppColors.setPrimaryColor(color);
                  await AppColors.setSecondaryColor('#fef2f2');
                  await Navigator.push(
                    context,
                    RouteDesign(
                      route: const ThemePage(),
                    ),
                  );
                }

                if (text == 'Green') {
                  await AppColors.setPrimaryColor(color);
                  await AppColors.setSecondaryColor('#f0fdf4');
                  ref.read(mainProvider.notifier).setNavString('Theme');
                  await Navigator.push(
                    context,
                    RouteDesign(
                      route: const ThemePage(),
                    ),
                  );
                }

                if (text == 'Sky Blue') {
                  await AppColors.setPrimaryColor(color);
                  await AppColors.setSecondaryColor('#e0f2fe');
                  ref.read(mainProvider.notifier).setNavString('Theme');
                  await Navigator.push(
                    context,
                    RouteDesign(
                      route: const ThemePage(),
                    ),
                  );
                }

                if (text == 'Orange') {
                  await AppColors.setPrimaryColor(color);
                  await AppColors.setSecondaryColor('#fff7ed');
                  ref.read(mainProvider.notifier).setNavString('Theme');
                  await Navigator.push(
                    context,
                    RouteDesign(
                      route: const ThemePage(),
                    ),
                  );
                }

                if (text == 'Black') {
                  await AppColors.setPrimaryColor(color);
                  await AppColors.setSecondaryColor('#f3f4f6');
                  ref.read(mainProvider.notifier).setNavString('Theme');
                  await Navigator.push(
                    context,
                    RouteDesign(
                      route: const ThemePage(),
                    ),
                  );
                }

                if (text == 'Blue') {
                  await AppColors.setPrimaryColor(color);
                  await AppColors.setSecondaryColor('#F3F9FD');
                  ref.read(mainProvider.notifier).setNavString('Theme');
                  await Navigator.push(
                    context,
                    RouteDesign(
                      route: const ThemePage(),
                    ),
                  );
                }
              },
              child: const Text(
                '',
              ),
            ),
          ),
          Text(
            text,
            style: TextStyles.fontStyle2,
          ),
        ],
      ),
    );
  }
}
