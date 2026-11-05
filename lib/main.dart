import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart' as pro;
import 'package:srmuh_std/api_token_services/api_tokens_services.dart';
import 'package:srmuh_std/api_token_services/hive_repository.dart';
import 'package:srmuh_std/app_version_checker.dart'; // <-- import your checker file
import 'package:srmuh_std/designs/_designs.dart';
import 'package:srmuh_std/route/route_builder.dart';
import 'package:srmuh_std/route/route_names.dart';
import 'package:srmuh_std/theme-07/bottom_navbar.dart';
import 'package:srmuh_std/theme-07/login/login_page_theme07.dart';
import 'package:srmuh_std/theme/theme_provider.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  log("Firebase");

  HttpOverrides.global = MyHttpOverrides();
  log("Http");

  SystemChrome.setSystemUIOverlayStyle(
    StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
  );
  log("System");

  await HiveRepository.initializeHive();
  log("Hive");

  await TokensManagement.getStudentId();
  await TokensManagement.getTheme();
  await TokensManagement.getPhoneToken();
  log('Theme: ${TokensManagement.storedselectedTheme}');

  runApp(
    pro.MultiProvider(
      providers: [
        pro.ChangeNotifierProvider(create: (context) => ThemeProvider()),
        pro.ChangeNotifierProvider(create: (context) => NavigationProvider()),
      ],
      child: const ProviderScope(
        child: Initial(),
      ),
    ),
  );
}

class Initial extends ConsumerStatefulWidget {
  const Initial({super.key});

  @override
  ConsumerState<Initial> createState() => _InitialState();
}

class _InitialState extends ConsumerState<Initial> {
  // ── Android ──────────────────────────────────────────────────────────────
  AppUpdateInfo? _updateInfo;

  // ── iOS ──────────────────────────────────────────────────────────────────
  AppCheckerResult? _iosCheckerResult;

  bool _isCheckingUpdate = true;
  Widget? _initialPage;

  @override
  void initState() {
    super.initState();
    _handleStartupLogic();
  }

  Future<void> _handleStartupLogic() async {
    await _checkForUpdate();

    final bool androidUpdateRequired =
        !kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android &&
        _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable;

    final bool iosUpdateRequired =
        !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS && (_iosCheckerResult?.canUpdate ?? false);

    if (!androidUpdateRequired && !iosUpdateRequired) {
      _determineInitialRoute();
    }

    if (mounted) {
      setState(() => _isCheckingUpdate = false);
    }
  }

  Future<void> _checkForUpdate() async {
    if (kIsWeb) {
      _updateInfo = null;
      _iosCheckerResult = null;
      return;
    }

    // Use defaultTargetPlatform for extra safety (recommended over Platform in some cases)
    if (defaultTargetPlatform == TargetPlatform.android) {
      try {
        final info = await InAppUpdate.checkForUpdate();
        if (mounted) {
          setState(() => _updateInfo = info);
        }
        log('Android Update Availability: ${info.updateAvailability}');
      } catch (e, st) {
        log('Error checking Android update: $e\n$st');
        if (mounted) _updateInfo = null;
      }
      return;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      try {
        final result = await AppVersionChecker().checkUpdate();
        log(
          'iOS Version Check → current: ${result.currentVersion}, '
          'store: ${result.newVersion}, canUpdate: ${result.canUpdate}, '
          'error: ${result.errorMessage}',
        );
        if (mounted) {
          setState(() => _iosCheckerResult = result);
        }
      } catch (e, st) {
        log('Error checking iOS update: $e\n$st');
        if (mounted) _iosCheckerResult = null;
      }
    }
  }

  void _determineInitialRoute() {
    setState(() {
      _initialPage = TokensManagement.studentId == '' ? const Theme07LoginPage() : const BottomBar();
    });
  }

  @override
  Widget build(BuildContext context) {
    log("Token: ${TokensManagement.phoneToken}");
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    // ── Loading splash ─────────────────────────────────────────────────────
    if (_isCheckingUpdate) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App Title',
        theme: themeProvider.themeData,
        home: const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // ── Android force-update (unchanged) ───────────────────────────────────
    if (!kIsWeb && Platform.isAndroid && _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      return const ForceUpdateScreen();
    }

    // ── iOS force-update ───────────────────────────────────────────────────
    if (!kIsWeb && Platform.isIOS && (_iosCheckerResult?.canUpdate ?? false)) {
      return IosForceUpdateScreen(
        appId: _iosCheckerResult!.appId,
        currentVersion: _iosCheckerResult!.currentVersion,
        newVersion: _iosCheckerResult!.newVersion,
      );
    }

    // ── Normal app flow ────────────────────────────────────────────────────
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.themeData,
      title: 'App Title',
      initialRoute: TokensManagement.studentId == '' ? Routes.login : Routes.home,
      routes: RouteBuilder.routes,
      home: _initialPage,
    );
  }
}

// ==================== ANDROID FORCE UPDATE SCREEN (unchanged) ==============

class ForceUpdateScreen extends StatefulWidget {
  const ForceUpdateScreen({super.key});

  @override
  State<ForceUpdateScreen> createState() => _ForceUpdateScreenState();
}

class _ForceUpdateScreenState extends State<ForceUpdateScreen> {
  @override
  void initState() {
    super.initState();
    _startUpdate();
  }

  Future<void> _startUpdate() async {
    try {
      final result = await InAppUpdate.performImmediateUpdate();

      if (result == AppUpdateResult.userDeniedUpdate && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text(
              'Update is required to continue. Please update the app.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) _startUpdate();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Update failed: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.system_update, size: 80, color: Colors.blue),
              SizedBox(height: 24),
              Text(
                'An update is required\nto continue using the app.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== iOS FORCE UPDATE SCREEN ==============================

class IosForceUpdateScreen extends StatelessWidget {
  const IosForceUpdateScreen({
    super.key,
    required this.appId,
    required this.currentVersion,
    required this.newVersion,
  });

  final String? appId;
  final String currentVersion;
  final String? newVersion;

  Future<void> _openAppStore(BuildContext context) async {
    if (appId == null || appId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('App Store link not available')),
      );
      return;
    }

    Uri httpsUri = Uri.parse('https://apps.apple.com/app/id$appId');

    try {
      if (await canLaunchUrl(httpsUri)) {
        final launched = await launchUrl(
          httpsUri,
          mode: LaunchMode.externalApplication,
        );
        log("URL >>>> $httpsUri");
        if (launched) return;
      }

      // Fallback: opens in browser (works on simulator for testing)
      StoreRedirect.redirect(iOSAppId: appId);
      log("Store Redirect >>>> $appId");
    } catch (e) {
      log('Failed to open App Store: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Failed to open App Store: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.system_update, size: 80, color: Colors.blue),
                  const SizedBox(height: 24),
                  const Text(
                    'Update Required',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A new version (${newVersion ?? 'latest'}) is available.\n'
                    'You are on version $currentVersion.\n\n'
                    'Please update the app to continue.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _openAppStore(context),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text(
                        'Update on App Store',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== MISC ==================================================

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class NavigationProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
