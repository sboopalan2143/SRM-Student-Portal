// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:sample/api_token_services/api_tokens_services.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
// import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
// import 'package:sample/home/main_pages/academics/screens/academics.dart';
// import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
// import 'package:sample/home/main_pages/fees/screens/fees.dart';
// import 'package:sample/home/main_pages/grievances/screens/grievances.dart';
// import 'package:sample/home/main_pages/hostel/screens/hostel.dart';
// import 'package:sample/home/main_pages/library/screens/library.dart';
// import 'package:sample/home/main_pages/lms/screens/lms.dart';
// import 'package:sample/home/main_pages/notification/screens/notification.dart';
// import 'package:sample/home/main_pages/transport/screens/transport.dart';
// import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/login/riverpod/login_state.dart';
// import 'package:sample/login/screen/login_Page2.dart';
// import 'package:sample/network/riverpod/network_state.dart';
// import 'package:sample/notification.dart';

// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});

//   @override
//   ConsumerState createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage>
//     with WidgetsBindingObserver {
//

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       SystemChrome.setSystemUIOverlayStyle(
//         StatusBarNavigationBarDesigns.statusBarNavigationBarDesign,
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _initialProcess();
//     Alerts.checkForAppUpdate(context: context, forcefully: false);

//     /// Remove the command line after firebase setup
//     // FirebaseMessaging.onMessage.listen(showNotification);
//   }

//   Future<void> _initialProcess() async {
//     await TokensManagement.getStudentId();
//     await ref.read(loginProvider.notifier).getAppVersion();

//     /// Remove the command line after firebase setup
//     await TokensManagement.getPhoneToken();
//     await TokensManagement.getAppDeviceInfo();
//     try {
//       await ref.read(profileProvider.notifier).getProfileDetails(
//             ref.read(
//               encryptionProvider.notifier,
//             ),
//           );
//     } catch (e) {
//       await TokensManagement.clearSharedPreference();
//       // ignore: use_build_context_synchronously
//       await Navigator.pushAndRemoveUntil(
//         context,
//         RouteDesign(route: const LoginPage2()),
//         (route) => false,
//       );
//     }
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
//     ref
//       ..listen(networkProvider, (previous, next) {
//         if (previous!.connectivityResult == ConnectivityResult.none &&
//             next.connectivityResult != ConnectivityResult.none) {
//           /// Handle offline to online function calls
//         }
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
//
//       backgroundColor: AppColors.secondaryColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: AppColors.primaryColor,
//           centerTitle: true,
//           title: const Text(
//             'HOME',
//             style: TextStyles.fontStyle4,
//             overflow: TextOverflow.clip,
//           ),
//           actions: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//
//                   },
//                   icon: const Icon(
//                     Icons.menu,
//                     size: 35,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(child: _mainBody()),
//       endDrawer: const DrawerDesign(),
//     );
//   }

//   Widget _mainBody() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const SizedBox(
//           height: 10,
//         ),
//         _mainCards(),
//       ],
//     );
//   }

//   Widget _mainCards() {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;

//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           SizedBox(
//             height: height * 0.025,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const AcademicsPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/academics.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'Academics',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: width * 0.06,
//               ),
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const NotificationPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/Notification.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'Notification',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: height * 0.025,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: () {
//                     ref
//                         .read(feesProvider.notifier)
//                         .setFeesNavString('Online Trans');
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const FeesPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/fees.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'Fees',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: width * 0.06,
//               ),
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const HostelPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/hostel.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'Hostel',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: height * 0.025,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const LMSPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/LMS.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'LMS',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                       // SizedBox(
//                       //   height: height * 0.027,
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: width * 0.06,
//               ),
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const LibraryPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/library.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'Library',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: height * 0.025,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: ()  {

//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const GrievanceReportPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/grievances.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'Grievances',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: width * 0.06,
//               ),
//               SizedBox(
//                 height: 140,
//                 width: width * 0.40,
//                 child: ElevatedButton(
//                   style: BorderBoxButtonDecorations.homePageButtonStyle,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       RouteDesign(
//                         route: const TransportTransactionPage(),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SizedBox(
//                         child: Image.asset(
//                           'assets/images/transport.png',
//                           height: 80,
//                         ),
//                       ),
//                       SizedBox(
//                         height: height * 0.006,
//                       ),
//                       Text(
//                         'Transport',
//                         textAlign: TextAlign.center,
//                         style: width > 400
//                             ? TextStyles.smallBlackColorFontStyle
//                             : TextStyles.smallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
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
