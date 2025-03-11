import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/attendance_page.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/calendar_screen.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/grade_homepage.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/lms_homePage.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/subject_page.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/time_table_screen.dart';

class Theme07AcademicsHomePage extends ConsumerStatefulWidget {
  const Theme07AcademicsHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07AcademicsHomePageState();
}

class _Theme07AcademicsHomePageState extends ConsumerState<Theme07AcademicsHomePage> {
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


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(hostelProvider);
    log('Regconfig  : ${provider.hostelRegisterDetails.regconfig}');
    log('status  : ${provider.hostelRegisterDetails.status}');
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

    return Scaffold(
       key: _scaffoldKey,
      backgroundColor: AppColors.theme07secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme07primaryColor,
                  AppColors.theme07primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 120,

                                  width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
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
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Calendar',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.06,
                                ),
                                SizedBox(
                                  height: 120,
                                  width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
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
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Course',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
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
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 120,

                                  width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
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
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Timetable',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.06,
                                ),
                                SizedBox(
                                  height: 120,

                                  width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
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
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Attendance',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
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
                             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 120,

                                  width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
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
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Grade',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.06,
                                ),
                                SizedBox(
                                  height: 120,
                                  width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
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
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'LMS',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
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
