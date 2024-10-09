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

class DrawerDesign extends ConsumerStatefulWidget {
  const DrawerDesign({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerDesignState();
}

class _DrawerDesignState extends ConsumerState<DrawerDesign> {
  @override
  Widget build(BuildContext context) {
    final providerProfile = ref.watch(profileProvider);

    final base64Image = '${providerProfile.profileData.studentphoto}';
    final imageBytes = base64Decode(base64Image);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.64,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 220,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
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
                        style: TextStyles.fontStyle3,
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
                    style: TextStyles.fontStyle2,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const HomePage2(),
                  ),
                );
              },
            ), //
            ListTile(
              title: const Row(
                children: [
                  Text(
                    'Profile',
                    style: TextStyles.fontStyle2,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Text(
                    'Theme',
                    style: TextStyles.fontStyle2,
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
                    style: TextStyles.fontStyle2,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const ChangePassword(),
                  ),
                );
              },
            ),

            // ListTile(
            //   title: const Row(
            //     children: [
            //       Text(
            //         'Terms & Conditions',
            //         style: TextStyles.fontStyle2,
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
                    style: TextStyles.fontStyle2,
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
