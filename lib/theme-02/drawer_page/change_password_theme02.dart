import 'dart:convert';
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
import 'package:sample/home/main_pages/grievances/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme-01/theme01_homepage.dart';

class Theme02ChangePasswordPage extends ConsumerStatefulWidget {
  const Theme02ChangePasswordPage({super.key});

  @override
  ConsumerState createState() => _Theme02ChangePasswordPageState();
}

class _Theme02ChangePasswordPageState
    extends ConsumerState<Theme02ChangePasswordPage>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    final provider = ref.watch(changePasswordProvider);
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
      key: _scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.theme01secondaryColor3,
              AppColors.theme01secondaryColor4,
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Stack(
          children: [
            // AppBar(
            //   flexibleSpace: Container(
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           AppColors.theme02primaryColor,
            //           AppColors.theme02secondaryColor1,
            //         ],
            //         begin: Alignment.topRight,
            //         end: Alignment.center,
            //       ),
            //     ),
            //   ),
            //   leading: IconButton(
            //     onPressed: () {
            //       Navigator.pop(
            //         context,
            //       );
            //     },
            //     icon: const Icon(
            //       Icons.arrow_back_ios_new,
            //       color: AppColors.whiteColor,
            //     ),
            //   ),
            //   backgroundColor: Colors.transparent,
            //   elevation: 0,
            //   title: const Text(
            //     'CHANGE PASSWORD',
            //     style: TextStyles.fontStyle4,
            //     overflow: TextOverflow.clip,
            //   ),
            //   centerTitle: true,
            //   actions: [
            //     Row(
            //       children: [
            //         GestureDetector(
            //           onTap: () async {
            //             await ref.read(profileProvider.notifier).getProfileApi(
            //                   ref.read(
            //                     encryptionProvider.notifier,
            //                   ),
            //                 );
            //             await ref
            //                 .read(profileProvider.notifier)
            //                 .getProfileHive('');
            //           },
            //           child: const Icon(
            //             Icons.refresh,
            //             color: AppColors.whiteColor,
            //           ),
            //         ),
            //         const SizedBox(
            //           width: 15,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            PreferredSize(
              preferredSize: const Size.fromHeight(60),
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
                        Navigator.pop(
                          context,
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
                      'Change password',
                      style: TextStyles.fontStyle4,
                      overflow: TextOverflow.clip,
                    ),
                    centerTitle: true,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 120),
                      SizedBox(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.whiteColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical:
                                  MediaQuery.of(context).size.height * 0.2,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 40),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Enter Current Password',
                                          style: TextStyles.fontStyle2,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextField(
                                            controller:
                                                provider.currentPassword,
                                            style: TextStyles.fontStyle2,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                Icons.account_circle,
                                                color: AppColors.grey2,
                                              ),
                                              hintText:
                                                  'Enter Current Password',
                                              hintStyle: TextStyles
                                                  .smallLightAshColorFontStyle,
                                              filled: true,
                                              fillColor:
                                                  AppColors.secondaryColor,
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              enabledBorder:
                                                  BorderBoxButtonDecorations
                                                      .loginTextFieldStyle,
                                              focusedBorder:
                                                  BorderBoxButtonDecorations
                                                      .loginTextFieldStyle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Enter New Password',
                                          style: TextStyles.fontStyle2,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextField(
                                            controller: provider.newPassword,
                                            style: TextStyles.fontStyle2,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                Icons.lock,
                                                color: AppColors.grey2,
                                              ),
                                              hintText: 'Enter New Password',
                                              hintStyle: TextStyles
                                                  .smallLightAshColorFontStyle,
                                              filled: true,
                                              fillColor:
                                                  AppColors.secondaryColor,
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              enabledBorder:
                                                  BorderBoxButtonDecorations
                                                      .loginTextFieldStyle,
                                              focusedBorder:
                                                  BorderBoxButtonDecorations
                                                      .loginTextFieldStyle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Enter Confirm Password',
                                          style: TextStyles.fontStyle2,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          height: 40,
                                          child: TextField(
                                            controller:
                                                provider.confirmPassword,
                                            style: TextStyles.fontStyle2,
                                            decoration: InputDecoration(
                                              prefixIcon: const Icon(
                                                Icons.lock,
                                                color: AppColors.grey2,
                                              ),
                                              hintText: 'Confirm Password',
                                              hintStyle: TextStyles
                                                  .smallLightAshColorFontStyle,
                                              filled: true,
                                              fillColor:
                                                  AppColors.secondaryColor,
                                              contentPadding:
                                                  const EdgeInsets.all(10),
                                              enabledBorder:
                                                  BorderBoxButtonDecorations
                                                      .loginTextFieldStyle,
                                              focusedBorder:
                                                  BorderBoxButtonDecorations
                                                      .loginTextFieldStyle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ButtonDesign.buttonDesign(
                                            'Save',
                                            AppColors.primaryColor,
                                            context,
                                            ref.read(mainProvider.notifier),
                                            ref,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
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
    int? badgeCount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyles.fontStyle3,
            ),
          ),
          if (badgeCount != null)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$badgeCount',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
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
