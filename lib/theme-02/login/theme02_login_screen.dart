// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:sample/designs/border_box_button_decorations.dart';
// import 'package:sample/designs/colors.dart';
// import 'package:sample/designs/font_styles.dart';
// import 'package:sample/designs/navigation_style.dart';
// import 'package:sample/designs/status_bar_navigation_bar_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/login/riverpod/login_state.dart';
// import 'package:sample/network/riverpod/network_state.dart';
// import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';
//
// class Theme02LoginScreen extends ConsumerStatefulWidget {
//   const Theme02LoginScreen({
//     super.key,
//   });
//
//   @override
//   ConsumerState createState() => _Theme02LoginScreenState();
// }
//
// class _Theme02LoginScreenState extends ConsumerState<Theme02LoginScreen>
//     with WidgetsBindingObserver {
//   bool _isPasswordVisible = false;
//
//   void _togglePasswordVisibility() {
//     setState(() {
//       _isPasswordVisible = !_isPasswordVisible;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _initialProcess();
//   }
//
//   Future<void> _initialProcess() async {
//     await Permission.notification.request();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       SystemChrome.setSystemUIOverlayStyle(
//         StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = ref.watch(loginProvider);
//     ref
//       ..listen(networkProvider, (previous, next) {
//         if (previous!.connectivityResult == ConnectivityResult.none &&
//             next.connectivityResult != ConnectivityResult.none) {
//           /// Handle api calls after the network is available
//         }
//       })
//       ..listen(loginProvider, (previous, next) {
//         if (next is LoginStateError) {
//           _showToast(context, next.errorMessage, AppColors.redColor);
//         } else if (next is LoginStateSuccessful) {
//           Navigator.push(
//               context, RouteDesign(route: const Theme02MainScreenPage()));
//           _showToast(context, next.successMessage, AppColors.greenColor);
//         }
//       });
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.whiteColor,
//               AppColors.whiteColor,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Center(
//                     child: Image.asset(
//                       'assets/images/srmgrouplogo.png',
//                       width: MediaQuery.of(context).size.width - 240,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'SRM Group of',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue.shade800,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     'Educations Institution',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue.shade800,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Text(
//                     'Student portal LogIn',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue.shade800,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'User Name',
//                             style: TextStyles.logintheme02fontStyle2,
//                           ),
//                           const SizedBox(height: 5),
//                           const Text(
//                             '*',
//                             style: TextStyles.redColorFontStyleastric,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       TextField(
//                         controller: provider.userName,
//                         style: TextStyles.fontStyle2,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(
//                             Icons.account_circle,
//                             color: Colors.blue.shade800,
//                           ),
//                           hintText: 'User Name',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade500,
//                             fontSize: 12,
//                           ),
//                           border: const OutlineInputBorder(),
//                         ),
//                         // decoration: InputDecoration(
//                         //   prefixIcon: const Icon(
//                         //     Icons.account_circle,
//                         //     color: AppColors.grey2,
//                         //   ),
//                         //   hintText: 'Enter UserName',
//                         //   hintStyle: TextStyles.smallLightAshColorFontStyle,
//                         //   filled: true,
//                         //   fillColor: AppColors.secondaryColor,
//                         //   contentPadding: const EdgeInsets.all(10),
//                         //   enabledBorder:
//                         //       BorderBoxButtonDecorations.loginTextFieldStyle,
//                         //   focusedBorder:
//                         //       BorderBoxButtonDecorations.loginTextFieldStyle,
//                         // ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Password',
//                             style: TextStyles.logintheme02fontStyle2,
//                           ),
//                           const SizedBox(height: 5),
//                           const Text(
//                             '*',
//                             style: TextStyles.redColorFontStyleastric,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 5),
//                       TextField(
//                         controller: provider.password,
//                         obscureText: !_isPasswordVisible,
//                         style: TextStyles.fontStyle2,
//                         // decoration: InputDecoration(
//                         //   prefixIcon: const Icon(
//                         //     Icons.lock,
//                         //     color: AppColors.grey2,
//                         //   ),
//                         //   hintText: 'Enter Password',
//                         //   hintStyle: TextStyles.smallLightAshColorFontStyle,
//                         //   filled: true,
//                         //   fillColor: AppColors.secondaryColor,
//                         //   contentPadding: const EdgeInsets.all(10),
//                         //   enabledBorder:
//                         //       BorderBoxButtonDecorations.loginTextFieldStyle,
//                         //   focusedBorder:
//                         //       BorderBoxButtonDecorations.loginTextFieldStyle,
//                         //   suffixIcon: IconButton(
//                         //     icon: Icon(
//                         //       _isPasswordVisible
//                         //           ? Icons.visibility
//                         //           : Icons.visibility_off,
//                         //       color: AppColors.grey2,
//                         //     ),
//                         //     onPressed: _togglePasswordVisibility,
//                         //   ),
//                         // ),
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(
//                             Icons.key_sharp,
//                             color: Colors.blue.shade800,
//                           ),
//                           hintText: 'Password',
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade500,
//                             fontSize: 12,
//                           ),
//                           border: const OutlineInputBorder(),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               _isPasswordVisible
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                               color: AppColors.grey2,
//                             ),
//                             onPressed: _togglePasswordVisibility,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 30),
//                   Container(
//                     width: MediaQuery.of(context).size.width / 2,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02secondaryColor1,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: BorderRadius.circular(
//                         10,
//                       ),
//                     ),
//                     child:
//                         //  ElevatedButton(
//                         //   onPressed: () async {
//                         //     await ref.read(loginProvider.notifier).login(
//                         //           ref.read(encryptionProvider.notifier),
//                         //         );
//                         //   },
//                         //   style: ElevatedButton.styleFrom(
//                         //     backgroundColor: Colors.transparent,
//                         //     shadowColor: Colors.transparent,
//                         //     shape: RoundedRectangleBorder(
//                         //       borderRadius: BorderRadius.circular(30),
//                         //     ),
//                         //     padding: const EdgeInsets.symmetric(vertical: 14),
//                         //   ),
//                         //   child: provider is LoginStateLoading
//                         //       ? SizedBox(
//                         //           height: 24,
//                         //           width: 24,
//                         //           child: CircularProgressIndicator(
//                         //             color: AppColors.secondaryColor,
//                         //           ),
//                         //         )
//                         //       : const Text(
//                         //           'Log in',
//                         //           style: TextStyle(
//                         //             color: AppColors.whiteColor,
//                         //             fontWeight: FontWeight.bold,
//                         //             fontSize: 16,
//                         //           ),
//                         //         ),
//                         // ),
//
//                         ElevatedButton(
//                       iconAlignment: IconAlignment.start,
//                       onPressed: () async {
//                         await ref.read(loginProvider.notifier).login(
//                               ref.read(encryptionProvider.notifier),
//                             );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         elevation: 10,
//                         fixedSize: const Size(175, 50),
//                         backgroundColor: Colors.blue.shade800,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: Center(
//                         child: provider is LoginStateLoading
//                             ? CircularProgressIndicator(
//                                 color: AppColors.secondaryColor,
//                               )
//                             : const Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 16,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showToast(BuildContext context, String message, Color color) {
//     showToast(
//       message,
//       context: context,
//       backgroundColor: color,
//       axis: Axis.horizontal,
//       alignment: Alignment.centerLeft,
//       position: StyledToastPosition.center,
//       borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(15),
//         bottomLeft: Radius.circular(15),
//       ),
//       toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
//     );
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/designs/border_box_button_decorations.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/designs/status_bar_navigation_bar_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';

class Theme02LoginScreen extends ConsumerStatefulWidget {
  const Theme02LoginScreen({
    super.key,
  });

  @override
  ConsumerState createState() => _Theme02LoginScreenState();
}

class _Theme02LoginScreenState extends ConsumerState<Theme02LoginScreen>
    with WidgetsBindingObserver {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialProcess();
  }

  Future<void> _initialProcess() async {
    await Permission.notification.request();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(loginProvider);
    ref
      ..listen(networkProvider, (previous, next) {
        if (previous!.connectivityResult == ConnectivityResult.none &&
            next.connectivityResult != ConnectivityResult.none) {
          /// Handle api calls after the network is available
        }
      })
      ..listen(loginProvider, (previous, next) {
        if (next is LoginStateError) {
          _showToast(context, next.errorMessage, AppColors.redColor);
        } else if (next is LoginStateSuccessful) {
          Navigator.push(
              context, RouteDesign(route: const Theme02MainScreenPage()));
          _showToast(context, next.successMessage, AppColors.greenColor);
        }
      });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.whiteColor,
              AppColors.whiteColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/srmgrouplogo.png',
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    'SRM Group of ',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.theme06primaryColor,
                    ),
                  ),
                  Text(
                    'Education Institutions',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: AppColors.theme06primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Student Portal',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'popins',
                        // fontFamily: 'Roboto',
                        // fontFamily: 'OpenSans',
                        // fontFamily: 'Montserrat',
                        fontFamily: 'Raleway',
                        // fontFamily: 'Merriweather',
                        // fontFamily: 'Ubuntu',
                        // fontFamily: 'Nunito',

                        color: AppColors.lightAshColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Login Card
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   'Welcome Back!',
                          //   style: TextStyle(
                          //     fontSize: 24,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.black87,
                          //   ),
                          // ),

                          // Username Input
                          TextField(
                            controller: provider.userName,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              labelText: 'User Name',
                              prefixIcon: Icon(
                                Icons.person,
                                color: AppColors.theme06primaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Password Input
                          TextField(
                            controller: provider.password,
                            // obscureText: true,
                            obscureText: !_isPasswordVisible,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(
                                Icons.key,
                                color: AppColors.theme06primaryColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColors.theme06primaryColor,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await ref.read(loginProvider.notifier).login(
                                      ref.read(encryptionProvider.notifier),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppColors.theme06primaryColor,
                              ),
                              child: provider is LoginStateLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: AppColors.secondaryColor,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'Version : 0.01',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Footer Text
                ],
              ),
            ),
          ),
        ),
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
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:sample/designs/colors.dart';
// import 'package:sample/designs/navigation_style.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/login/riverpod/login_state.dart';
// import 'package:sample/network/riverpod/network_state.dart';
// import 'package:sample/theme-02/theme_02_bottom_navigation_page.dart';
//
// class Theme02LoginScreen extends ConsumerWidget {
//   const Theme02LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final provider = ref.watch(loginProvider);
//
//     ref..listen(networkProvider, (previous, next) {
//       if (previous!.connectivityResult == ConnectivityResult.none &&
//           next.connectivityResult != ConnectivityResult.none) {
//         /// Handle api calls after the network is available
//       }
//     })..listen(loginProvider, (previous, next) {
//       if (next is LoginStateError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is LoginStateSuccessful) {
//         Navigator.push(
//             context, RouteDesign(route: const Theme02MainScreenPage()));
//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.whiteColor,
//               AppColors.whiteColor,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo
//                   Image.asset(
//                     'assets/images/srmgrouplogo.png',
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width / 3,
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Title
//                   Text(
//                     'SRM Group of ',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.theme02primaryColor,
//                     ),
//                   ),
//                   Text(
//                     'Education Institutions',
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.theme02primaryColor,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Center(
//                     child: Text(
//                       'Student Portal',
//                       style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         // fontFamily: 'popins',
//                         // fontFamily: 'Roboto',
//                         // fontFamily: 'OpenSans',
//                         // fontFamily: 'Montserrat',
//                         fontFamily: 'Raleway',
//                         // fontFamily: 'Merriweather',
//                         // fontFamily: 'Ubuntu',
//                         // fontFamily: 'Nunito',
//
//                         color: AppColors.lightAshColor,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Login Card
//                   Card(
//                     elevation: 10,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 30),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // const Text(
//                           //   'Welcome Back!',
//                           //   style: TextStyle(
//                           //     fontSize: 24,
//                           //     fontWeight: FontWeight.bold,
//                           //     color: Colors.black87,
//                           //   ),
//                           // ),
//
//                           // Username Input
//                           TextField(
//                             controller: provider.userName,
//                             style: const TextStyle(fontSize: 14),
//                             decoration: InputDecoration(
//                               labelText: 'User Name',
//                               prefixIcon: Icon(
//                                 Icons.person,
//                                 color: AppColors.theme06primaryColor,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//
//                           // Password Input
//                           TextField(
//                             controller: provider.password,
//                             obscureText: true,
//                             style: const TextStyle(fontSize: 14),
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               prefixIcon: Icon(
//                                 Icons.key,
//                                 color: AppColors.theme06primaryColor,
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: const Icon(Icons.visibility_off),
//                                 color: AppColors.theme06primaryColor,
//                                 onPressed: () {
//                                   // Toggle password visibility
//                                 },
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//
//                           // Login Button
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 await ref.read(loginProvider.notifier).login(
//                                   ref.read(encryptionProvider.notifier),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 backgroundColor: AppColors.theme06primaryColor,
//                               ),
//                               child: provider is LoginStateLoading
//                                   ? SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   color: AppColors.secondaryColor,
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                                   : const Text(
//                                 'Login',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//                   const Center(
//                     child: const Text(
//                       'Version : 0.01',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.black54,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Footer Text
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showToast(BuildContext context, String message, Color color) {
//     showToast(
//       message,
//       context: context,
//       backgroundColor: color,
//       axis: Axis.horizontal,
//       alignment: Alignment.centerLeft,
//       position: StyledToastPosition.center,
//       borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(15),
//         bottomLeft: Radius.circular(15),
//       ),
//       toastHorizontalMargin: MediaQuery
//           .of(context)
//           .size
//           .width / 3,
//     );
//   }
// }
