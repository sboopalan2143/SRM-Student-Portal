import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-02/mainscreens/academics/attendance_home_page.dart';
import 'package:sample/theme-02/mainscreens/academics/subject.dart';
import 'package:sample/theme-02/mainscreens/calendar_home_page_screen.dart';
import 'package:sample/theme-02/mainscreens/calendar_screen.dart';
import 'package:sample/theme-02/mainscreens/grade_home_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_subject_screen.dart';
import 'package:sample/theme-02/time_table_page.dart';

class AcademicsHomePage extends ConsumerStatefulWidget {
  const AcademicsHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AcademicsHomePageState();
}

class _AcademicsHomePageState extends ConsumerState<AcademicsHomePage> {
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
    final provider = ref.watch(hostelProvider);
    final width = MediaQuery.of(context).size.width;
    log('Regconfig  : ${provider.hostelRegisterDetails!.regconfig}');
    log('status  : ${provider.hostelRegisterDetails!.status}');
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme02primaryColor,
                  AppColors.theme02secondaryColor1,
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
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    // route: const Theme02SubjectPage(),
                    route: const Theme02CalendarPage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.75, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: MediaQuery.of(context).size.height / 22,
                          color: AppColors.whiteColor,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme02SubjectPage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.75, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/subjectstheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Course',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    // route: const Theme02SubjectPage(),
                    route: const Theme02TimetablePageScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.75, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_view_month,
                          size: MediaQuery.of(context).size.height / 22,
                          color: AppColors.whiteColor,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Timetable',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    // route: const Theme02SubjectPage(),
                    route: const AttendanceHomePage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.75, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/attendancetheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    // route: const Theme02SubjectPage(),
                    route: const GradeHomePage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.75, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/hourattendancetheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Grades',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme02LmsHomePage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.75, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/lmstheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'LMS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
