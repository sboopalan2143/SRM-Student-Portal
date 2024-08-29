// ignore_for_file: inference_failure_on_instance_creation
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/change_password/screen/change_password.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/drawer_pages/profile/screens/profile_page.dart';
import 'package:sample/home/drawer_pages/terms_and_conditions/screens/terms_and_conditions.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/screens/attendance.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/screens/cumulative_attendance.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/screens/exam_details.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/screens/hourwise_page.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/screens/internal_marks.dart';
import 'package:sample/home/main_pages/academics/screens/academics.dart';
import 'package:sample/home/main_pages/academics/subject_pages/screens/subject_page.dart';
import 'package:sample/home/main_pages/academics/timetable_pages/screens/timetable.dart';
import 'package:sample/home/main_pages/fees/screens/fees.dart';
import 'package:sample/home/main_pages/grievances/screens/grievance_entry.dart';
import 'package:sample/home/main_pages/grievances/screens/grievances.dart';
import 'package:sample/home/main_pages/hostel/screens/hostel.dart';
import 'package:sample/home/main_pages/hostel/screens/hostel_leave_application.dart';
import 'package:sample/home/main_pages/hostel/screens/registration.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/library/screens/library.dart';
import 'package:sample/home/main_pages/library/screens/view.dart';
import 'package:sample/home/main_pages/lms/screens/lms.dart';
import 'package:sample/home/main_pages/lms/screens/notes.dart';
import 'package:sample/home/main_pages/lms/screens/notes_details.dart';
import 'package:sample/home/main_pages/lms/screens/online_assessment.dart';
import 'package:sample/home/main_pages/lms/screens/questions.dart';
import 'package:sample/home/main_pages/notification/screens/notification.dart';
import 'package:sample/home/main_pages/theme.dart';
import 'package:sample/home/main_pages/transport/screens/register.dart';
import 'package:sample/home/main_pages/transport/screens/transport.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/login/screen/login_page.dart';
import 'package:sample/network/riverpod/network_state.dart';
import 'package:sample/notification.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
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

    /// Remove the command line after firebase setup
    // FirebaseMessaging.onMessage.listen(showNotification);
  }

  Future<void> _initialProcess() async {
    await TokensManagement.getStudentId();
    await ref.read(loginProvider.notifier).getAppVersion();

    /// Remove the command line after firebase setup
    await TokensManagement.getPhoneToken();
    await TokensManagement.getAppDeviceInfo();
    log('phone token ${TokensManagement.phoneToken}');
    log('deviceId ${TokensManagement.deviceId}');
    log('androidversion ${TokensManagement.androidVersion}');
    log('appversion ${TokensManagement.appVersion}');
    log('model ${TokensManagement.model}');
    log('sdkversion ${TokensManagement.sdkVersion}');
  }

  Future<void> showNotification(RemoteMessage message) async {
    await AppNotification.createNotification(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      networkImagePath: message.data['image'] as String?,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(mainProvider);
    final providerLogin = ref.watch(loginProvider);
    ref.listen(networkProvider, (previous, next) {
      if (previous!.connectivityResult == ConnectivityResult.none &&
          next.connectivityResult != ConnectivityResult.none) {
        /// Handle offline to online function calls
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              if (ref.watch(mainProvider).navString == 'Timetable' ||
                  ref.watch(mainProvider).navString == 'Subjects' ||
                  ref.watch(mainProvider).navString == 'Internal Marks' ||
                  ref.watch(mainProvider).navString == 'Attendance' ||
                  ref.watch(mainProvider).navString == 'Hour Attendance' ||
                  ref.watch(mainProvider).navString ==
                      'Cumulative Attendance' ||
                  ref.watch(mainProvider).navString == 'Exam Details') {
                ref.read(mainProvider.notifier).setNavString('Academics');
              } else if (ref.watch(mainProvider).navString ==
                      'Online Assessment' ||
                  ref.watch(mainProvider).navString == 'Notes') {
                ref.read(mainProvider.notifier).setNavString('LMS');
              } else if (ref.watch(mainProvider).navString ==
                  'C Programming Language') {
                ref
                    .read(mainProvider.notifier)
                    .setNavString('Online Assessment');
              } else if (ref.watch(mainProvider).navString ==
                  'C Programming Language1') {
                ref.read(mainProvider.notifier).setNavString('Notes');
              } else if (ref.watch(mainProvider).navString ==
                      'Leave Application' ||
                  ref.watch(mainProvider).navString == 'Registration') {
                ref.read(mainProvider.notifier).setNavString('Hostel');
              } else if (ref.watch(mainProvider).navString ==
                  'Grievance Entry') {
                ref.read(mainProvider.notifier).setNavString('Grievances');
              } else if (ref.watch(mainProvider).navString == 'Register') {
                ref.read(mainProvider.notifier).setNavString('Transport');
              } else if (ref.watch(mainProvider).navString == 'View') {
                ref.read(mainProvider.notifier).setNavString('Library');
              } else if (ref.watch(mainProvider).navString == 'Fees') {
                ref.read(mainProvider.notifier).setNavString('Library');
              } else {
                ref.read(mainProvider.notifier).setNavString('Home');
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (provider.navString == 'Home') const SizedBox(height: 20),
                if (provider.navString == 'Home')
                  Text(
                    '${providerLogin.studentData.studentname}' == ''
                        ? '-'
                        : '${providerLogin.studentData.studentname}',
                    style: TextStyles.fontStyle4,
                  ),
                if (provider.navString == 'Home') const SizedBox(height: 5),
                if (provider.navString == 'Home')
                  const Text(
                    "to SRM Student's Portal",
                    style: TextStyles.fontStyle5,
                  ),
                if (provider.navString == 'Home') const SizedBox(height: 30),
                if (provider.navString != 'Home')
                  Text(
                    provider.navString,
                    style: provider.navString == 'Questions'
                        ? TextStyles.fontStyle1
                        : TextStyles.fontStyle4,
                    overflow: TextOverflow.clip,
                  ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 35,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: _mainBody()),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.64,
        child: Drawer(
          // backgroundColor: backgroundColor,
          child: ListView(
            // ignore: use_named_constants
            padding: const EdgeInsets.all(0),
            children: [
              SizedBox(
                height: 220,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/profile.png',
                          height: 100,
                        ),
                        Text(
                          '${providerLogin.studentData.studentname}' == ''
                              ? '-'
                              : '${providerLogin.studentData.studentname}',
                          style: TextStyles.fontStyle3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Row(
                  children: [
                    Text(
                      'Home',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref.read(mainProvider.notifier).setNavString('Home');
                  Navigator.pop(context);
                },
              ), //
              ListTile(
                title: const Row(
                  children: [
                    Text(
                      'Profile',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  try {
                    ref.read(profileProvider.notifier).getProfileDetails(
                          ref.read(
                            encryptionProvider.notifier,
                          ),
                        );
                    ref.read(mainProvider.notifier).setNavString('Profile');
                  } catch (e) {
                    TokensManagement.clearSharedPreference();
                    Navigator.pushAndRemoveUntil(
                      context,
                      RouteDesign(route: const LoginPage()),
                      (route) => false,
                    );
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Row(
                  children: [
                    Text(
                      'Theme',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref.read(mainProvider.notifier).setNavString('Theme');
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Row(
                  children: [
                    Text(
                      'Change Password',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref
                      .read(mainProvider.notifier)
                      .setNavString('Change Password');
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Row(
                  children: [
                    Text(
                      'Terms & Conditions',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref
                      .read(mainProvider.notifier)
                      .setNavString('Terms & Conditions');
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Row(
                  children: [
                    Text(
                      'Logout',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref.read(mainProvider.notifier).setNavString('Logout');
                  TokensManagement.clearSharedPreference();
                  Navigator.pushAndRemoveUntil(
                    context,
                    RouteDesign(route: const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainBody() {
    final provider = ref.watch(mainProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        if (provider.navString == 'Home') _mainCards(),
        if (provider.navString == 'Profile') const ProfilePage(),
        if (provider.navString == 'Terms & Conditions')
          const TermsAndConditions(),
        if (provider.navString == 'Change Password') const ChangePassword(),
        if (provider.navString == 'Theme') const ThemePage(),
        //HomePage Navigations
        //Academics
        if (provider.navString == 'Academics') const AcademicsPage(),
        if (provider.navString == 'Timetable') const TimeTablePage(),
        if (provider.navString == 'Subjects') const SubjectPage(),
        if (provider.navString == 'Internal Marks') const InternalMarksPage(),
        if (provider.navString == 'Attendance') const AttendancePage(),
        if (provider.navString == 'Hour Attendance') const HourAttendancePage(),
        if (provider.navString == 'Cumulative Attendance')
          const CumulativeAttendancePage(),
        if (provider.navString == 'Exam Details') const ExamDetailsPage(),
        //LMS
        if (provider.navString == 'LMS') const LMSPage(),
        if (provider.navString == 'Online Assessment')
          const OnlineAssessmentPage(),
        if (provider.navString == 'C Programming Language')
          const QuestionPage(),
        if (provider.navString == 'C Programming Language1')
          const NotesDetailsPage(),
        if (provider.navString == 'Notes') const NotesPage(),
        //Fees
        if (provider.navString == 'Fees') const FeesPage(),
        //Hostel
        if (provider.navString == 'Hostel') const HostelPage(),
        if (provider.navString == 'Leave Application')
          const LeaveApplicationPage(),
        if (provider.navString == 'Registration') const RegistrationPage(),
        //Grievances
        if (provider.navString == 'Grievances') const GrievanceReportPage(),
        if (provider.navString == 'Grievance Entry') const GrievanceEntryPage(),
        //Transport
        if (provider.navString == 'Transport') const TransportTransactionPage(),
        if (provider.navString == 'Register') const RegisterPage(),
        //Library
        if (provider.navString == 'Library') const LibraryPage(),
        if (provider.navString == 'View') const ViewLibraryPage(),
        //Notification
        if (provider.navString == 'Notification') const NotificationPage(),
      ],
    );
  }

  Widget _mainCards() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    log('width $width');
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Academics');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/academics.png',
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Academics',
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
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('LMS');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/LMS.png',
                          height: 80,
                        ),
                      ),
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
                      // SizedBox(
                      //   height: height * 0.027,
                      // ),
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
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Fees');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/fees.png',
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Fees',
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
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Hostel');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/hostel.png',
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Hostel',
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
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref
                        .read(mainProvider.notifier)
                        .setNavString('Notification');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/Notification.png',
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Notification',
                        textAlign: TextAlign.center,
                        style: width > 400
                            ? TextStyles.smallBlackColorFontStyle
                            : TextStyles.smallerBlackColorFontStyle,
                      ),
                      // SizedBox(
                      //   height: height * 0.027,
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Grievances');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/grievances.png',
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Grievances',
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
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    try {
                      ref
                          .read(libraryProvider.notifier)
                          .getLibraryMemberDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                    } catch (e) {
                      TokensManagement.clearSharedPreference();
                      Navigator.pushAndRemoveUntil(
                        context,
                        RouteDesign(route: const LoginPage()),
                        (route) => false,
                      );
                    }
                    ref.read(mainProvider.notifier).setNavString('Library');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/library.png',
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Library',
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
                height: 140,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Transport');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        child: Image.asset(
                          'assets/images/transport.png',
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.006,
                      ),
                      Text(
                        'Transport',
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
        ],
      ),
    );
  }
}
