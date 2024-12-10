import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/theme_3/bottom_navigation_page_theme3.dart';

class LoginPageTheme3 extends ConsumerStatefulWidget {
  const LoginPageTheme3({
    super.key,
  });

  @override
  ConsumerState createState() => _LoginPageTheme3State();
}

class _LoginPageTheme3State extends ConsumerState<LoginPageTheme3>
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
    final height = MediaQuery.of(context).size.height;
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
          _showToast(context, next.successMessage, AppColors.greenColorTheme3);
        }
      });

    return Scaffold(
      backgroundColor: AppColors.primaryColorTheme3,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.15),
            const Text(
              'STUDENT PORTAL',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Icon(
                Icons.school_outlined,
                color: AppColors.whiteColor,
                size: 250,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: provider.userName,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.account_circle,
                          color: AppColors.whiteColor,
                        ),
                        hintText: 'Enter UserName',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.whiteColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                        // filled: true,
                        // fillColor: AppColors.secondaryColorTheme3,
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.whiteColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: provider.password,
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.whiteColor,
                        ),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: AppColors.whiteColor.withOpacity(0.5),
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.whiteColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.whiteColor),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.whiteColor,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
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
                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: AppColors.whiteColor,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {
                        // provider.setNavString('Home');

                        await ref.read(loginProvider.notifier).login(
                              ref.read(encryptionProvider.notifier),
                            );
                      },
                      child: provider is LoginStateLoading
                          ? CircularProgressIndicator(
                              color: AppColors.secondaryColorTheme3,
                            )
                          : Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryColorTheme3,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
