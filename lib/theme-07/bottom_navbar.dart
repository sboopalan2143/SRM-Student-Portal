import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart';
import 'package:sample/main.dart';
import 'package:sample/theme-07/dhasboard_07_page.dart';
import 'package:sample/theme-07/mainscreens/settings_page.dart';
import 'package:sample/theme-07/theme07_explore.dart';
import 'package:sample/theme-07/theme07_profile_screen.dart';
import 'package:sample/theme/theme_provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});
  static final GlobalKey<BottomBarState> globalKey = GlobalKey<BottomBarState>();

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  late ThemeProvider themeProvider;
  late NavigationProvider navigationProvider;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    navigationProvider = Provider.of<NavigationProvider>(context, listen: false);
    themeProvider.addListener(updateSystemNavigationBar);
    pageController = PageController(initialPage: navigationProvider.selectedIndex);
    // Listen to NavigationProvider changes to update pageController
    navigationProvider.addListener(_onNavigationChanged);
  }

  void _onNavigationChanged() {
    // Ensure pageController jumps to the correct page when selectedIndex changes
    if (pageController.hasClients) {
      pageController.jumpToPage(navigationProvider.selectedIndex);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateSystemNavigationBar();
  }

  void updateSystemNavigationBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: themeProvider.isDarkMode ? Colors.black.withAlpha(255) : Colors.white.withAlpha(255),
        systemNavigationBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarContrastEnforced: true,
      ),
    );
  }

  void _handlePop(bool didPop, dynamic result) {
    if (didPop) {
      return;
    }
    if (navigationProvider.selectedIndex == 0) {
      SystemNavigator.pop();
    } else {
      navigationProvider.setSelectedIndex(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: _handlePop,
          child: Scaffold(
            key: BottomBar.globalKey,
            extendBody: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Stack(
              children: [
                PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    navigationProvider.setSelectedIndex(index);
                  },
                  children: const [
                    Theme07dhasboardPage(),
                    ExplorePage(),
                    SettingsPage(),
                    Theme07ProfilePage(),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.inverseSurface.withAlpha(40),
                          blurRadius: 20,
                          offset: const Offset(0, -8),
                        ),
                      ],
                    ),
                    child: BottomNavigationBar(
                      currentIndex: navigationProvider.selectedIndex,
                      onTap: (index) {
                        HapticFeedback.mediumImpact();
                        navigationProvider.setSelectedIndex(index);
                      },
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
                      unselectedItemColor: Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                      type: BottomNavigationBarType.fixed,
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(
                            navigationProvider.selectedIndex == 0 ? IconsaxPlusBold.home_1 : IconsaxPlusLinear.home_1,
                            size: 24,
                            color: navigationProvider.selectedIndex == 0
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                          ),
                          label: 'Home',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            navigationProvider.selectedIndex == 1
                                ? IconsaxPlusBold.discover_1
                                : IconsaxPlusLinear.discover,
                            size: 24,
                            color: navigationProvider.selectedIndex == 1
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                          ),
                          label: 'Explore',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            navigationProvider.selectedIndex == 2 ? IconsaxPlusBold.setting : IconsaxPlusLinear.setting,
                            size: 24,
                            color: navigationProvider.selectedIndex == 2
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                          ),
                          label: 'Settings',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(
                            navigationProvider.selectedIndex == 3 ? IconsaxPlusBold.teacher : IconsaxPlusLinear.teacher,
                            size: 24,
                            color: navigationProvider.selectedIndex == 3
                                ? Theme.of(context).colorScheme.inversePrimary
                                : Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                          ),
                          label: 'Profile',
                        ),
                      ],
                      selectedLabelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    themeProvider.removeListener(updateSystemNavigationBar);
    navigationProvider.removeListener(_onNavigationChanged);
    pageController.dispose();
    super.dispose();
  }
}
