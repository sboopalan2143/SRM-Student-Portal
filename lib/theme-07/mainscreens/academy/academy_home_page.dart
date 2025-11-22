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
import 'package:sample/theme-07/mainscreens/academy/attendance_page.dart';
import 'package:sample/theme-07/mainscreens/academy/calendar_screen.dart';
import 'package:sample/theme-07/mainscreens/academy/grade_homepage.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_homePage.dart';
import 'package:sample/theme-07/mainscreens/academy/subject_page.dart';
import 'package:sample/theme-07/mainscreens/academy/time_table_screen.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07AcademicsHomePage extends ConsumerStatefulWidget {
  const Theme07AcademicsHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07AcademicsHomePageState();
}

class _Theme07AcademicsHomePageState extends ConsumerState<Theme07AcademicsHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // await ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      // await ref.read(hostelProvider.notifier).getRoomTypeHiveData('');

      // final profile = await Hive.openBox<ProfileHiveData>('profile');
      // if (profile.isEmpty) {
      //   await ref.read(profileProvider.notifier).getProfileApi(
      //         ref.read(
      //           encryptionProvider.notifier,
      //         ),
      //       );
      //   await ref.read(profileProvider.notifier).getProfileHive('');
      // }
      // await profile.close();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
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
            'ACADEMICS',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: height * 0.025,
          ),

          // R O W   1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // C A L E N D A R   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07CalendarPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Icon(
                          Icons.calendar_today, // Grade icon
                          color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                          size: 40, // Icon size
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Calendar',
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),

              // C O U R S E   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07SubjectPage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Icon(
                          Icons.menu_book, // Grade icon
                          color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                          size: 40, // Icon size
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Course',
                        textAlign: TextAlign.center,
                        style: textStyle,
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

          // R O W   2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // T I M E T A B L E   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07TimetablePageScreen(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Icon(
                          Icons.calendar_view_month, // Grade icon
                          color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                          size: 40, // Icon size
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Timetable',
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),

              // A T T E N D A N C E   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        // route: const Theme02SubjectPage(),
                        route: const Theme07AttendanceHomePage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Icon(
                          Icons.list_alt, // Grade icon
                          color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                          size: 40, // Icon size
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Attendance',
                        textAlign: TextAlign.center,
                        style: textStyle,
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

          // G R A D E   W I D G E T
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07GradeHomePage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Icon(
                          Icons.grade, // Grade icon
                          color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                          size: 40, // Icon size
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Grade',
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
              ),

              // L M S   W I D G E T
              SizedBox(
                height: 120,
                width: width * 0.36,
                child: ElevatedButton(
                  style: cardStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme07LmsHomePage(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/LMS.png',
                          color: Theme.of(context).colorScheme.inversePrimary, // Gold color
                          height: 20,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'LMS',
                        textAlign: TextAlign.center,
                        style: textStyle,
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
