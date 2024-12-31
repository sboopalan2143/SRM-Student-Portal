import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme-01/Theme_01_bottom_navigation_page.dart';
import 'package:sample/theme-01/drawer_page/change_password_theme01.dart';
import 'package:sample/theme-02/login/theme02_login_screen.dart';
import 'package:sample/theme_3/change_password_page_theme3.dart';
import 'package:sample/theme_4/change_password_page_theme4.dart';

class Theme04settingPage extends ConsumerStatefulWidget {
  const Theme04settingPage({super.key});

  @override
  ConsumerState createState() => _Theme04settingPageState();
}

class _Theme04settingPageState extends ConsumerState<Theme04settingPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initialProcess();
    Alerts.checkForAppUpdate(context: context, forcefully: false);
  }

  Future<void> _initialProcess() async {
    await TokensManagement.getStudentId();
    await ref.read(loginProvider.notifier).getAppVersion();

    /// Remove the command line after firebase setup
    await TokensManagement.getPhoneToken();
    await TokensManagement.getAppDeviceInfo();
    await TokensManagement.getTheme();
  }

  Future<void> showNotification(RemoteMessage message) async {
    await AppNotification.createNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      networkImagePath: message.data['image'] as String?,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen(networkProvider, (previous, next) {
        if (previous!.connectivityResult == ConnectivityResult.none &&
            next.connectivityResult != ConnectivityResult.none) {}
      })
      ..listen(changePasswordProvider, (previous, next) {
        if (next is ChangePasswordStateSuccessful) {
          if (next.message == 'Password Changed Successfuly') {
            _showToast(context, next.message, AppColors.greenColor);
          } else {
            _showToast(context, next.message, AppColors.redColor);
          }
        } else if (next is ChangePasswordStateError) {
          _showToast(context, next.message, AppColors.redColor);
        }
      });
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
                'Setting',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondaryColorTheme4,
              AppColors.secondaryColorTheme4,
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Stack(
          children: [
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 110),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryColorTheme4,
                            // borderRadius: const BorderRadius.only(
                            //   topRight: Radius.circular(30),
                            //   topLeft: Radius.circular(30),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              // vertical:
                              //     MediaQuery.of(context).size.height * 0.2,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      RouteDesign(
                                        route: const ChangePasswordTheme4(),
                                      ),
                                    );
                                  },
                                  child: _buildMenuItem(
                                    icon: Icons.settings,
                                    label: 'Change Password',
                                  ),
                                ),
                                const Divider(color: Colors.white54, height: 1),
                                const SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(mainProvider.notifier)
                                        .setNavString('Logout');
                                    TokensManagement.clearSharedPreference();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      RouteDesign(
                                        route: const Theme02LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: _buildMenuItem(
                                    icon: Icons.logout,
                                    label: 'Log out',
                                  ),
                                ),
                                const Divider(color: Colors.white54, height: 1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: AppColors.theme4color2,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.theme4color2,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
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
