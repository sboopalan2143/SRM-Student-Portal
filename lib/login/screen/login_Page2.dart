import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';

class LoginPage2 extends ConsumerStatefulWidget {
  const LoginPage2({
    super.key,
  });

  @override
  ConsumerState createState() => _LoginPage2State();
}

class _LoginPage2State extends ConsumerState<LoginPage2>
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
          /// Handle route to next page.

          Navigator.push(context, RouteDesign(route: const MainScreenPage()));
          _showToast(context, next.successMessage, AppColors.greenColor);
        }
      });

    // return Scaffold(
    //   backgroundColor: AppColors.primaryColor,
    //   body: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         // Top section with logo and image
    //         Column(
    //           children: [
    //             const SizedBox(height: 30),
    //             Center(
    //               child: Image.asset(
    //                 'assets/images/srmlogodesign.png',
    //                 width: MediaQuery.of(context).size.width - 180,
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Center(
    //               child: Image.asset(
    //                 'assets/images/Studentsimage.png',
    //                 // width: MediaQuery.of(context).size.width - 100,
    //                 height: MediaQuery.of(context).size.height - 410,
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //             Container(
    //               decoration: const BoxDecoration(
    //                 color: AppColors.whiteColor,
    //                 borderRadius: BorderRadius.only(
    //                   topRight: Radius.circular(40),
    //                   topLeft: Radius.circular(40),
    //                 ),
    //               ),
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(
    //                   horizontal: 60,
    //                   vertical: 20,
    //                 ),
    //                 child: Column(
    //                   // mainAxisAlignment: MainAxisAlignment.end,
    //                   // crossAxisAlignment: CrossAxisAlignment.end,
    //                   children: [
    //                     // SizedBox(height: 10),
    //                     Center(
    //                       child: Text(
    //                         'Log in',
    //                         style: TextStyles.smallerPrimaryColorFontStyle,
    //                       ),
    //                     ),
    //                     const SizedBox(height: 20),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         const Text(
    //                           'Username',
    //                           style: TextStyles.fontStyle2,
    //                         ),
    //                         const SizedBox(
    //                           height: 5,
    //                         ),
    //                         SizedBox(
    //                           height: 40,
    //                           child: TextField(
    //                             controller: provider.userName,
    //                             style: TextStyles.fontStyle2,
    //                             decoration: InputDecoration(
    //                               prefixIcon: const Icon(
    //                                 Icons.account_circle,
    //                                 color: AppColors.grey2,
    //                               ),
    //                               hintText: 'Enter UserName',
    //                               hintStyle:
    //                                   TextStyles.smallLightAshColorFontStyle,
    //                               filled: true,
    //                               fillColor: AppColors.secondaryColor,
    //                               contentPadding: const EdgeInsets.all(10),
    //                               enabledBorder: BorderBoxButtonDecorations
    //                                   .loginTextFieldStyle,
    //                               focusedBorder: BorderBoxButtonDecorations
    //                                   .loginTextFieldStyle,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 20),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         const Text(
    //                           'Password',
    //                           style: TextStyles.fontStyle2,
    //                         ),
    //                         const SizedBox(
    //                           height: 5,
    //                         ),
    //                         SizedBox(
    //                           height: 40,
    //                           child: TextField(
    //                             controller: provider.password,
    //                             style: TextStyles.fontStyle2,
    //                             decoration: InputDecoration(
    //                               prefixIcon: const Icon(
    //                                 Icons.lock,
    //                                 color: AppColors.grey2,
    //                               ),
    //                               hintText: 'Enter Password',
    //                               hintStyle:
    //                                   TextStyles.smallLightAshColorFontStyle,
    //                               filled: true,
    //                               fillColor: AppColors.secondaryColor,
    //                               contentPadding: const EdgeInsets.all(10),
    //                               enabledBorder: BorderBoxButtonDecorations
    //                                   .loginTextFieldStyle,
    //                               focusedBorder: BorderBoxButtonDecorations
    //                                   .loginTextFieldStyle,
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 30),
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                           child: ButtonDesign.buttonDesign(
    //                             'Log In',
    //                             AppColors.primaryColor,
    //                             context,
    //                             ref.read(mainProvider.notifier),
    //                             ref,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/Loginbackground.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content over the background
          SingleChildScrollView(
            child: Column(
              children: [
                // Top section with logo and image
                Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: Image.asset(
                        'assets/images/srmlogodesign.png',
                        width: MediaQuery.of(context).size.width - 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/images/Studentsimage.png',
                        height: MediaQuery.of(context).size.height - 410,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Center(
                    //   child: Image.asset(
                    //     'assets/images/student001.png',
                    //     height: MediaQuery.of(context).size.height - 410,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // Center(
                    //   child: Image.asset(
                    //     'assets/images/student4.png',
                    //     height: MediaQuery.of(context).size.height - 410,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // Center(
                    //   child: Image.asset(
                    //     'assets/images/student2.png',
                    //     height: MediaQuery.of(context).size.height - 410,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    // Center(
                    //   child: Image.asset(
                    //     'assets/images/student3.png',
                    //     height: MediaQuery.of(context).size.height - 450,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Log in',
                                style: TextStyles.smallerPrimaryColorFontStyle,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Username',
                                      style: TextStyles.fontStyle2,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '*',
                                      style: TextStyles.redColorFontStyleastric,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                SizedBox(
                                  height: 40,
                                  child: TextField(
                                    controller: provider.userName,
                                    style: TextStyles.fontStyle2,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.account_circle,
                                        color: AppColors.grey2,
                                      ),
                                      hintText: 'Enter UserName',
                                      hintStyle: TextStyles
                                          .smallLightAshColorFontStyle,
                                      filled: true,
                                      fillColor: AppColors.secondaryColor,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: BorderBoxButtonDecorations
                                          .loginTextFieldStyle,
                                      focusedBorder: BorderBoxButtonDecorations
                                          .loginTextFieldStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Text(
                                      'Password',
                                      style: TextStyles.fontStyle2,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '*',
                                      style: TextStyles.redColorFontStyleastric,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                // SizedBox(
                                //   height: 40,
                                //   child: TextField(
                                //     controller: provider.password,
                                //     style: TextStyles.fontStyle2,
                                //     decoration: InputDecoration(
                                //       prefixIcon: const Icon(
                                //         Icons.lock,
                                //         color: AppColors.grey2,
                                //       ),
                                //       hintText: 'Enter Password',
                                //       hintStyle: TextStyles
                                //           .smallLightAshColorFontStyle,
                                //       filled: true,
                                //       fillColor: AppColors.secondaryColor,
                                //       contentPadding: const EdgeInsets.all(10),
                                //       enabledBorder: BorderBoxButtonDecorations
                                //           .loginTextFieldStyle,
                                //       focusedBorder: BorderBoxButtonDecorations
                                //           .loginTextFieldStyle,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 40,
                                  child: TextField(
                                    controller: provider.password,
                                    obscureText: !_isPasswordVisible,
                                    style: TextStyles.fontStyle2,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: AppColors.grey2,
                                      ),
                                      hintText: 'Enter Password',
                                      hintStyle: TextStyles
                                          .smallLightAshColorFontStyle,
                                      filled: true,
                                      fillColor: AppColors.secondaryColor,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: BorderBoxButtonDecorations
                                          .loginTextFieldStyle,
                                      focusedBorder: BorderBoxButtonDecorations
                                          .loginTextFieldStyle,
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.grey2,
                                        ),
                                        onPressed: _togglePasswordVisibility,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      elevation: 0,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: AppColors.primaryColor,
                                      shadowColor: Colors.transparent,
                                    ),
                                    onPressed: () async {
                                      // provider.setNavString('Home');

                                      await ref
                                          .read(loginProvider.notifier)
                                          .login(
                                            ref.read(
                                                encryptionProvider.notifier),
                                          );
                                    },
                                    child: provider is LoginStateLoading
                                        ? CircularProgressIndicator(
                                            color: AppColors.secondaryColor,
                                          )
                                        : const Text(
                                            'Login',
                                            style: TextStyles.fontStyle1,
                                          ),
                                  )

                                  //  ButtonDesign.buttonDesign(
                                  //   'Log In',
                                  //   AppColors.primaryColor,
                                  //   context,
                                  //   ref.read(mainProvider.notifier),
                                  //   ref,
                                  // ),
                                  ,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
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
