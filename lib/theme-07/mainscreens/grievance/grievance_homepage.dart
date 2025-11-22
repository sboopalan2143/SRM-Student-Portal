import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-07/mainscreens/grievance/grievance_detail_page.dart';
import 'package:sample/theme-07/mainscreens/grievance/grievance_entry_screen.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07GrievanceHomePage extends ConsumerStatefulWidget {
  const Theme07GrievanceHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07GrievanceHomePageState();
}

class _Theme07GrievanceHomePageState extends ConsumerState<Theme07GrievanceHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      await ref.read(hostelProvider.notifier).getRoomTypeHiveData('');

      final profile = await Hive.openBox<ProfileHiveData>('profile');
      if (profile.isEmpty) {
        await ref.read(profileProvider.notifier).getProfileApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(profileProvider.notifier).getProfileHive('');
      }
      await profile.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ref
      ..watch(hostelProvider)
      ..listen(hostelProvider, (previous, next) {
        if (next is HostelStateError) {
          _showToast(context, next.errorMessage, AppColors.redColor);
        } else if (next is HostelStateSuccessful) {
          /// Handle route to next page.
          _showToast(context, next.successMessage, AppColors.greenColor);
        }
      });

    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    final cardStyle = BorderBoxButtonDecorations.homePageButtonStyle.copyWith(
      backgroundColor: MaterialStateProperty.all<Color>(
        themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
      ),
      shadowColor: MaterialStateProperty.all<Color>(
        Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
      ),
    );

    final textStyle = width > 400
        ? TextStyles.smallBlackColorFontStyle.copyWith(color: Theme.of(context).colorScheme.inverseSurface)
        : TextStyles.smallerBlackColorFontStyle.copyWith(color: Theme.of(context).colorScheme.inverseSurface);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          'GRIEVANCES',
          style: TextStyles.fontStyle4,
          overflow: TextOverflow.clip,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // E N T R Y   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07GrievanceEntryPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: SizedBox(
                              child: Icon(
                                Icons.edit_note_sharp,
                                color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                                size: 40, // Icon size
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          Text(
                            'Grievances Entry',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // D E T A I L S   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07GrievanceFullDetailPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: SizedBox(
                              child: Icon(
                                Icons.list_alt_outlined,
                                color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                                size: 40, // Icon size
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.006,
                          ),
                          Text(
                            'My Grievances',
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.025,
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
