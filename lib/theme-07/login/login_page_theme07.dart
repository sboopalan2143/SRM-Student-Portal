import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/login/widget/button_design.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/theme-07/bottom_navbar.dart';
import 'package:sample/theme-07/theme07_homepage.dart';

class Theme07LoginPage extends ConsumerStatefulWidget {
  const Theme07LoginPage({super.key});

  @override
  ConsumerState createState() => _Theme07LoginPageState();
}

class _Theme07LoginPageState extends ConsumerState<Theme07LoginPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;

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
          Navigator.push(context, RouteDesign(route: const BottomBar()));

          _showToast(context, next.successMessage, AppColors.greenColor);
        }
      });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Image.asset(
                      //   'assets/images/logo.png',
                      //   width: MediaQuery.of(context).size.width * 1,
                      //   height: 200,
                      // ),
                      // const SizedBox(height: 50),
                      const Text(
                        'SRM STUDENT LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                          color: Color.fromARGB(255, 10, 35, 81),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 50),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: provider.userName,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            FontAwesomeIcons.userGraduate,
                            color: Color.fromARGB(255, 10, 35, 81),
                          ),
                          hintText: 'User ID',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded border
                            borderSide: BorderSide(
                              color: Colors.grey.shade800, // Default border color
                              width: 2, // Border width
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500, // Border color when not focused
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 10, 35, 81), // Border color when focused
                              width: 2,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.redAccent.shade700,
                              width: 2,
                            ),
                          ),
                          // border: OutlineInputBorder(
                          //   borderRadius:
                          //       BorderRadius.circular(8.0), // Rounded border
                          //   borderSide: BorderSide(
                          //     color:
                          //         Colors.grey.shade800, // Default border color
                          //     width: 2.0, // Border width
                          //   ),
                          // ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.grey
                          //         .shade400, // Border color when not focused
                          //     width: 2.0,
                          //   ),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: const BorderSide(
                          //     color: Color.fromARGB(
                          //         255, 10, 35, 81), // Border color when focused
                          //     width: 2.0,
                          //   ),
                          // ),
                          // errorBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.red.shade300,
                          //     width: 2.0,
                          //   ),
                          // ),
                          // focusedErrorBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.redAccent.shade700,
                          //     width: 2.0,
                          //   ),
                          // ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: provider.password,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.key_sharp,
                            color: Color.fromARGB(255, 10, 35, 81),
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded border
                            borderSide: BorderSide(
                              color: Colors.grey.shade800, // Default border color
                              width: 2, // Border width
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade500, // Border color when not focused
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 10, 35, 81), // Border color when focused
                              width: 2,
                            ),
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.redAccent.shade700,
                              width: 2,
                            ),
                          ),
                          // border: OutlineInputBorder(
                          //   borderRadius:
                          //       BorderRadius.circular(8.0), // Rounded border
                          //   borderSide: BorderSide(
                          //     color:
                          //         Colors.grey.shade800, // Default border color
                          //     width: 2.0, // Border width
                          //   ),
                          // ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.grey
                          //         .shade400, // Border color when not focused
                          //     width: 2.0,
                          //   ),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: const BorderSide(
                          //     color: Color.fromARGB(
                          //         255, 10, 35, 81), // Border color when focused
                          //     width: 2.0,
                          //   ),
                          // ),
                          // errorBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.red.shade300,
                          //     width: 2.0,
                          //   ),
                          // ),
                          // focusedErrorBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(8.0),
                          //   borderSide: BorderSide(
                          //     color: Colors.redAccent.shade700,
                          //     width: 2.0,
                          //   ),
                          // ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: const Color.fromARGB(255, 10, 35, 81),
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText; // Toggle the obscure text
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _isLoading ? null : login,
                        style: ElevatedButton.styleFrom(
                          iconAlignment: IconAlignment.start,
                          elevation: 10,
                          fixedSize: const Size(175, 50),
                          backgroundColor: const Color.fromARGB(255, 10, 35, 81),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Color.fromARGB(255, 10, 35, 81),
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    await ref.read(loginProvider.notifier).login(ref.read(encryptionProvider.notifier));

    setState(() {
      _isLoading = false;
    });
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
