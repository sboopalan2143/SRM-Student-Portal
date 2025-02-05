// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:hive/hive.dart';
// import 'package:sample/api_token_services/api_tokens_services.dart';
// import 'package:sample/designs/alerts_design.dart';
// import 'package:sample/designs/colors.dart';
// import 'package:sample/designs/navigation_style.dart';
// import 'package:sample/encryption/encryption_state.dart';
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
// import 'package:sample/home/riverpod/main_state.dart';
// import 'package:sample/login/riverpod/login_state.dart';
// import 'package:sample/notification.dart';
// import 'package:sample/theme-02/drawer_page/change_password_theme02.dart';
// import 'package:sample/theme-02/mainscreens/fees/fees_home_page.dart';
// import 'package:sample/theme-02/drawer_page/theme02_profile_screen.dart';
// import 'package:sample/theme-02/login/theme02_login_screen.dart';
// import 'package:sample/theme-02/mainscreens/academics/attendance_home_page.dart';
// import 'package:sample/theme-02/mainscreens/academics/internal_marks.dart';
// import 'package:sample/theme-02/mainscreens/academics_home_page.dart';
// import 'package:sample/theme-02/mainscreens/calendar_home_page_screen.dart';
// import 'package:sample/theme-02/mainscreens/grade_home_screen.dart';
// import 'package:sample/theme-02/mainscreens/grievances/grievances_home_page.dart';
// import 'package:sample/theme-02/mainscreens/hostel/hostel_home_page.dart';
// import 'package:sample/theme-02/mainscreens/library/library_home_screen.dart';
// import 'package:sample/theme-02/mainscreens/transport/transport_register.dart';
//
// class Theme02Homepage extends ConsumerStatefulWidget {
//   const Theme02Homepage({super.key});
//
//   @override
//   ConsumerState createState() => _Theme02HomepageState();
// }
//
// class _Theme02HomepageState extends ConsumerState<Theme02Homepage>
//     with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     _initialProcess();
//     Alerts.checkForAppUpdate(context: context, forcefully: false);
//   }
//
//   Future<void> _initialProcess() async {
//     await TokensManagement.getStudentId();
//     await ref.read(loginProvider.notifier).getAppVersion();
//     await TokensManagement.getPhoneToken();
//     await TokensManagement.getAppDeviceInfo();
//     await TokensManagement.getTheme();
//
// //>>>PROFILE
//
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
//
// //ACADEMICS
//
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
//
// //>>>Cummulative Attendance
//
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
//
// //>>>Exam Details
//
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
//
// //>>>Hourwise Attendance
//
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
//
// //>>>Internal Marks
//
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
//
// //>>>Subject
//
//     final subjects = await Hive.openBox<SubjectHiveData>('subjecthive');
//     if (subjects.isEmpty) {
//       await ref
//           .read(subjectProvider.notifier)
//           .getSubjectDetails(ref.read(encryptionProvider.notifier));
//       await ref.read(subjectProvider.notifier).getHiveSubjectDetails('');
//     }
//     await subjects.close();
//
//     //GRIEVANCES
//
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
//
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
//
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
//
//   Future<void> showNotification(RemoteMessage message) async {
//     await AppNotification.createNotification(
//       title: message.notification?.title ?? '',
//       body: message.notification?.body ?? '',
//       networkImagePath: message.data['image'] as String?,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     // final provider = ref.watch(transportProvider);
//     // log(provider.transportAfterRegisterDetails!.regconfig)
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 AppColors.theme02primaryColor,
//                 AppColors.theme02secondaryColor1,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             title: const Text(
//               'Home',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: height * 0.05),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const Theme02ProfilePage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(
//                       15,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(
//                           Icons.account_circle,
//                           size: MediaQuery.of(context).size.height / 12,
//                           color: AppColors.whiteColor,
//                         ),
//                         const Text(
//                           'Profile',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         // route: const Theme02CalendarPage(),
//                         // route: const CalendarHomePage(),
//                         route: const FeesDetailsHomePage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(
//                       15,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(
//                           Icons.monetization_on,
//                           size: MediaQuery.of(context).size.height / 12,
//                           color: AppColors.whiteColor,
//                         ),
//                         const Text(
//                           'Fees Details',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         // route: const Theme02CumulativeAttendancePage(),
//                         route: const AcademicsHomePage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(
//                       15,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/cumulativeattendancetheme3.svg',
//                           color: AppColors.whiteColor,
//                           height: MediaQuery.of(context).size.height / 16,
//                         ),
//                         const Text(
//                           'Academics',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const LibraryHomePage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/librarytheme3.svg',
//                           color: AppColors.whiteColor,
//                           height: MediaQuery.of(context).size.height / 16,
//                         ),
//                         const Text(
//                           'Library',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const HostelHomePage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(
//                       15,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/hosteltheme3.svg',
//                           color: AppColors.whiteColor,
//                           height: MediaQuery.of(context).size.height / 16,
//                         ),
//                         const Text(
//                           'Hostel',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const Theme02TransportRegisterPage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(
//                       15,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(
//                           Icons.emoji_transportation,
//                           size: MediaQuery.of(context).size.height / 12,
//                           color: AppColors.whiteColor,
//                         ),
//                         const Text(
//                           'Transport',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         // route: const Theme02GrievanceReportPage(),
//                         route: const GrievanceHomePage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(
//                       15,
//                     ),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/images/grievancestheme3.svg',
//                           color: AppColors.whiteColor,
//                           height: MediaQuery.of(context).size.height / 16,
//                         ),
//                         const Text(
//                           'Grievances',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const Theme02ChangePasswordPage(),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(
//                           Icons.password,
//                           size: MediaQuery.of(context).size.height / 12,
//                           color: AppColors.whiteColor,
//                         ),
//                         const Text(
//                           'Change Password',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     ref.read(mainProvider.notifier).setNavString('Logout');
//                     TokensManagement.clearSharedPreference();
//
//                     // Navigator.pushAndRemoveUntil(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (context) => const AddUser()));
//
//                     Navigator.pushAndRemoveUntil(
//                       context,
//                       RouteDesign(
//                         route: const Theme02LoginScreen(),
//                       ),
//                       (route) => false,
//                     );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(15),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.theme02primaryColor,
//                           AppColors.theme02secondaryColor1,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                       borderRadius: const BorderRadius.all(
//                         Radius.circular(
//                           20,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Icon(
//                           Icons.logout,
//                           size: MediaQuery.of(context).size.height / 12,
//                           color: AppColors.whiteColor,
//                         ),
//                         const Text(
//                           'Logout',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.whiteColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // Navigator.push(
//                     //   context,
//                     //   RouteDesign(
//                     //     // route: const Theme02CalendarPage(),
//                     //     route: const CalendarHomePage(),
//                     //   ),
//                     // );
//                   },
//                   child: Container(
//                     height: 160,
//                     width: MediaQuery.of(context).size.width / 2.5,
//                     padding: const EdgeInsets.all(
//                       15,
//                     ),
//                     // decoration: BoxDecoration(
//                     //   gradient: LinearGradient(
//                     //     colors: [
//                     //       AppColors.theme02primaryColor,
//                     //       AppColors.theme02secondaryColor1,
//                     //     ],
//                     //     begin: Alignment.topCenter,
//                     //     end: Alignment.bottomCenter,
//                     //   ),
//                     //   borderRadius: const BorderRadius.all(
//                     //     Radius.circular(
//                     //       20,
//                     //     ),
//                     //   ),
//                     // ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class GradientCard extends StatelessWidget {
//   const GradientCard({super.key, required this.data});
//
//   final CardData data;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(5),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 4,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.theme02primaryColor,
//                     AppColors.theme02secondaryColor1,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(15)),
//               ),
//               child: Center(
//                 child: Icon(
//                   data.icon,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CardData {
//   CardData({
//     required this.icon,
//     required this.title,
//     required this.progress,
//     required this.progressText,
//   });
//
//   final IconData icon;
//   final String title;
//   final double progress;
//   final String progressText;
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/alerts_design.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/drawer_pages/profile/screens/profile_page.dart';
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
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20details%20riverpod/lms_content_details_state.dart';
import 'package:sample/home/main_pages/transport/screens/register.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/riverpod/login_state.dart';
import 'package:sample/notification.dart';
import 'package:sample/theme-02/drawer_page/change_password_theme02.dart';
import 'package:sample/theme-02/mainscreens/fees/fees_home_page.dart';
import 'package:sample/theme-02/drawer_page/theme02_profile_screen.dart';
import 'package:sample/theme-02/login/theme02_login_screen.dart';
import 'package:sample/theme-02/mainscreens/academics/attendance_home_page.dart';
import 'package:sample/theme-02/mainscreens/academics/internal_marks.dart';
import 'package:sample/theme-02/mainscreens/academics_home_page.dart';
import 'package:sample/theme-02/mainscreens/calendar_home_page_screen.dart';
import 'package:sample/theme-02/mainscreens/grade_home_screen.dart';
import 'package:sample/theme-02/mainscreens/grievances/grievances_home_page.dart';
import 'package:sample/theme-02/mainscreens/hostel/hostel_home_page.dart';
import 'package:sample/theme-02/mainscreens/library/library_home_screen.dart';
import 'package:sample/theme-02/mainscreens/transport/transport_register.dart';

class Theme02Homepage extends ConsumerStatefulWidget {
  const Theme02Homepage({super.key});

  @override
  ConsumerState createState() => _Theme02HomepageState();
}

class _Theme02HomepageState extends ConsumerState<Theme02Homepage>
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
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              SizedBox(height: height * 0.03),
              // First Row
              buildIconRow(context, [
                _CardData(
                  icon: Icons.account_circle,
                  title: 'Profile',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Theme02ProfilePage(),
                      ),
                    );
                  },
                ),
                _CardData(
                  icon: Icons.monetization_on,
                  title: 'Fees',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeesDetailsHomePage(),
                      ),
                    );
                  },
                ),
                _CardData(
                  icon: Icons.school,
                  title: 'Academics',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AcademicsHomePage(),
                      ),
                    );
                  },
                ),
              ]),
              const SizedBox(height: 20),
              // Second Row
              buildIconRow(context, [
                _CardData(
                  icon: Icons.library_books,
                  title: 'Library',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LibraryHomePage(),
                      ),
                    );
                  },
                ),
                _CardData(
                  icon: Icons.house,
                  title: 'Hostel',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HostelHomePage(),
                      ),
                    );
                  },
                ),
                _CardData(
                  icon: Icons.emoji_transportation,
                  title: 'Transport',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Theme02TransportRegisterPage(),
                      ),
                    );
                  },
                ),
              ]),
              const SizedBox(height: 20),
              // Third Row
              buildIconRow(context, [
                _CardData(
                  icon: Icons.feedback,
                  title: 'Grievances',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GrievanceHomePage(),
                      ),
                    );
                  },
                ),
                _CardData(
                  icon: Icons.password,
                  title: 'Password',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Theme02ChangePasswordPage(),
                      ),
                    );
                  },
                ),
                _CardData(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    ref.read(mainProvider.notifier).setNavString('Logout');
                    TokensManagement.clearSharedPreference();

                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const AddUser()));

                    Navigator.pushAndRemoveUntil(
                      context,
                      RouteDesign(
                        route: const Theme02LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconRow(BuildContext context, List<_CardData> cards) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cards.map((cardData) {
        return Expanded(
          child: GestureDetector(
            onTap: cardData.onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.theme02primaryColor,
                    AppColors.theme02secondaryColor1,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    cardData.icon,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cardData.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _CardData {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  _CardData({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}

// class AppColors {
//   static const Color theme02primaryColor = Color(0xFF6A1B9A);
//   static const Color theme02secondaryColor1 = Color(0xFFAB47BC);
//   static const Color whiteColor = Colors.white;
// }

// class GradientCard extends StatelessWidget {
//   const GradientCard({super.key, required this.data});
//
//   final CardData data;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(5),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 4,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.theme02primaryColor,
//                     AppColors.theme02secondaryColor1,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(15)),
//               ),
//               child: Center(
//                 child: Icon(
//                   data.icon,
//                   size: 40,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CardData {
//   CardData({
//     required this.icon,
//     required this.title,
//     required this.progress,
//     required this.progressText,
//   });
//
//   final IconData icon;
//   final String title;
//   final double progress;
//   final String progressText;
// }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class Theme02Homepage extends StatelessWidget {
//   const Theme02Homepage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 AppColors.theme02primaryColor,
//                 AppColors.theme02secondaryColor1,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: AppBar(
//             automaticallyImplyLeading: false,
//             centerTitle: true,
//             title: const Text(
//               'Home',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             children: [
//               SizedBox(height: height * 0.03),
//               // First Row
//               buildIconRow(context, [
//                 _CardData(
//                   icon: Icons.account_circle,
//                   title: 'Profile',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ProfilePage(),
//                       ),
//                     );
//                   },
//                 ),
//                 _CardData(
//                   icon: Icons.monetization_on,
//                   title: 'Fees',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const FeesDetailsHomePage(),
//                       ),
//                     );
//                   },
//                 ),
//                 _CardData(
//                   icon: Icons.school,
//                   title: 'Academics',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const AcademicsHomePage(),
//                       ),
//                     );
//                   },
//                 ),
//               ]),
//               const SizedBox(height: 20),
//               // Second Row
//               buildIconRow(context, [
//                 _CardData(
//                   icon: Icons.library_books,
//                   title: 'Library',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const LibraryHomePage(),
//                       ),
//                     );
//                   },
//                 ),
//                 _CardData(
//                   icon: Icons.house,
//                   title: 'Hostel',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const HostelHomePage(),
//                       ),
//                     );
//                   },
//                 ),
//                 _CardData(
//                   icon: Icons.emoji_transportation,
//                   title: 'Transport',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const TransportRegisterPage(),
//                       ),
//                     );
//                   },
//                 ),
//               ]),
//               const SizedBox(height: 20),
//               // Third Row
//               buildIconRow(context, [
//                 _CardData(
//                   icon: Icons.feedback,
//                   title: 'Grievances',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const GrievanceHomePage(),
//                       ),
//                     );
//                   },
//                 ),
//                 _CardData(
//                   icon: Icons.password,
//                   title: 'Change Password',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const ChangePasswordPage(),
//                       ),
//                     );
//                   },
//                 ),
//                 _CardData(
//                   icon: Icons.logout,
//                   title: 'Logout',
//                   onTap: () {
//                     // Add your logout logic
//                   },
//                 ),
//               ]),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildIconRow(BuildContext context, List<_CardData> cards) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: cards.map((cardData) {
//         return Expanded(
//           child: GestureDetector(
//             onTap: cardData.onTap,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.theme02primaryColor,
//                     AppColors.theme02secondaryColor1,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     cardData.icon,
//                     size: 40,
//                     color: Colors.white,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     cardData.title,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
//
// class _CardData {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//
//   _CardData({
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });
// }
//
// class AppColors {
//   static const Color theme02primaryColor = Color(0xFF6A1B9A);
//   static const Color theme02secondaryColor1 = Color(0xFFAB47BC);
//   static const Color whiteColor = Colors.white;
// }
