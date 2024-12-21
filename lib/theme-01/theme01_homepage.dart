// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:hive/hive.dart';
// import 'package:sample/api_token_services/api_tokens_services.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
// import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
// import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
// import 'package:sample/home/main_pages/academics/attendance_pages/model/attendance_hive.dart';
// import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
// import 'package:sample/home/main_pages/academics/cumulative_pages/model/cummulative_attendance_hive.dart';
// import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
// import 'package:sample/home/main_pages/academics/exam_details_pages/model/exam_details_hive_model.dart';
// import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
// import 'package:sample/home/main_pages/academics/hourwise_attendence/hourwise_model.dart/hourwise_hive_model.dart';
// import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';
// import 'package:sample/home/main_pages/academics/internal_marks_pages/model/internal_mark_hive_model.dart';
// import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';
// import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
// import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
// import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
// import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
// import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
// import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
// import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/login/riverpod/login_state.dart';
// import 'package:sample/network/riverpod/network_state.dart';
// import 'package:sample/notification.dart';
// import 'package:sample/theme-01/mainscreens/academics/attendance.dart';
// import 'package:sample/theme-01/mainscreens/academics/cumulative_attendance.dart';
// import 'package:sample/theme-01/mainscreens/academics/exam_details.dart';
// import 'package:sample/theme-01/mainscreens/academics/hour_attendance.dart';
// import 'package:sample/theme-01/mainscreens/academics/internal_marks.dart';
// import 'package:sample/theme-01/mainscreens/academics/subject.dart';
// import 'package:sample/theme-01/mainscreens/calendar_screen.dart';
// import 'package:sample/theme-01/mainscreens/fees_screen_theme01.dart';
// import 'package:sample/theme-01/mainscreens/grievances/grievances_screen.dart';
// import 'package:sample/theme-01/mainscreens/hostel/hostel_screen.dart';
// import 'package:sample/theme-01/mainscreens/library/library_screen.dart';
// import 'package:sample/theme-01/mainscreens/lms/lms_subject_screen.dart';
// import 'package:sample/theme-01/mainscreens/transport/transport_register.dart';
// import 'package:sample/theme-01/mainscreens/transport/transport_screen.dart';

// class Theme01Homepage extends ConsumerStatefulWidget {
//   const Theme01Homepage({super.key});

//   @override
//   ConsumerState createState() => _Theme01HomepageState();
// }

// class _Theme01HomepageState extends ConsumerState<Theme01Homepage>
//     with WidgetsBindingObserver {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       SystemChrome.setSystemUIOverlayStyle(
//         StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
//       );
//     }
//   }

//   final List<Map<String, dynamic>> carouselItems1 = [
//     {
//       'title': 'Exam Details',
//       'image': 'assets/images/Examdetails.png',
//       'route': const Theme01ExamDetailsPage(),
//     },
//     {
//       'title': 'Subject',
//       'image': 'assets/images/subject.png',
//       'route': const Theme01SubjectPage(),
//     },
//     {
//       'title': 'Internal Marks',
//       'image': 'assets/images/internalmark.png',
//       'route': const Theme01InternalMarksPage(),
//     },
//     {
//       'title': 'Attendance',
//       'image': 'assets/images/attendance.png',
//       'route': const Theme01AttendancePage(),
//     },
//     {
//       'title': 'Hour Attendance',
//       'image': 'assets/images/hourwiseattendace.png',
//       'route': const Theme01HourAttendancePage(),
//     },
//     {
//       'title': 'Cumulat Attendance',
//       'image': 'assets/images/Cumulatattendance.png',
//       'route': const Theme01CumulativeAttendancePage(),
//     },
//   ];

//   final List<Map<String, dynamic>> carouselItems2 = [
//     {
//       'title': 'Library',
//       'image': 'assets/images/books.png',
//       'route': const Theme01LibraryPage(),
//     },
//     {
//       'title': 'Fees',
//       'image': 'assets/images/coin.png',
//       'route': const Theme01FeesPage(),
//     },
//     {
//       'title': 'Hostel',
//       'image': 'assets/images/hostelimage.png',
//       'route': const Theme01HostelPage(),
//     },
//     {
//       'title': 'Grievances',
//       'image': 'assets/images/pencil.png',
//       'route': const Theme01GrievanceReportPage(),
//     },
//     {
//       'title': 'Transport',
//       'image': 'assets/images/Bus.png',
//       'route': const Theme01TransportRegisterPage(),
//     },
//     {
//       'title': 'LMS',
//       'image': 'assets/images/LMS.png',
//       'route': const Theme01LmsHomePage(),
//     },
//     {
//       'title': 'Calendar',
//       'image': 'assets/images/calendar.png',
//       'route': const Theme01CalendarPage(),
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _initialProcess();
//     Alerts.checkForAppUpdate(context: context, forcefully: false);
//   }

//   Future<void> _initialProcess() async {
//     await TokensManagement.getStudentId();
//     await ref.read(loginProvider.notifier).getAppVersion();
//     await TokensManagement.getPhoneToken();
//     await TokensManagement.getAppDeviceInfo();
//     await TokensManagement.getTheme();

// //>>>PROFILE

//     final profile = await Hive.openBox<ProfileHiveData>('profile');
//     if (profile.isEmpty) {
//       await ref.read(profileProvider.notifier).getProfileApi(
//             ref.read(
//               encryptionProvider.notifier,
//             ),
//           );
//       await ref.read(profileProvider.notifier).getProfileHive('');
//     }
//     await profile.close();

// //ACADEMICS

// //>>>Attendance
//     final attendance = await Hive.openBox<AttendanceHiveData>(
//       'Attendance',
//     );
//     if (attendance.isEmpty) {
//       await ref.read(attendanceProvider.notifier).getAttendanceDetails(
//             ref.read(
//               encryptionProvider.notifier,
//             ),
//           );
//       await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
//     }
//     await attendance.close();

// //>>>Cummulative Attendance

//     final cummulativeAttendance =
//         await Hive.openBox<CumulativeAttendanceHiveData>(
//       'cumulativeattendance',
//     );
//     if (cummulativeAttendance.isEmpty) {
//       await ref
//           .read(cummulativeAttendanceProvider.notifier)
//           .getCummulativeAttendanceDetails(
//             ref.read(
//               encryptionProvider.notifier,
//             ),
//           );
//       await ref
//           .read(cummulativeAttendanceProvider.notifier)
//           .getHiveCummulativeDetails('');
//     }
//     await cummulativeAttendance.close();

// //>>>Exam Details

//     final examDetails = await Hive.openBox<ExamDetailsHiveData>('examDetails');
//     if (examDetails.isEmpty) {
//       await ref.read(examDetailsProvider.notifier).getExamDetailsApi(
//             ref.read(
//               encryptionProvider.notifier,
//             ),
//           );
//       await ref.read(examDetailsProvider.notifier).getHiveExamDetails('');
//     }
//     await examDetails.close();

//     //>>>Hourwise Attendance

//     final hourwiseAttendance = await Hive.openBox<HourwiseHiveData>(
//       'hourwisedata',
//     );
//     if (hourwiseAttendance.isEmpty) {
//       await ref.read(hourwiseProvider.notifier).gethourwiseDetails(
//             ref.read(
//               encryptionProvider.notifier,
//             ),
//           );
//       await ref.read(hourwiseProvider.notifier).getHiveHourwise('');
//     }
//     await hourwiseAttendance.close();

//     //>>>Internal Marks

//     final internalMarks = await Hive.openBox<InternalMarkHiveData>(
//       'internalmarkdata',
//     );
//     if (internalMarks.isEmpty) {
//       await ref.read(internalMarksProvider.notifier).getInternalMarksDetails(
//             ref.read(
//               encryptionProvider.notifier,
//             ),
//           );
//       await ref.read(internalMarksProvider.notifier).getHiveInternalMarks('');
//     }
//     await internalMarks.close();

//     //>>>Subject

//     final subjects = await Hive.openBox<SubjectHiveData>('subjecthive');
//     if (subjects.isEmpty) {
//       await ref
//           .read(subjectProvider.notifier)
//           .getSubjectDetails(ref.read(encryptionProvider.notifier));
//       await ref.read(subjectProvider.notifier).getHiveSubjectDetails('');
//     }
//     await subjects.close();

//     //GRIEVANCES

//     final grievanceCategoryData = await Hive.openBox<GrievanceCategoryHiveData>(
//       'grievanceCategoryData',
//     );
//     if (grievanceCategoryData.isEmpty) {
//       await ref.read(grievanceProvider.notifier).getGrievanceCategoryDetails(
//             ref.read(encryptionProvider.notifier),
//           );
//       await ref
//           .read(grievanceProvider.notifier)
//           .getHiveGrievanceCategoryDetails('');
//     }
//     await grievanceCategoryData.close();

//     final grievanceSubTypeData = await Hive.openBox<GrievanceSubTypeHiveData>(
//       'grievanceSubTypeData',
//     );
//     if (grievanceSubTypeData.isEmpty) {
//       await ref.read(grievanceProvider.notifier).getGrievanceSubTypeDetails(
//             ref.read(encryptionProvider.notifier),
//           );
//       await ref
//           .read(grievanceProvider.notifier)
//           .getHiveGrievanceSubTypeDetails('');
//     }
//     await grievanceSubTypeData.close();

//     final grievanceTypeData = await Hive.openBox<GrievanceTypeHiveData>(
//       'grievanceTypeData',
//     );
//     if (grievanceTypeData.isEmpty) {
//       await ref.read(grievanceProvider.notifier).getGrievanceTypeDetails(
//             ref.read(encryptionProvider.notifier),
//           );
//       await ref
//           .read(grievanceProvider.notifier)
//           .getHiveGrievanceTypeDetails('');
//     }
//     await grievanceTypeData.close();
//   }

//   Future<void> showNotification(RemoteMessage message) async {
//     await AppNotification.createNotification(
//       title: message.notification?.title ?? '',
//       body: message.notification?.body ?? '',
//       networkImagePath: message.data['image'] as String?,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = ref.watch(profileProvider);
//     ref
//       ..listen(networkProvider, (previous, next) {
//         if (previous!.connectivityResult == ConnectivityResult.none &&
//             next.connectivityResult != ConnectivityResult.none) {}
//       })
//       ..listen(changePasswordProvider, (previous, next) {
//         if (next is ChangePasswordStateSuccessful) {
//           if (next.message == 'Password Changed Successfuly') {
//             _showToast(context, next.message, AppColors.greenColor);
//           } else {
//             _showToast(context, next.message, AppColors.redColor);
//           }
//         } else if (next is ChangePasswordStateError) {
//           _showToast(context, next.message, AppColors.redColor);
//         }
//       });
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: AppColors.theme01secondaryColor4,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Column(
//                   children: [
//                     const SizedBox(height: 60),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 30,
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Hello, ',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.theme01primaryColor,
//                             ),
//                           ),
//                           // Text(
//                           //   '${provider.profileDataHive.studentname}' == ''
//                           //       ? '-'
//                           //       : '${provider.profileDataHive.studentname}',
//                           //   style: TextStyle(
//                           //     fontSize: 20,
//                           //     fontWeight: FontWeight.bold,
//                           //     color: AppColors.theme01primaryColor,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         left: 30,
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             'Welcome to ',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.theme01primaryColor,
//                             ),
//                           ),
//                           Text(
//                             'SRM Portal',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.theme01primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.theme01primaryColor,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 20,
//                           vertical: 10,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Text(
//                                 'Academics',
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.theme01secondaryColor1,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 125,
//                                 enlargeCenterPage: true,
//                                 autoPlay: true,
//                                 scrollDirection: Axis.vertical,
//                                 autoPlayInterval: const Duration(seconds: 3),
//                               ),
//                               items: carouselItems1.map((item) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             item['route'] as Widget,
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     margin: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(15),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.shade300,
//                                           blurRadius: 5,
//                                           offset: const Offset(0, 3),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8),
//                                           child: Image.asset(
//                                             item['image']! as String,
//                                             height: 35,
//                                             width: 35,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 10),
//                                         Text(
//                                           item['title']! as String,
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold,
//                                             color:
//                                                 AppColors.theme01primaryColor,
//                                           ),
//                                         ),
//                                         const SizedBox(width: 15),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: AppColors.theme01primaryColor,
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 30,
//                           vertical: 25,
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Center(
//                               child: Text(
//                                 'Others',
//                                 style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.theme01secondaryColor1,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 150,
//                                 enlargeCenterPage: true,
//                                 // autoPlay: true,
//                                 autoPlayInterval: const Duration(seconds: 3),
//                               ),
//                               items: carouselItems2.map((item) {
//                                 return GestureDetector(
//                                   onTap: () {
//                                     // Navigate to the specified route
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             item['route'] as Widget,
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     margin: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(15),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.shade300,
//                                           blurRadius: 5,
//                                           offset: const Offset(0, 3),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Column(
//                                       children: [
//                                         const SizedBox(height: 20),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8),
//                                           child: Image.asset(
//                                             item['image']! as String,
//                                             height: 50,
//                                             width: 300,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 10),
//                                         Text(
//                                           item['title']! as String,
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.bold,
//                                             color:
//                                                 AppColors.theme01primaryColor,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       drawer: const DrawerDesign(),
//     );
//   }

//   void _showToast(BuildContext context, String message, Color color) {
//     showToast(
//       message,
//       context: context,
//       backgroundColor: color,
//       axis: Axis.horizontal,
//       alignment: Alignment.centerLeft,
//       position: StyledToastPosition.center,
//       borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(15),
//         bottomLeft: Radius.circular(15),
//       ),
//       toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
//     );
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/alerts_design.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/navigation_style.dart';
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
import 'package:sample/home/main_pages/academics/subject_pages/model/subject_responce_hive_model.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme-01/drawer_page/change_password_theme01.dart';
import 'package:sample/theme-01/drawer_page/theme01_profile_screen.dart';
import 'package:sample/theme-01/mainscreens/academics/attendance.dart';
import 'package:sample/theme-01/mainscreens/academics/cumulative_attendance.dart';
import 'package:sample/theme-01/mainscreens/academics/exam_details.dart';
import 'package:sample/theme-01/mainscreens/academics/hour_attendance.dart';
import 'package:sample/theme-01/mainscreens/academics/internal_marks.dart';
import 'package:sample/theme-01/mainscreens/academics/subject.dart';
import 'package:sample/theme-01/mainscreens/calendar_screen.dart';
import 'package:sample/theme-01/mainscreens/fees_screen_theme01.dart';
import 'package:sample/theme-01/mainscreens/grievances/grievances_screen.dart';
import 'package:sample/theme-01/mainscreens/hostel/hostel_register.dart';
import 'package:sample/theme-01/mainscreens/library/library_screen.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_subject_screen.dart';
import 'package:sample/theme-01/mainscreens/transport/transport_register.dart';
import 'package:sample/theme-02/login/theme02_login_screen.dart';

class Theme01Homepage extends ConsumerStatefulWidget {
  const Theme01Homepage({super.key});

  @override
  ConsumerState createState() => _Theme01HomepageState();
}

class _Theme01HomepageState extends ConsumerState<Theme01Homepage>
    with WidgetsBindingObserver {
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

//>>>PROFILE

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

//ACADEMICS

//>>>Attendance
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

    final cummulativeAttendance =
        await Hive.openBox<CumulativeAttendanceHiveData>(
      'cumulativeattendance',
    );
    if (cummulativeAttendance.isEmpty) {
      await ref
          .read(cummulativeAttendanceProvider.notifier)
          .getCummulativeAttendanceDetails(
            ref.read(
              encryptionProvider.notifier,
            ),
          );
      await ref
          .read(cummulativeAttendanceProvider.notifier)
          .getHiveCummulativeDetails('');
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
      await ref
          .read(subjectProvider.notifier)
          .getSubjectDetails(ref.read(encryptionProvider.notifier));
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
      await ref
          .read(grievanceProvider.notifier)
          .getHiveGrievanceCategoryDetails('');
    }
    await grievanceCategoryData.close();

    final grievanceSubTypeData = await Hive.openBox<GrievanceSubTypeHiveData>(
      'grievanceSubTypeData',
    );
    if (grievanceSubTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceSubTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref
          .read(grievanceProvider.notifier)
          .getHiveGrievanceSubTypeDetails('');
    }
    await grievanceSubTypeData.close();

    final grievanceTypeData = await Hive.openBox<GrievanceTypeHiveData>(
      'grievanceTypeData',
    );
    if (grievanceTypeData.isEmpty) {
      await ref.read(grievanceProvider.notifier).getGrievanceTypeDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref
          .read(grievanceProvider.notifier)
          .getHiveGrievanceTypeDetails('');
    }
    await grievanceTypeData.close();
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
    final height = MediaQuery.of(context).size.height;
    // final provider = ref.watch(transportProvider);
    // log(provider.transportAfterRegisterDetails!.regconfig)
    return Scaffold(
      backgroundColor: AppColors.theme01primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        // ignore: use_colored_box
        child: Container(
          color: AppColors.theme01secondaryColor4,
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Home',
              style: TextStyles.fontStyle01theme,
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
                        route: const Theme01ExamDetailsPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Exam Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01SubjectPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Subjects',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01InternalMarksPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                        ),
                        Text(
                          'Internal Marks',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01HourAttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Hour Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01CumulativeAttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Cumulative Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01AttendancePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01LmsHomePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'LMS',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01RegistrationPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Hostel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01FeesPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Fees',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01GrievanceReportPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Grievances',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01CalendarPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                        ),
                        Text(
                          'Calendar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01LibraryPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
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
                          color: AppColors.theme01primaryColor,
                          height: MediaQuery.of(context).size.height / 16,
                        ),
                        Text(
                          'Library',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // if (provider.transportAfterRegisterDetails!.regconfig == '1')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme01TransportRegisterPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.emoji_transportation,
                          size: MediaQuery.of(context).size.height / 12,
                          color: AppColors.theme01primaryColor,
                        ),
                        Text(
                          'Transport',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
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
                        route: const Theme01ChangePasswordPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
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
                          Icons.password,
                          size: MediaQuery.of(context).size.height / 12,
                          color: AppColors.theme01primaryColor,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 160,
                //   width: MediaQuery.of(context).size.width / 2.5,
                //   padding: const EdgeInsets.all(15),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            // if (provider.transportAfterRegisterDetails!.regconfig == '1')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const Theme01ProfilePage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: MediaQuery.of(context).size.height / 12,
                          color: AppColors.theme01primaryColor,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(mainProvider.notifier).setNavString('Logout');
                    TokensManagement.clearSharedPreference();
                    Navigator.pushAndRemoveUntil(
                      context,
                      RouteDesign(
                        route: const Theme02LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: Container(
                    height: 160,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.whiteColor,
                          AppColors.whiteColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.logout,
                          size: MediaQuery.of(context).size.height / 12,
                          color: AppColors.theme01primaryColor,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme01primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   height: 160,
                //   width: MediaQuery.of(context).size.width / 2.5,
                //   padding: const EdgeInsets.all(15),
                // ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  const GradientCard({required this.data, super.key});
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
                    AppColors.theme01secondaryColor4,
                    AppColors.theme01secondaryColor4,
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
                  color: AppColors.loadingWrapperColor,
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
