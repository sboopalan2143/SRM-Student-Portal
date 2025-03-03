import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/login/widget/button_design.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/theme-07/theme07_homepage.dart';

import '../../home/screen/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage>
    with WidgetsBindingObserver {
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

    /// Handle the network life cycle
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

          // Navigator.push(context, RouteDesign(route: const HomePage2()));
          Navigator.push(context, RouteDesign(route: const Theme07HomePage()));

          _showToast(context, next.successMessage, AppColors.greenColor);
        }
      });
    return LoadingWrapper(
      isLoading: provider is LoginStateLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.whiteColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/main.png',
              ),
              fit: BoxFit.none,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 4 - 25),
                  Center(
                    child: Image.asset(
                      'assets/images/mainpic1.png',
                      width: MediaQuery.of(context).size.width - 150,
                      // height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 40),
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
                      const Text(
                        'Username',
                        style: TextStyles.fontStyle2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
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
                            hintStyle: TextStyles.smallLightAshColorFontStyle,
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder:
                                BorderBoxButtonDecorations.loginTextFieldStyle,
                            focusedBorder:
                                BorderBoxButtonDecorations.loginTextFieldStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password',
                        style: TextStyles.fontStyle2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: provider.password,
                          style: TextStyles.fontStyle2,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: AppColors.grey2,
                            ),
                            hintText: 'Enter Password',
                            hintStyle: TextStyles.smallLightAshColorFontStyle,
                            filled: true,
                            fillColor: AppColors.secondaryColor,
                            contentPadding: const EdgeInsets.all(10),
                            enabledBorder:
                                BorderBoxButtonDecorations.loginTextFieldStyle,
                            focusedBorder:
                                BorderBoxButtonDecorations.loginTextFieldStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonDesign.buttonDesign(
                          'Log In',
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
