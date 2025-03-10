
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/theme-07/dhasboard_07_page.dart';
import 'package:sample/theme-07/login/login_page_theme07.dart';
import 'package:sample/theme-07/theme07_homepage.dart';
import 'package:sample/theme-07/theme07_theme_page.dart';

class Theme07DrawerDesign extends ConsumerStatefulWidget {
  const Theme07DrawerDesign({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07DrawerDesignState();
}

class _Theme07DrawerDesignState extends ConsumerState<Theme07DrawerDesign> {
  @override
  Widget build(BuildContext context) {
    final providerProfile = ref.watch(profileProvider);
    final base64Image = '${providerProfile.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.64,
      child: Drawer(
        backgroundColor: AppColors.theme07secondaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 200,
              child:
                  DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme07primaryColor,
                      AppColors
                          .theme07primaryColor, // You could use a secondary color here for contrast
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // IconButton(
                        //   iconSize: 35,
                        //   color: AppColors.whiteColor,
                        //   icon: const Icon(Icons.menu),
                        //   onPressed: () {
                        //    .openDrawer();
                        //   },
                        // ),
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
                            height: 65,
                            width: 65,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.memory(
                                imageBytes,
                                fit: BoxFit.cover, 
                              ),
                            ),
                          ),
                         
                      ],
                    ),
                    const SizedBox(height: 10,),
                     Text(
                          TokensManagement.studentName == ''
                              ? '-'
                              : TokensManagement.studentName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                  ],
                ),
                
              ),
            ),
             ListTile(
              hoverColor: AppColors.whiteColor,
              leading:  Icon(Icons.home,
                  color: AppColors.theme07primaryColor,), 
              title: const Row(
                children: [
                  Text(
                    'Home',
                    style: TextStyles.smallerBlackColorFontStyle,
                  ),
                ],
              ),
              onTap: () async {
               
          await Navigator.push(context, RouteDesign(route: const Theme07HomePage()));
              },
            ),
            ListTile(
              hoverColor: AppColors.whiteColor,
              leading:  Icon(Icons.dashboard,
                  color: AppColors.theme07primaryColor,), 
              title: const Row(
                children: [
                  Text(
                    'Dashboard',
                    style: TextStyles.smallerBlackColorFontStyle,
                  ),
                ],
              ),
              onTap: () async {
             
          await Navigator.push(context, RouteDesign(route: const Theme07dhasboardPage()));
             
              },
            ),
           
           
            ListTile(
              hoverColor: AppColors.whiteColor,
              leading:  Icon(Icons.menu,
                  color: AppColors.theme07primaryColor,), 
              title: const Row(
                children: [
                  Text(
                    'Theme',
                    style: TextStyles.smallerBlackColorFontStyle,
                  ),
                ],
              ),
              onTap: ()  async {
               await Navigator.push(context, RouteDesign(route: const Theme07Page()));
              },
            ),
           
            ListTile(
              leading:  Icon(Icons.logout,
                  color: AppColors.theme07primaryColor,), 
              title: const Row(
                children: [
                  Text(
                    'Logout',
                    style: TextStyles.smallerBlackColorFontStyle,
                  ),
                ],
              ),

              onTap: () async {
                await Navigator.push(context, RouteDesign(route: const Theme07LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
