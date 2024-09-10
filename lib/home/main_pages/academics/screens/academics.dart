import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/screens/attendance.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/screens/cumulative_attendance.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/screens/exam_details.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/screens/hourwise_page.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/screens/internal_marks.dart';
import 'package:sample/home/main_pages/academics/subject_pages/screens/subject_page.dart';
import 'package:sample/home/screen/home_page.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class AcademicsPage extends ConsumerStatefulWidget {
  const AcademicsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends ConsumerState<AcademicsPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                RouteDesign(
                  route: const HomePage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text(
            'ACADEMICS',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
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
      body: Padding(
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
                  height: height * 0.15,
                  width: width * 0.40,
                  child: ElevatedButton(
                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: const ExamDetailsPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Exam Details',
                      textAlign: TextAlign.center,
                      style: width > 400
                          ? TextStyles.fontStyle6
                          : TextStyles.fontStyle8,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.06,
                ),
                SizedBox(
                  height: height * 0.15,
                  width: width * 0.40,
                  child: ElevatedButton(
                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: const SubjectPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Subjects',
                      textAlign: TextAlign.center,
                      style: width > 400
                          ? TextStyles.fontStyle6
                          : TextStyles.fontStyle8,
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
                  height: height * 0.15,
                  width: width * 0.40,
                  child: ElevatedButton(
                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: const InternalMarksPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Internal Marks',
                      textAlign: TextAlign.center,
                      style: width > 400
                          ? TextStyles.fontStyle6
                          : TextStyles.fontStyle8,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.06,
                ),
                SizedBox(
                  height: height * 0.15,
                  width: width * 0.40,
                  child: ElevatedButton(
                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: const AttendancePage(),
                        ),
                      );
                    },
                    child: Text(
                      'Attendance',
                      textAlign: TextAlign.center,
                      style: width > 400
                          ? TextStyles.fontStyle6
                          : TextStyles.fontStyle8,
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
                  height: height * 0.15,
                  width: width * 0.40,
                  child: ElevatedButton(
                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: const HourAttendancePage(),
                        ),
                      );
                    },
                    child: Text(
                      'Hour Attendance',
                      textAlign: TextAlign.center,
                      style: width > 400
                          ? TextStyles.fontStyle6
                          : TextStyles.fontStyle8,
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.06,
                ),
                SizedBox(
                  height: height * 0.15,
                  width: width * 0.40,
                  child: ElevatedButton(
                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                    onPressed: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: const CumulativeAttendancePage(),
                        ),
                      );
                    },
                    child: Text(
                      'Cumulative Attendance',
                      textAlign: TextAlign.center,
                      style: width > 400
                          ? TextStyles.fontStyle6
                          : TextStyles.fontStyle8,
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
                // SizedBox(
                //   height: height * 0.15,
                //   width: width * 0.40,
                //   child: ElevatedButton(
                //     style: BorderBoxButtonDecorations.homePageButtonStyle,
                //     onPressed: () {
                //       ref.read(mainProvider.notifier).setNavString
                // ('Timetable');
                //     },
                //     child: Text(
                //       'Timetable',
                //       textAlign: TextAlign.center,
                //       style: width > 400
                //           ? TextStyles.fontStyle6
                //           : TextStyles.fontStyle8,
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: width * 0.06,
                ),
                SizedBox(
                  height: height * 0.15,
                  width: width * 0.40,
                  child: const Text(
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }
}
