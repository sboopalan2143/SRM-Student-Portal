// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class Theme01ProfilePage extends ConsumerStatefulWidget {
//   const Theme01ProfilePage({super.key});

//   @override
//   ConsumerState createState() => _Theme01ProfilePageState();
// }

// class _Theme01ProfilePageState extends ConsumerState<Theme01ProfilePage>
//     with WidgetsBindingObserver {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         backgroundColor: const Color(0xFF4DB6AC),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Profile Header Section
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//               color: Color(0xFFFFC107),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(
//                   30,
//                 ),
//               ),
//             ),
//             child: Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.grey,
//                   child: Icon(Icons.person, color: Colors.white, size: 40),
//                 ),
//                 const SizedBox(width: 16),
//                 const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Lorem Name',
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Lorem ipsum dolor sit amet',
//                       style: TextStyle(
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text('Lorem ipsum dolor', style: TextStyle(fontSize: 14)),
//                   ],
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Edit'),
//                 ),
//               ],
//             ),
//           ),

//           // User Details Section
//           const Padding(
//             padding: EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Text(
//                   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed diam nonummy nibh.',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 Spacer(),
//                 Text(
//                   'Lorem ipsum dolor',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),

//           // Option List Section
//           Expanded(
//             child: ListView(
//               children: const [
//                 ProfileOption(
//                   icon: Icons.email,
//                   text: 'Lorem ipsum',
//                   notificationCount: 1,
//                 ),
//                 ProfileOption(
//                   icon: Icons.notifications,
//                   text: 'Dolor sit',
//                   notificationCount: 3,
//                 ),
//                 ProfileOption(
//                   icon: Icons.favorite,
//                   text: 'Amet lorem',
//                   notificationCount: 0,
//                 ),
//                 ProfileOption(
//                   icon: Icons.info,
//                   text: 'Ipsum dolor',
//                   notificationCount: 0,
//                 ),
//                 ProfileOption(
//                   icon: Icons.ac_unit,
//                   text: 'Sit amet',
//                   notificationCount: 0,
//                 ),
//                 ProfileOption(
//                   icon: Icons.logout,
//                   text: 'Log out',
//                   notificationCount: 0,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProfileOption extends StatelessWidget {
//   const ProfileOption({
//     required this.icon,
//     required this.text,
//     required this.notificationCount,
//     super.key,
//   });
//   final IconData icon;
//   final String text;
//   final int notificationCount;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon, color: const Color(0xFF4DB6AC)), // Blue-Green color
//       title: Text(text),
//       trailing: notificationCount > 0
//           ? CircleAvatar(
//               radius: 12,
//               backgroundColor: Colors.red,
//               child: Text(
//                 notificationCount.toString(),
//                 style: const TextStyle(fontSize: 12, color: Colors.white),
//               ),
//             )
//           : null,
//       onTap: () {
//         // Handle tap
//       },
//     );
//   }
// }

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
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme-01/theme01_homepage.dart';

class Theme01ProfilePage extends ConsumerStatefulWidget {
  const Theme01ProfilePage({super.key});

  @override
  ConsumerState createState() => _Theme01ProfilePageState();
}

class _Theme01ProfilePageState extends ConsumerState<Theme01ProfilePage>
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
    final providerProfile = ref.watch(profileProvider);
    final base64Image = '${providerProfile.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);
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
      backgroundColor: AppColors.theme01secondaryColor4,
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
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const Theme01Homepage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'PROFILE',
                style: TextStyles.fontStyle01theme,
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
                      child: Icon(
                        Icons.refresh,
                        color: AppColors.theme01primaryColor,
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                              const SizedBox(width: 40),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'kabir',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.theme01primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '10123210001',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.theme01primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme01primaryColor,
                            // borderRadius: const BorderRadius.only(
                            //   topRight: Radius.circular(30),
                            //   topLeft: Radius.circular(30),
                            // ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              // vertical: MediaQuery.of(context).size.height * 0.2,
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                // Menu Item 1
                                _buildMenuItem(
                                  icon: Icons.email,
                                  label: 'Lorem ipsum',
                                ),
                                const Divider(color: Colors.white54, height: 1),
                                const SizedBox(
                                  height: 10,
                                ),

                                // Menu Item 2
                                _buildMenuItem(
                                  icon: Icons.notifications,
                                  label: 'Dolor sit',
                                ),
                                const Divider(color: Colors.white54, height: 1),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Menu Item 3
                                _buildMenuItem(
                                  icon: Icons.group,
                                  label: 'Amet lorem',
                                ),
                                const Divider(color: Colors.white54, height: 1),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Menu Item 4
                                _buildMenuItem(
                                  icon: Icons.favorite,
                                  label: 'Ipsum dolor',
                                ),
                                const Divider(color: Colors.white54, height: 1),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Menu Item 5
                                _buildMenuItem(
                                  icon: Icons.settings,
                                  label: 'Sit amet',
                                ),
                                const Divider(color: Colors.white54, height: 1),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Menu Item 6
                                _buildMenuItem(
                                  icon: Icons.logout,
                                  label: 'Log out',
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
