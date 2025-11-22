import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-07/mainscreens/hostel/theme07_hostel_screen.dart';
import 'package:sample/theme/theme_provider.dart';

import 'hostel_registration_page.dart';

class Theme07HostelHomePage extends ConsumerStatefulWidget {
  const Theme07HostelHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07HostelHomePageState();
}

class _Theme07HostelHomePageState extends ConsumerState<Theme07HostelHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      await ref.read(hostelProvider.notifier).getRoomTypeHiveData('');

      final profile = await Hive.openBox<ProfileHiveData>('profile');
      if (profile.isEmpty) {
        await ref.read(profileProvider.notifier).getProfileApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(profileProvider.notifier).getProfileHive('');
      }
      await profile.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(hostelProvider);
    log('Regconfig  : ${provider.hostelRegisterDetails.regconfig}');
    log('status  : ${provider.hostelRegisterDetails.status}');
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    final cardStyle = BorderBoxButtonDecorations.homePageButtonStyle.copyWith(
      backgroundColor: MaterialStateProperty.all<Color>(
        themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      ),
      shadowColor: MaterialStateProperty.all<Color>(
        Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
      ),
    );

    final textStyle = width > 400
        ? TextStyles.smallBlackColorFontStyle.copyWith(color: Theme.of(context).colorScheme.inverseSurface)
        : TextStyles.smallerBlackColorFontStyle.copyWith(color: Theme.of(context).colorScheme.inverseSurface);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
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
        title: Text(
          'HOSTEL',
          style: TextStyles.fontStyle4,
          overflow: TextOverflow.clip,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // D E T A I L S   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07HostelPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: SizedBox(
                              child: Image.asset(
                                'assets/images/hostel.png',
                                height: 40,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          Text(
                            'Hostel Details',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // R E G I S T R A T I O N  W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07RegistrationPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: Icon(
                              Icons.app_registration, // Grade icon
                              color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                              size: 40, // Icon size
                            ),
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          Text(
                            'Hostel Registration',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.025,
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message, Color color) {
    showToast(
      message,
      context: context,
      backgroundColor: color,
      axis: Axis.horizontal,
      alignment: Alignment.centerLeft,
      position: StyledToastPosition.center,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
    );
  }
}
