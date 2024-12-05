import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/theme-02/mainscreens/academics/attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/cumulative_attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/exam_details.dart';
import 'package:sample/theme-02/mainscreens/academics/hour_attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/internal_marks.dart';
import 'package:sample/theme-02/mainscreens/academics/subject.dart';
import 'package:sample/theme-02/mainscreens/fees_screen_theme01.dart';
import 'package:sample/theme-02/mainscreens/grievances/grievances_screen.dart';
import 'package:sample/theme-02/mainscreens/library/library_screen.dart';
import 'package:sample/theme_3/grievances/grievances_page.dart';
import 'package:sample/theme_3/hostel/hostel_page_theme.dart';
import 'package:sample/theme_3/lms/lms_home_theme3.dart';
import 'mainscreens/calendar_screen.dart';

class Theme02Homepage extends ConsumerStatefulWidget {
  const Theme02Homepage({super.key});

  @override
  ConsumerState createState() => _Theme02HomepageState();
}

class _Theme02HomepageState extends ConsumerState<Theme02Homepage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
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
          child: AppBar(
            title: Row(
              children: [
                const Text(
                  'Hello, ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  TokensManagement.studentName == ''
                      ? '-'
                      : TokensManagement.studentName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02ExamDetailsPageTheme(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/examdetailstheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Exam Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        // route: const SubjectsHomeTheme3(),
                        route: const Theme02SubjectPage(),
                        // route: const Theme01SubjectPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/subjectstheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Subjects',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02InternalMarksPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.numbers_outlined,
                          size: MediaQuery.of(context).size.height / 12,
                          color: AppColors.whiteColor,
                        ),
                        const Text(
                          'Internal Marks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02HourAttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/hourattendancetheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Hour Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02CumulativeAttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/cumulativeattendancetheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Cumulative Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02AttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/attendancetheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const LMSHomeTheme3(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/lmstheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'LMS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const HostelPageTheme3(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/hosteltheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Hostel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02FeesPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/feestheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Fees',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02GrievanceReportPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/grievancestheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Grievances',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02CalendarPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: MediaQuery.of(context).size.height / 12,
                          color: AppColors.whiteColor,
                        ),
                        const Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme02LibraryPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.theme02primaryColor,
                          AppColors.theme02secondaryColor1,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/librarytheme3.svg',
                          color: AppColors.whiteColor,
                          height: MediaQuery.of(context).size.height / 12,
                        ),
                        const Text(
                          'Library',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  const GradientCard({super.key, required this.data});
  final CardData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.theme02primaryColor,
                    AppColors.theme02secondaryColor1,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
              ),
              child: Center(
                child: Icon(
                  data.icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardData {
  CardData({
    required this.icon,
    required this.title,
    required this.progress,
    required this.progressText,
  });
  final IconData icon;
  final String title;
  final double progress;
  final String progressText;
}
