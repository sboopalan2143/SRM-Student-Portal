// ignore_for_file: inference_failure_on_instance_creation

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/riverpod/main_state.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Select your prefered theme',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.theme4color2,
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
              if (text == 'Theme 1') {
                log('Color $color');
                await AppColors.setPrimaryColor(color);
                await AppColors.setSecondaryColor('#fef2f2');
                await Navigator.push(
                  context,
                  RouteDesign(
                    route: const ThemePageTheme4(),
                  ),
                );
              }

              if (text == 'Theme 2') {
                await AppColors.setPrimaryColor(color);
                await AppColors.setSecondaryColor('#f0fdf4');
                ref.read(mainProvider.notifier).setNavString('Theme');
                await Navigator.push(
                  context,
                  RouteDesign(
                    route: const ThemePageTheme4(),
                  ),
                );
              }

              if (text == 'Theme 3') {
                await AppColors.setPrimaryColor(color);
                await AppColors.setSecondaryColor('#e0f2fe');
                ref.read(mainProvider.notifier).setNavString('Theme');
                await Navigator.push(
                  context,
                  RouteDesign(
                    route: const ThemePageTheme4(),
                  ),
                );
              }

              if (text == 'Theme 4') {
                await AppColors.setPrimaryColor(color);
                await AppColors.setSecondaryColor('#fff7ed');
                ref.read(mainProvider.notifier).setNavString('Theme');
                await Navigator.push(
                  context,
                  RouteDesign(
                    route: const ThemePageTheme4(),
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
