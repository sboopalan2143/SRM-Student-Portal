import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/drawer_pages/change_password/screen/change_password.dart';
import 'package:sample/home/drawer_pages/profile/screens/profile_page.dart';
import 'package:sample/home/drawer_pages/terms_and_conditions/screens/terms_and_conditions.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/screens/attendance.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/screens/cumulative_attendance.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/screens/exam_details.dart';
import 'package:sample/home/main_pages/academics/hour_attendance_pages/screens/hour_attendance.dart';
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
import 'package:sample/home/main_pages/library/screens/library.dart';
import 'package:sample/home/main_pages/library/screens/view.dart';
import 'package:sample/home/main_pages/lms/screens/lms.dart';
import 'package:sample/home/main_pages/lms/screens/notes.dart';
import 'package:sample/home/main_pages/lms/screens/notes_details.dart';
import 'package:sample/home/main_pages/lms/screens/online_assessment.dart';
import 'package:sample/home/main_pages/lms/screens/questions.dart';
import 'package:sample/home/main_pages/notification/screens/notification.dart';
import 'package:sample/home/main_pages/transport/screens/register.dart';
import 'package:sample/home/main_pages/transport/screens/transport.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/network/network_state.dart';
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
    await TokensManagement.getAuthToken();

    /// Remove the command line after firebase setup
    // await TokensManagement.getPhoneToken();
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
    ref.listen(networkProvider, (previous, next) {
      if (previous!.connectivityResult == ConnectivityResult.none &&
          next.connectivityResult != ConnectivityResult.none) {
        /// Handle offline to online function calls
      }
    });
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        leadingWidth: 40,
        leading: IconButton(
          onPressed: () {
            if (ref.watch(mainProvider).navString == 'Timetable' ||
                ref.watch(mainProvider).navString == 'Subjects' ||
                ref.watch(mainProvider).navString == 'Internal Marks' ||
                ref.watch(mainProvider).navString == 'Attendance' ||
                ref.watch(mainProvider).navString == 'Hour Attendance' ||
                ref.watch(mainProvider).navString == 'Cumulative Attendance' ||
                ref.watch(mainProvider).navString == 'Exam Details') {
              ref.read(mainProvider.notifier).setNavString('Academics');
            } else if (ref.watch(mainProvider).navString ==
                    'Online Assessment' ||
                ref.watch(mainProvider).navString == 'Notes') {
              ref.read(mainProvider.notifier).setNavString('LMS');
            } else {
              ref.read(mainProvider.notifier).setNavString('Home');
              Navigator.of(context).push(
                // ignore: inference_failure_on_instance_creation
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
          },
          icon:
              const Icon(Icons.arrow_back_ios_new, color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        title: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (provider.navString == 'Home')
                const Text('Welcome User', style: TextStyles.fontStyle4),
              if (provider.navString == 'Home') const SizedBox(height: 5),
              if (provider.navString == 'Home')
                const Text(
                  "to SRM Student's Portal",
                  style: TextStyles.fontStyle5,
                ),
              if (provider.navString == 'Home') const SizedBox(height: 20),
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
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                      child: Column(
                    children: [
                      Image.asset(
                        'assets/images/profile.png',
                        height: 100,
                      ),
                      const Text(
                        'Welcome User',
                        style: TextStyles.fontStyle3,
                      ),
                    ],
                  )),
                ),
              ),
              ListTile(
                title: const Row(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/images/profile.svg',
                    //   height: 20,
                    // ),
                    // const SizedBox(
                    //   width: 30,
                    // ),
                    Text(
                      'Home',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref.read(mainProvider.notifier).setNavString('Home');
                },
              ), //
              ListTile(
                title: const Row(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/images/profile.svg',
                    //   height: 20,
                    // ),
                    // const SizedBox(
                    //   width: 30,
                    // ),
                    Text(
                      'Profile',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref.read(mainProvider.notifier).setNavString('Profile');
                },
              ),
              ListTile(
                title: const Row(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/images/change_password.svg',
                    //   height: 20,
                    // ),
                    // const SizedBox(
                    //   width: 30,
                    // ),
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
                },
              ),

              ListTile(
                title: const Row(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/images/terms.svg',
                    //   height: 20,
                    // ),
                    // const SizedBox(
                    //   width: 30,
                    // ),
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
                },
              ),

              ListTile(
                title: const Row(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/images/log_out.svg',
                    //   height: 20,
                    // ),
                    // const SizedBox(
                    //   width: 30,
                    // ),
                    Text(
                      'Logout',
                      style: TextStyles.fontStyle2,
                    ),
                  ],
                ),
                onTap: () {
                  ref.read(mainProvider.notifier).setNavString('Logout');
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
        if (provider.navString == 'Academics') const AcademicsPage(),
        if (provider.navString == 'LMS') const LMSPage(),
        if (provider.navString == 'Fees') const FeesPage(),
        if (provider.navString == 'Timetable') const TimeTablePage(),
        if (provider.navString == 'Subjects') const SubjectPage(),
        if (provider.navString == 'Exam Details') const ExamDetailsPage(),
        if (provider.navString == 'Internal Marks') const InternalMarksPage(),
        if (provider.navString == 'Attendance') const AttendancePage(),
        if (provider.navString == 'Cumulative Attendance')
          const CumulativeAttendancePage(),
        if (provider.navString == 'Online Assessment')
          const OnlineAssessmentPage(),
        if (provider.navString == 'Notes') const NotesPage(),
        if (provider.navString == 'Hostel') const HostelPage(),
        if (provider.navString == 'Leave Application')
          const LeaveApplicationPage(),
        if (provider.navString == 'Registration') const RegistrationPage(),
        if (provider.navString == 'Grievances') const GrievanceReportPage(),
        if (provider.navString == 'Grievance Entry') const GrievanceEntryPage(),
        if (provider.navString == 'Transport') const TransportTransactionPage(),
        if (provider.navString == 'Register') const RegisterPage(),
        if (provider.navString == 'Library') const LibraryPage(),
        if (provider.navString == 'View') const ViewLibraryPage(),
        if (provider.navString == 'Notification') const NotificationPage(),
        if (provider.navString == 'C Programming Language')
          const QuestionPage(),
        if (provider.navString == 'C Programming Language1')
          const NotesDetailsPage(),
        if (provider.navString == 'Hour Attendance') const HourAttendancePage(),
      ],
    );
  }

  Widget _mainCards() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                height: 160,
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
                      const Text(
                        'Academics',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: 160,
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
                      const Text(
                        'LMS',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
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
                height: 160,
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
                      const Text(
                        'Fees',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: 160,
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
                      const Text(
                        'Hostel',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
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
                height: 160,
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
                      const Text(
                        'Notification',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
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
                height: 160,
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
                      const Text(
                        'Grievances',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
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
                height: 160,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
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
                      const Text(
                        'Library',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: 160,
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
                      const Text(
                        'Transport',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallBlackColorFontStyle,
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
