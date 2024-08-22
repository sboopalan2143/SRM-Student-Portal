import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/firebase_options.dart';
// import 'package:sample/firebase_options.dart';
// import 'package:sample/home/screen/home_page.dart';
// import 'package:sample/login/screen/login_page.dart';
import 'package:sample/notification.dart';
import 'package:sample/route/route_builder.dart';
import 'package:sample/route/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  if (sharedPreferences.getString('primaryColor') != null) {
    await AppColors.setPrimaryColor(
      sharedPreferences.getString('primaryColor')!,
    );
    await AppColors.setSecondaryColor(
      sharedPreferences.getString('secondaryColor')!,
    );
  }

  // / Handel firebase based on current platform
  await Firebase.initializeApp(options: PlatformOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  await AppNotification.initializeNotification();
  SystemChrome.setSystemUIOverlayStyle(
    StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
  );
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

      /// Navigate base on stored auth token for mobile and web
      initialRoute:
          // TokensManagement.authToken == '' ?
          Routes.login,
      //  :
      // Routes.home,
      routes: RouteBuilder.routes,

      /// Navigate base on stored auth token only for mobile
      // home: TokensManagement.authToken == ''
      //     ? const LoginPage()
      //     : const HomePage(),
    );
  }
}
