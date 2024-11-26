import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/drawer_pages/change_password/screen/change_password.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/drawer_pages/profile/screens/profile_page.dart';
import 'package:sample/home/drawer_pages/theme/screens/theme.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/login/screen/login_Page2.dart';
import 'package:sample/theme-01/drawer_page/change_password_theme01.dart';
import 'package:sample/theme-01/drawer_page/theme01_profile_screen.dart';
import 'package:sample/theme-01/theme01_homepage.dart';

class DrawerDesign extends ConsumerStatefulWidget {
  const DrawerDesign({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerDesignState();
}

class _DrawerDesignState extends ConsumerState<DrawerDesign> {
  @override
  Widget build(BuildContext context) {
    final providerProfile = ref.watch(profileProvider);

    final base64Image = '${providerProfile.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.64,
      child: Drawer(
        backgroundColor: AppColors.theme01primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 220,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme01secondaryColor3, // Start color
                      AppColors.theme01secondaryColor2, // End color
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (imageBytes == '' && imageBytes.isEmpty)
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.whiteColor,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                            radius: 48,
                          ),
                        ),
                      if (imageBytes != '' && imageBytes.isNotEmpty)
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.memory(
                              imageBytes,
                              fit: BoxFit.cover, // Adjust fit as needed
                            ),
                          ),
                        ),
                      Text(
                        TokensManagement.studentName == ''
                            ? '-'
                            : TokensManagement.studentName,
                        style: TextStyles.buttonStyle01theme,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Row(
                children: [
                  Text(
                    'Home',
                    style: TextStyles.fontStyle3,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    // route: const HomePage2(),
                    route: const Theme01Homepage(),
                  ),
                );
              },
            ), //
            ListTile(
              title: const Row(
                children: [
                  Text(
                    'Profile',
                    style: TextStyles.fontStyle3,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    // route: const ProfilePage(),
                    route: const Theme01ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Text(
                    'Theme',
                    style: TextStyles.fontStyle3,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const ThemePage(),
                  ),
                );
              },
            ),

            ListTile(
              title: const Row(
                children: [
                  Text(
                    'Change Password',
                    style: TextStyles.fontStyle3,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    // route: const ChangePassword(),
                    route: const Theme01ChangePasswordPage(),
                  ),
                );
              },
            ),

            // ListTile(
            //   title: const Row(
            //     children: [
            //       Text(
            //         'Terms & Conditions',
            //         style: TextStyles.fontStyle3,
            //       ),
            //     ],
            //   ),
            //   onTap: () {
            //     ref
            //         .read(mainProvider.notifier)
            //         .setNavString('Terms & Conditions');
            //     Navigator.pop(context);
            //   },
            // ),

            ListTile(
              title: const Row(
                children: [
                  Text(
                    'Logout',
                    style: TextStyles.fontStyle3,
                  ),
                ],
              ),
              onTap: () {
                ref.read(mainProvider.notifier).setNavString('Logout');
                TokensManagement.clearSharedPreference();
                Navigator.pushAndRemoveUntil(
                  context,
                  RouteDesign(route: const LoginPage2()),
                  (route) => false,
                );
                // log('${}}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
