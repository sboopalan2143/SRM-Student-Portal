import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Added for ConsumerStatefulWidget
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/alerts_design.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/designs/status_bar_navigation_bar_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/model/cummulative_attendance_hive.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_hive_model.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_hive_model.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/model/internal_mark_hive_model.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/dhasboard_overall_attendance_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendance_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
import 'package:sample/home/main_pages/cgpa/riverpod/cgpa_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/riverpod/fees_dhasboard_Page_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/home/main_pages/sgpa/riverpod/sgpa_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/theme-07/login/login_page_theme07.dart';
import 'package:sample/theme-07/mainscreens/academy/attendance_page.dart';
import 'package:sample/theme-07/mainscreens/academy/calendar_screen.dart';
import 'package:sample/theme-07/mainscreens/academy/grade_homepage.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_homePage.dart';
import 'package:sample/theme-07/mainscreens/academy/subject_page.dart';
import 'package:sample/theme-07/mainscreens/academy/time_table_screen.dart';
import 'package:sample/theme-07/mainscreens/fees/fees_home_page.dart';
import 'package:sample/theme-07/mainscreens/grievance/grievance_detail_page.dart';
import 'package:sample/theme-07/mainscreens/grievance/grievance_entry_screen.dart';
import 'package:sample/theme-07/mainscreens/hostel/hostel_home_screen.dart';
import 'package:sample/theme-07/mainscreens/hostel/hostel_registration_page.dart';
import 'package:sample/theme-07/mainscreens/hostel/theme07_hostel_screen.dart';
import 'package:sample/theme-07/mainscreens/library/library_details_screen.dart';
import 'package:sample/theme-07/mainscreens/library/library_search.dart';
import 'package:sample/theme-07/mainscreens/transport/transport_register.dart';
import 'package:sample/theme-07/notification_homepage.dart';
import 'package:sample/theme-07/theme07_change_password.dart';
import 'package:sample/theme-07/theme07_profile_screen.dart';
import 'package:sample/theme/theme_provider.dart';

class ExplorePage extends ConsumerStatefulWidget {
  const ExplorePage({super.key});

  @override
  ConsumerState<ExplorePage> createState() => ExplorePageState();
}

class ExplorePageState extends ConsumerState<ExplorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController _listController = ScrollController();

  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      SystemChrome.setSystemUIOverlayStyle(
        StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initialProcess();
    Alerts.checkForAppUpdate(context: context, forcefully: false);
  }

  Future<void> _initialProcess() async {
    await TokensManagement.getStudentId();
    await ref.read(loginProvider.notifier).getAppVersion();
    await TokensManagement.getPhoneToken();
    await TokensManagement.getAppDeviceInfo();
    await TokensManagement.getTheme();

//ACADEMICS

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(profileProvider.notifier).getProfileApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(profileProvider.notifier).getProfileHive('');
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cgpaProvider.notifier).getCgpaDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sgpaProvider.notifier).getSgpaDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feesDhasboardProvider.notifier).getFeesDhasboardDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationCountProvider.notifier).getNotificationCountDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(overallattendanceProvider.notifier).getSubjectWiseOverallAttendanceDetails(
            ref.read(encryptionProvider.notifier),
          );
    });

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(feesProvider.notifier).getFinanceDetailsApi(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getFeedDueDetails(ref.read(encryptionProvider.notifier));
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(calendarProvider.notifier).getCalendarDetails(ref.read(encryptionProvider.notifier));
        await ref.read(calendarProvider.notifier).getHiveCalendar('');
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(DhasboardoverallattendanceProvider.notifier).getDhasboardOverallAttendanceDetails(
              ref.read(encryptionProvider.notifier),
            );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(transportProvider.notifier).getTransportStatusDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getTransportStatusHiveDetails('');
        await ref.read(transportProvider.notifier).getRouteIdDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getRouteIdHiveDetails(
              '',
            );
        await ref.read(transportProvider.notifier).getBoardingIdDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getBoardingPointHiveDetails(
              '',
            );
        await ref.read(transportProvider.notifier).gettransportRegisterDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getTransportHiveRegisterDetails('');
        await ref.read(transportProvider.notifier).getTransportHiveAfterRegisterDetails('');
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hostelProvider.notifier).getHostelHiveDetails(
            '',
          );
    });

//>>>Attendance

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(notificationProvider.notifier).getNotificationDetails(
              ref.read(encryptionProvider.notifier),
            );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(attendanceProvider.notifier).getAttendanceDetails(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
      },
    );

    final attendance = await Hive.openBox<AttendanceHiveData>(
      'Attendance',
    );
    if (attendance.isEmpty) {
      await ref.read(attendanceProvider.notifier).getAttendanceDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
    }
    await attendance.close();

//>>>Cummulative Attendance

    final cummulativeAttendance = await Hive.openBox<CumulativeAttendanceHiveData>(
      'cumulativeattendance',
    );
    if (cummulativeAttendance.isEmpty) {
      await ref.read(cummulativeAttendanceProvider.notifier).getCummulativeAttendanceDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(cummulativeAttendanceProvider.notifier).getHiveCummulativeDetails('');
    }
    await cummulativeAttendance.close();

//>>>Exam Details

    final examDetails = await Hive.openBox<ExamDetailsHiveData>('examDetails');
    if (examDetails.isEmpty) {
      await ref.read(examDetailsProvider.notifier).getExamDetailsApi(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(examDetailsProvider.notifier).getHiveExamDetails('');
    }
    await examDetails.close();

//>>>Hourwise Attendance

    final hourwiseAttendance = await Hive.openBox<HourwiseHiveData>(
      'hourwisedata',
    );
    if (hourwiseAttendance.isEmpty) {
      await ref.read(hourwiseProvider.notifier).gethourwiseDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(hourwiseProvider.notifier).getHiveHourwise('');
    }
    await hourwiseAttendance.close();

//>>>Internal Marks

    final internalMarks = await Hive.openBox<InternalMarkHiveData>(
      'internalmarkdata',
    );
    if (internalMarks.isEmpty) {
      await ref.read(internalMarksProvider.notifier).getInternalMarksDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref.read(internalMarksProvider.notifier).getHiveInternalMarks('');
    }
    await internalMarks.close();

//>>>Subject

    final subjects = await Hive.openBox<SubjectHiveData>('subjecthive');
    if (subjects.isEmpty) {
      await ref.read(subjectProvider.notifier).getSubjectDetails(ref.read(encryptionProvider.notifier));
      await ref.read(subjectProvider.notifier).getHiveSubjectDetails('');
    }
    await subjects.close();

    //GRIEVANCES

    final grievanceCategoryData = await Hive.openBox<GrievanceCategoryHiveData>(
      'grievanceCategoryData',
    );
    if (grievanceCategoryData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceCategoryDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceCategoryDetails('');
    }
    await grievanceCategoryData.close();

    final grievanceSubTypeData = await Hive.openBox<GrievanceSubTypeHiveData>(
      'grievanceSubTypeData',
    );
    if (grievanceSubTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceSubTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceSubTypeDetails('');
    }
    await grievanceSubTypeData.close();

    final grievanceTypeData = await Hive.openBox<GrievanceTypeHiveData>(
      'grievanceTypeData',
    );
    if (grievanceTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceTypeDetails('');
    }
    await grievanceTypeData.close();

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
  }

  // Logout function
  void logout(BuildContext context) {
    showDialog(
      barrierColor: const Color.fromARGB(175, 0, 0, 0),
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Logout Confirmation',
            style: TextStyle(color: Colors.teal.shade500, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red.shade800, fontWeight: FontWeight.bold),
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
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final notificatioCountprovider = ref.watch(notificationCountProvider);

    // A C A D E M I C   I C O N   M A P (Updated to use IconData)
    final academic = <Map<String, dynamic>>[
      {
        'icon': Icons.calendar_today, // Replaced asset with IconData
        'label': 'Calendar',
        'page': const Theme07CalendarPage(),
      },
      {
        'icon': Icons.menu_book,
        'label': 'Course',
        'page': const Theme07SubjectPage(),
      },
      {
        'icon': Icons.calendar_view_month,
        'label': 'Timetable',
        'page': const Theme07TimetablePageScreen(),
      },
      {
        'icon': Icons.list_alt,
        'label': 'Attendance',
        'page': const Theme07AttendanceHomePage(),
      },
      {
        'icon': Icons.grade,
        'label': 'Grade',
        'page': const Theme07GradeHomePage(),
      },
      {
        'icon': Icons.book_rounded,
        'label': 'LMS',
        'page': const Theme07LmsHomePage(),
      },
    ];

    // A T T E N D E N C E   I C O N   M A P (Updated to use IconData)
    final others = <Map<String, dynamic>>[
      // {
      //   'icon': Icons.person,
      //   'label': 'Profile',
      //   'page': const Theme07ProfilePage(),
      // },
      {
        'icon': Icons.currency_rupee_outlined,
        'label': 'Fee',
        'page': const Theme007FeesPage(),
      },
      {
        'icon': Icons.hotel_outlined,
        'label': 'Hostel',
        'page': const Theme07RegistrationPage(),
        // 'page': const Theme07HostelHomePage(),
        // 'page': const Theme07HostelPage(),
      },
      {
        'icon': IconsaxPlusBold.bus,
        'label': 'Transport',
        'page': const Theme07TransportRegisterPage(),
      },
    ];

    // F E E S   I C O N   M A P (Updated to use IconData)
    final library = <Map<String, dynamic>>[
      {
        'icon': Icons.library_add_check,
        'label': 'Library\nTransactions',
        'page': const Theme07LibraryPage(),
      },
      {
        'icon': Icons.search,
        'label': 'Book Search',
        'page': const Theme07LibraryBookSearch(),
      },
    ];

    // F E E S   I C O N   M A P (Updated to use IconData)
    final grievance = <Map<String, dynamic>>[
      {
        'icon': Icons.edit_note_sharp,
        'label': 'Grievance\nEntry',
        'page': const Theme07GrievanceEntryPage(),
      },
      {
        'icon': Icons.list_alt_outlined,
        'label': 'My\nGrievances',
        'page': const Theme07GrievanceFullDetailPage(),
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Explore',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                iconSize: 28,
                color: Colors.white,
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const Theme07NotificationHomePage(),
                    ),
                  );
                },
              ),
              if (notificatioCountprovider.notificationCountData.isEmpty)
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: SizedBox(
                      width: 5,
                      child: Column(
                        children: [
                          if (notificatioCountprovider.notificationCountData.isNotEmpty)
                            ListView.builder(
                              itemCount: notificatioCountprovider.notificationCountData.length,
                              controller: _listController,
                              shrinkWrap: true,
                              itemBuilder: (
                                BuildContext context,
                                int index,
                              ) {
                                return notificationCountCardDesign(
                                  index,
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 20, bottom: MediaQuery.of(context).padding.bottom + 60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCard(context, text: 'Fees & Registration', pack: others),
                // const SizedBox(height: 20),
                buildCard(context, text: 'Academic', pack: academic),
                // const SizedBox(height: 20),
                buildCard(context, text: 'Library', pack: library),
                // const SizedBox(height: 20),
                buildCard(context, text: 'Grievance', pack: grievance),
                // const SizedBox(height: 50),
                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(left: 40, bottom: 16, right: 40),
                //       child: GestureDetector(
                //         child: Container(
                //           padding: const EdgeInsets.symmetric(vertical: 16),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(16),
                //             color: Theme.of(context).colorScheme.primary,
                //           ),
                //           child: const Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.lock_reset_sharp,
                //                 color: Colors.white,
                //               ),
                //               SizedBox(width: 8),
                //               Text(
                //                 'C H A N G E   P A S S W O R D',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                   color: Colors.white,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             RouteDesign(
                //               route: const Theme07ChangePasswordPage(),
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 40, bottom: 16, right: 40),
                //       child: GestureDetector(
                //         child: Container(
                //           padding: const EdgeInsets.symmetric(vertical: 16),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(16),
                //             color: Theme.of(context).colorScheme.inverseSurface,
                //           ),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.logout_sharp,
                //                 color: Theme.of(context).colorScheme.surface,
                //               ),
                //               const SizedBox(width: 8),
                //               Text(
                //                 'L O G O U T',
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                   color: Theme.of(context).colorScheme.surface,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         onTap: () {
                //           logout(context);
                //         },
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCard(
    BuildContext context, {
    required String text,
    required List pack,
  }) {
    final itemCount = pack.length;
    var cardHeight = itemCount.ceil() * 150;
    if (itemCount <= 2) {
      cardHeight = (itemCount / 2).ceil() * 120;
    } else {
      cardHeight = (itemCount / 4).ceil() * 100;
    }
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        height: cardHeight.toDouble() + 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      // crossAxisSpacing: 0,
                    ),
                    itemCount: pack.length,
                    itemBuilder: (BuildContext context, int index) {
                      final itemData = pack[index];
                      return iconThemeDesign(
                        context,
                        icon: itemData['icon'] as IconData, // Cast to IconData
                        label: itemData['label'] as String, // Cast to String
                        onTap: () {
                          if (itemData['page'] != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => itemData['page'] as Widget,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget iconThemeDesign(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 30,
              backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
              child: IconButton(
                icon: Icon(
                  icon,
                  size: 25,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: onTap,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationCountCardDesign(int index) {
    final notificatioCountprovider = ref.watch(notificationCountProvider);
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Text(
            '${notificatioCountprovider.notificationCountData[index].unreadnotificationcount}' == 'null'
                ? '-'
                : '''${notificatioCountprovider.notificationCountData[index].unreadnotificationcount}''',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
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
