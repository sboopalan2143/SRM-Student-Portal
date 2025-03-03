import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
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
import 'package:sample/theme-01/theme01_homepage.dart';
import 'package:sample/theme-02/drawer_page/change_password_theme02.dart';
import 'package:sample/theme-02/login/theme02_login_screen.dart';
import 'package:sample/theme-07/login/login_page_theme07.dart';

class Theme02settingPage extends ConsumerStatefulWidget {
  const Theme02settingPage({super.key});

  @override
  ConsumerState createState() => _Theme02settingPageState();
}

class _Theme02settingPageState extends ConsumerState<Theme02settingPage>
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
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.theme02primaryColor,
              AppColors.theme02secondaryColor1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.center,
                  ),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const Theme01Homepage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Setting',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await ref.read(profileProvider.notifier).getProfileApi(
                              ref.read(
                                encryptionProvider.notifier,
                              ),
                            );
                        await ref
                            .read(profileProvider.notifier)
                            .getProfileHive('');
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
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
                            color: AppColors.whiteColor,
                            // borderRadius: const BorderRadius.only(
                            //   topRight: Radius.circular(30),
                            //   topLeft: Radius.circular(30),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
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
                                        // route: const ChangePassword(),
                                        route:
                                            const Theme02ChangePasswordPage(),
                                      ),
                                    );
                                  },
                                  child: _buildMenuItem(
                                    icon: Icons.settings,
                                    label: 'Change Password',
                                  ),
                                ),
                                Divider(
                                  color: AppColors.theme02primaryColor,
                                  height: 1,
                                ),
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
                                        route: const Theme07LoginPage(),
                                      ),
                                      (route) => false,
                                    );
                                  },
                                  child: _buildMenuItem(
                                    icon: Icons.logout,
                                    label: 'Log out',
                                  ),
                                ),
                                Divider(
                                  color: AppColors.theme02primaryColor,
                                  height: 1,
                                ),
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
      drawer: const DrawerDesign(),
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
            color: AppColors.theme02primaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyles.theme02fontStyle3,
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
