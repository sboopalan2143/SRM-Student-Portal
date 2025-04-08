import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/api_token_services/hive_repository.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/firebase_options.dart';
import 'package:sample/route/route_builder.dart';
import 'package:sample/route/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TokensManagement.getStudentId();
  await TokensManagement.getTheme();
  log('Theme: ${TokensManagement.storedselectedTheme}');
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(options: PlatformOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  SystemChrome.setSystemUIOverlayStyle(
    StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
  );
  await HiveRepository.initializeHive();
  runApp(const ProviderScope(child: Initial()));
}

class Initial extends ConsumerStatefulWidget {
  const Initial({super.key});

  @override
  ConsumerState createState() => _InitialState();
}

class _InitialState extends ConsumerState<Initial> {
  // @override
  // void initState() {
  //   super.initState();
  //   ref.read(networkProvider.notifier).subscribe();
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.whiteColor,
        colorScheme: AppColors.primaryColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),

      title: 'App Title',

      initialRoute:
          TokensManagement.studentId == '' ? Routes.login : Routes.home,
      //  :home
      // Routes.home,
      routes: RouteBuilder.routes,

      /// Navigate base on stored auth token only for mobile
      // home: TokensManagement.authToken == ''
      //     ? const LoginPage()
      //     : const HomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
