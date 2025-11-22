import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/theme-07/login/login_page_theme07.dart';
import 'package:sample/theme-07/theme07_change_password.dart';
import 'package:sample/theme/theme_selection_page.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  // Logout function
  void logout(BuildContext context, WidgetRef ref) {
    showDialog(
      barrierColor: const Color.fromARGB(175, 0, 0, 0),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(
            'Logout Confirmation',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.red.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                ref.read(mainProvider.notifier).setNavString('Logout');

                await TokensManagement.clearSharedPreference();

                await Navigator.pushAndRemoveUntil(
                  context,
                  RouteDesign(
                    route: const Theme07LoginPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const Icon(FluentSystemIcons.ic_fluent_settings_filled),
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.color_lens_rounded,
                  size: 30,
                  color: Colors.white,
                ),
                title: const Text(
                  'Themes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                  color: Colors.white,
                ),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  // Navigate to theme selection page
                  Navigator.push(
                    context,
                    RouteDesign(route: const ThemeSelectionPage()),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          // B O T T O M   T I L E
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40, bottom: 16, right: 40),
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // color: Colors.teal.shade400,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_reset_sharp,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'C H A N G E   P A S S W O R D',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07ChangePasswordPage(),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  bottom: 100 + MediaQuery.of(context).padding.bottom,
                  right: 40,
                ),
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_sharp,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'L O G O U T',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    logout(context, ref);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
