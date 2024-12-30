// ignore_for_file: inference_failure_on_instance_creation

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/riverpod/main_state.dart';

class ThemePageTheme3 extends ConsumerStatefulWidget {
  const ThemePageTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThemePageTheme3State();
}

class _ThemePageTheme3State extends ConsumerState<ThemePageTheme3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryColorTheme3,
          elevation: 0,
          title: const Text(
            'THEME',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Select your prefered theme',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryColorTheme3,
                  fontWeight: FontWeight.bold,
                ),
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
    );
  }

  Widget button(String text, String color) {
    final width = MediaQuery.of(context).size.width;
    return Column(
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
                    route: const ThemePageTheme3(),
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
                    route: const ThemePageTheme3(),
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
                    route: const ThemePageTheme3(),
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
                    route: const ThemePageTheme3(),
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
                    route: const ThemePageTheme3(),
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
                    route: const ThemePageTheme3(),
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
    );
  }
}
