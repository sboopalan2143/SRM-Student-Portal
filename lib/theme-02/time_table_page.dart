import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';

//
// // class Theme02TimetablePageScreen extends ConsumerStatefulWidget {
// //   const Theme02TimetablePageScreen({super.key});
// //
// //   @override
// //   ConsumerState<ConsumerStatefulWidget> createState() =>
// //       _Theme02TimetablePageScreenState();
// // }
// //
// // class _Theme02TimetablePageScreenState
// //     extends ConsumerState<Theme02TimetablePageScreen> {
// //   final ScrollController _listController = ScrollController();
// //
// //   final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
// //       GlobalKey<LiquidPullToRefreshState>();
// //
// //   static int refreshNum = 10;
// //   Stream<int> counterStream =
// //       Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);
// //
// //   Future<void> _handleRefresh() async {
// //     WidgetsBinding.instance.addPostFrameCallback(
// //       (_) async {
// //         await ref
// //             .read(timetableProvider.notifier)
// //             .getTimeTableDetails(ref.read(encryptionProvider.notifier));
// //       },
// //     );
// //
// //     final completer = Completer<void>();
// //     Timer(const Duration(seconds: 1), completer.complete);
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback(
// //       (_) async {
// //         await ref
// //             .read(timetableProvider.notifier)
// //             .getTimeTableDetails(ref.read(encryptionProvider.notifier));
// //       },
// //     );
// //   }
// //
// //   Widget cardDesign(int index) {
// //     final width = MediaQuery.of(context).size.width;
// //     final provider = ref.watch(timetableProvider);
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 25),
// //       child: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               AppColors.theme02primaryColor,
// //               AppColors.theme02secondaryColor1,
// //             ],
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //           ),
// //           borderRadius: BorderRadius.circular(20),
// //         ),
// //         child: Padding(
// //           padding: const EdgeInsets.all(20),
// //           child: Column(
// //             children: [
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   Expanded(
// //                     // width: width / 2 - 60,
// //                     child: Row(
// //                       children: [
// //                         SizedBox(
// //                           width: 15,
// //                           child: Icon(
// //                             Icons.calendar_month,
// //                             color: AppColors.theme02buttonColor2,
// //                           ),
// //                         ),
// //                         const SizedBox(width: 20),
// //                         Expanded(
// //                           child: Text(
// //                             '${provider.timeTableData[index].dayorderdesc}' ==
// //                                     ''
// //                                 ? '-'
// //                                 : '${provider.timeTableData[index].dayorderdesc}',
// //                             style: TextStyle(
// //                               fontSize: 25,
// //                               color:
// //                                   provider.timeTableData[index].dayorderdesc ==
// //                                           '0'
// //                                       ? AppColors.whiteColor
// //                                       : AppColors.whiteColor,
// //                               fontWeight: FontWeight.bold,
// //                             ),
// //                           ),
// //                         ),
// //                         // Expanded(
// //                         //   child: Text(
// //                         //     // Check if the date matches today
// //                         // provider.calendarCurrentDateData[index].date ==
// //                         //         DateTime.now().day.toString()
// //                         //     ? '${provider.calendarCurrentDateData[index].date}'
// //                         //     : '-', // Show '-' if it is not today's date
// //                         //     style: TextStyle(
// //                         //       fontSize: 25,
// //                         //       color: provider.calendarCurrentDateData[index]
// //                         //                   .holidaystatus ==
// //                         //               '0'
// //                         //           ? AppColors.whiteColor
// //                         //           : AppColors.whiteColor,
// //                         //       fontWeight: FontWeight.bold,
// //                         //     ),
// //                         //   ),
// //                         // ),
// //                       ],
// //                     ),
// //                   ),
// //                   // SizedBox(
// //                   //   // width: width / 2 - 60,
// //                   //   child: Text(
// //                   //     '${provider.calendarCurrentDateData[index].daystatus}' ==
// //                   //             ''
// //                   //         ? '-'
// //                   //         : '${provider.calendarCurrentDateData[index].daystatus}',
// //                   //     style: TextStyle(
// //                   //       fontSize: 20,
// //                   //       color: provider.calendarCurrentDateData[index]
// //                   //                   .holidaystatus ==
// //                   //               '0'
// //                   //           ? AppColors.whiteColor
// //                   //           : AppColors.whiteColor,
// //                   //       fontWeight: FontWeight.bold,
// //                   //     ),
// //                   //   ),
// //                   // ),
// //                 ],
// //               ),
// //               const SizedBox(height: 5),
// //               // Row(
// //               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               //   children: [
// //               //     Expanded(
// //               //       // width: width / 2 - 60,
// //               //       child: Text(
// //               //         '${provider.calendarCurrentDateData[index].semester}' ==
// //               //                 ''
// //               //             ? '-'
// //               //             : '${provider.calendarCurrentDateData[index].semester} Semester',
// //               //         style: TextStyle(
// //               //           fontSize: 18,
// //               //           color: provider.calendarCurrentDateData[index]
// //               //                       .holidaystatus ==
// //               //                   '0'
// //               //               ? AppColors.whiteColor
// //               //               : AppColors.whiteColor,
// //               //         ),
// //               //       ),
// //               //     ),
// //               //     Expanded(
// //               //       // width: width / 2 - 20,
// //               //       child: Text(
// //               //         '${provider.calendarCurrentDateData[index].date}' == ''
// //               //             ? '-'
// //               //             : 'Week Day No ${provider.calendarCurrentDateData[index].date}',
// //               //         style: TextStyle(
// //               //           fontSize: 18,
// //               //           color: provider.calendarCurrentDateData[index]
// //               //                       .holidaystatus ==
// //               //                   '0'
// //               //               ? AppColors.whiteColor
// //               //               : AppColors.whiteColor,
// //               //         ),
// //               //         textAlign: TextAlign.right,
// //               //       ),
// //               //     ),
// //               //   ],
// //               // ),
// //               const SizedBox(height: 20),
// //               // if (provider.calendarCurrentDateData[index].remarks != '' ||
// //               //     provider.calendarCurrentDateData[index].remarks != '-')
// //               //   Row(
// //               //     crossAxisAlignment: CrossAxisAlignment.start,
// //               //     children: [
// //               //       SizedBox(
// //               //         width: 15,
// //               //         child: Icon(
// //               //           Icons.report,
// //               //           color: AppColors.theme02buttonColor2,
// //               //         ),
// //               //       ),
// //               //       const SizedBox(width: 20),
// //               //       SizedBox(
// //               //         width: width / 1.5,
// //               //         child: Text(
// //               //           '${provider.calendarCurrentDateData[index].remarks}' ==
// //               //                   ''
// //               //               ? '-'
// //               //               : '${provider.calendarCurrentDateData[index].remarks}',
// //               //           style: TextStyle(
// //               //             fontSize: 14,
// //               //             color: provider.calendarCurrentDateData[index]
// //               //                         .holidaystatus ==
// //               //                     '0'
// //               //                 ? AppColors.whiteColor
// //               //                 : AppColors.whiteColor,
// //               //             fontWeight: FontWeight.bold,
// //               //           ),
// //               //         ),
// //               //       ),
// //               //     ],
// //               //   ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // final provider = ref.watch(calendarProvider);
// //
// //     final provider = ref.watch(timetableProvider);
// //     ref.listen(examDetailsProvider, (previous, next) {
// //       if (next is ExamDetailsError) {
// //         _showToast(context, next.errorMessage, AppColors.redColor);
// //       } else if (next is ExamDetailsStateSuccessful) {
// //         _showToast(context, next.successMessage, AppColors.greenColor);
// //       }
// //     });
// //
// //     return Scaffold(
// //       backgroundColor: AppColors.whiteColor,
// //       appBar: PreferredSize(
// //         preferredSize: const Size.fromHeight(60),
// //         child: AppBar(
// //           flexibleSpace: Container(
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [
// //                   AppColors.theme02primaryColor,
// //                   AppColors.theme02secondaryColor1,
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //           ),
// //           leading: IconButton(
// //             onPressed: () {
// //               Navigator.pop(
// //                 context,
// //               );
// //             },
// //             icon: const Icon(
// //               Icons.arrow_back_ios_new,
// //               color: AppColors.whiteColor,
// //             ),
// //           ),
// //           backgroundColor: Colors.transparent,
// //           elevation: 0,
// //           title: const Text(
// //             'Time Table DETAILS',
// //             style: TextStyles.fontStyle4,
// //             overflow: TextOverflow.clip,
// //           ),
// //           centerTitle: true,
// //           actions: [
// //             Padding(
// //               padding: const EdgeInsets.only(right: 20),
// //               child: Row(
// //                 children: [
// //                   GestureDetector(
// //                     onTap: () async {
// //                       await ref
// //                           .read(calendarProvider.notifier)
// //                           .getCalendarDetails(
// //                             ref.read(encryptionProvider.notifier),
// //                           );
// //                       await ref
// //                           .read(calendarProvider.notifier)
// //                           .getHiveCalendar('');
// //                     },
// //                     child: const Icon(
// //                       Icons.refresh,
// //                       color: AppColors.whiteColor,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       body: LiquidPullToRefresh(
// //
// //         onRefresh: _handleRefresh,
// //         color: AppColors.primaryColorTheme3,
// //         child: SingleChildScrollView(
// //           child: Column(
// //             children: [
// //               if (provider is CalendarStateLoading) ...[
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 100),
// //                   child: Center(
// //                     child: CircularProgressIndicators
// //                         .primaryColorProgressIndication,
// //                   ),
// //                 ),
// //               ] else if (provider.timeTableData.isEmpty &&
// //                   provider is! CalendarStateLoading) ...[
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 100),
// //                   child: Center(
// //                     child: CircularProgressIndicators
// //                         .primaryColorProgressIndication,
// //                   ),
// //                 ),
// //               ] else ...[
// //                 Padding(
// //                   padding:
// //                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// //                   child: ListView.builder(
// //                     itemCount: provider.timeTableData.length,
// //                     controller: _listController,
// //                     shrinkWrap: true,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       final formattedDate =
// //                           DateFormat('dd-MM-yyyy').format(DateTime.now());
// //                       log('date >>> ${provider.timeTableData[index].subjects}');
// //                       log('date to string >>> ${formattedDate}');
// //                       return cardDesign(index); //
// //
// //                       // return cardDesign(index);
// //                     },
// //                   ),
// //                 ),
// //               ],
// //             ],
// //           ),
// //         ),
// //       ),
// //       endDrawer: const DrawerDesign(),
// //     );
// //   }
// //
// //   void _showToast(BuildContext context, String message, Color color) {
// //     showToast(
// //       message,
// //       context: context,
// //       backgroundColor: color,
// //       axis: Axis.horizontal,
// //       alignment: Alignment.centerLeft,
// //       position: StyledToastPosition.center,
// //       borderRadius: const BorderRadius.only(
// //         topRight: Radius.circular(15),
// //         bottomLeft: Radius.circular(15),
// //       ),
// //       toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
// //     );
// //   }
// // }
//
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';
// import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
// import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
// import 'package:sample/home/main_pages/lms/screens/lms_title_screen.dart';
// import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
//
// class Theme02TimetablePageScreen extends ConsumerStatefulWidget {
//   const Theme02TimetablePageScreen({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _Theme02TimetablePageScreenState();
// }
//
// class _Theme02TimetablePageScreenState
//     extends ConsumerState<Theme02TimetablePageScreen> {
//   final ScrollController _listController = ScrollController();
//
//   static int refreshNum = 10;
//   Stream<int> counterStream =
//       Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);
//
//   // Future<void> _handleRefresh() async {
//   //   WidgetsBinding.instance.addPostFrameCallback(
//   //     (_) {
//   //       ref.read(timetableProvider.notifier).getTimeTableDetails(
//   //             ref.read(encryptionProvider.notifier),
//   //           );
//   //     },
//   //   );
//
//   //   final completer = Completer<void>();
//   //   Timer(const Duration(seconds: 1), completer.complete);
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(timetableProvider.notifier).getTimeTableDetails(
//             ref.read(encryptionProvider.notifier),
//           );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final width = MediaQuery.of(context).size.width;
//     // final provider = ref.watch(notificationProvider);
//
//     final provider = ref.watch(timetableProvider);
//     ref.listen(lmsProvider, (previous, next) {
//       if (next is LibraryTrancsactionStateError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is LibraryTrancsactionStateSuccessful) {
//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });
//     return Scaffold(
//       backgroundColor: AppColors.secondaryColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Stack(
//           children: [
//             SvgPicture.asset(
//               'assets/images/wave.svg',
//               fit: BoxFit.fill,
//               width: double.infinity,
//               color: AppColors.primaryColor,
//               colorBlendMode: BlendMode.srcOut,
//             ),
//             AppBar(
//               flexibleSpace: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.theme02primaryColor,
//                       AppColors.theme02secondaryColor1,
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(
//                     context,
//                   );
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back_ios_new,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: const Text(
//                 'Time Table Page',
//                 style: TextStyles.fontStyle4,
//                 overflow: TextOverflow.clip,
//               ),
//               centerTitle: true,
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               if (provider is LibraryTrancsactionStateLoading)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: CircularProgressIndicators
//                         .primaryColorProgressIndication,
//                   ),
//                 )
//               else if (provider.timeTableData.isEmpty &&
//                   provider is! LibraryTrancsactionStateLoading)
//                 Column(
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height / 5),
//                     const Center(
//                       child: Text(
//                         'No List Added Yet!',
//                         style: TextStyles.fontStyle,
//                       ),
//                     ),
//                   ],
//                 ),
//               if (provider.timeTableData.isNotEmpty)
//                 ListView.builder(
//                   itemCount: provider.timeTableData.length,
//                   controller: _listController,
//                   shrinkWrap: true,
//                   itemBuilder: (BuildContext context, int index) {
//                     return cardDesign(index);
//                   },
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget cardDesign(int index) {
//     final width = MediaQuery.of(context).size.width;
//     final provider = ref.watch(timetableProvider);
//     return GestureDetector(
//       onTap: () {
//         // Navigate or perform an action when the card is tapped
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               // Time slot section
//
//               Container(
//                 width: width * 0.30,
//                 padding: const EdgeInsets.symmetric(vertical: 40),
//                 decoration: BoxDecoration(
//                   border: Border(
//                     right: BorderSide(
//                       color: AppColors.theme06primaryColor,
//                       width: 6,
//                     ),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       '${provider.timeTableData[index].dayorderdesc ?? '-'}',
//                       style: TextStyles.fontStyle10
//                           .copyWith(fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       '${provider.timeTableData[index].hourid ?? '-'}',
//                       style: TextStyles.fontStyle10
//                           .copyWith(fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       '${provider.timeTableData[index].hourtime ?? '-'}',
//                       style: TextStyles.fontStyle10
//                           .copyWith(fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//
//               // Session details section
//               Expanded(
//                 child: Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${provider.timeTableData[index].subjectcode ?? '-'}',
//                         style: TextStyles.fontStyle8
//                             .copyWith(fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         '${provider.timeTableData[index].subjectdesc ?? '-'}',
//                         style: TextStyles.fontStyle10
//                             .copyWith(color: Colors.black87),
//                       ),
//                       const SizedBox(height: 5),
//                       Text(
//                         '${provider.timeTableData[index].faculty ?? '-'}',
//                         style: TextStyles.fontStyle10
//                             .copyWith(color: Colors.black54),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
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

class Theme02TimetablePageScreen extends ConsumerStatefulWidget {
  const Theme02TimetablePageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02TimetablePageScreenState();
}

class _Theme02TimetablePageScreenState
    extends ConsumerState<Theme02TimetablePageScreen> {
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(timetableProvider.notifier).getTimeTableDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(timetableProvider);

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
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
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.whiteColor,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Timetable',
              style: TextStyles.fontStyle4,
              overflow: TextOverflow.clip,
            ),
            centerTitle: true,
            bottom: const TabBar(
              labelColor: Colors.white,
              // Selected tab text and icon color
              unselectedLabelColor: Colors.black,
              // Unselected tab text and icon color
              indicatorColor: Colors.white,
              // Indicator (underline) color
              tabs: [
                Tab(
                  text: 'Today',
                ),
                Tab(
                  text: 'Timetable',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // First tab: Timetable view
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (provider is TimetableLoading)
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: CircularProgressIndicators
                              .primaryColorProgressIndication,
                        ),
                      )
                    else if (provider.timeTableData.isEmpty &&
                        provider is! TimetableLoading)
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 5),
                          const Center(
                            child: Text(
                              'No List Added Yet!',
                              style: TextStyles.fontStyle,
                            ),
                          ),
                        ],
                      )
                    else
                      ListView.builder(
                        itemCount: provider.timeTableData.length,
                        controller: _listController,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return cardDesigntoday(index);
                        },
                      ),
                  ],
                ),
              ),
            ),
            // Second tab: Calendar view

            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    if (provider is TimetableLoading)
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: CircularProgressIndicators
                              .primaryColorProgressIndication,
                        ),
                      )
                    else if (provider.timeTableData.isEmpty &&
                        provider is! TimetableLoading)
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 5),
                          const Center(
                            child: Text(
                              'No List Added Yet!',
                              style: TextStyles.fontStyle,
                            ),
                          ),
                        ],
                      )
                    else
                      ListView.builder(
                        itemCount: provider.timeTableData.length,
                        controller: _listController,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return cardDesign(index);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(timetableProvider);
    return GestureDetector(
      onTap: () {
        // Navigate or perform an action when the card is tapped
      },
      child: Column(
        children: [
          if (provider.timeTableData[index].hourtime == '09:30:00-10:30:00')
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    width: width * 0.89,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${provider.timeTableData[index].dayorderdesc ?? '-'}',
                              style: TextStyles.fontStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // Username Input
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          // Input const SizedBox(
          //    height: 10,
          //  ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Time slot section
                  Container(
                    width: width * 0.20,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: AppColors.theme06primaryColor,
                          width: 6,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   '${provider.timeTableData[index].dayorderdesc ?? '-'}',
                        //   style: TextStyles.fontStyle10
                        //       .copyWith(fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.center,
                        // ),
                        // const SizedBox(height: 10),
                        Text(
                          '${provider.timeTableData[index].hourid ?? '-'}',
                          style: TextStyles.fontStyle10
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        // const SizedBox(height: 10),
                        // Text(
                        //   '${provider.timeTableData[index].hourtime ?? '-'}',
                        //   style: TextStyles.fontStyle10
                        //       .copyWith(fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                  ),
                  // Session details sect
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${provider.timeTableData[index].subjectcode ?? '-'}',
                            style: TextStyles.fontStyle8
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${provider.timeTableData[index].subjectdesc ?? '-'}',
                            style: TextStyles.fontStyle10
                                .copyWith(color: Colors.black87),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${provider.timeTableData[index].faculty ?? '-'}',
                            style: TextStyles.fontStyle10
                                .copyWith(color: Colors.black54),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${provider.timeTableData[index].hourtime ?? '-'}',
                            style: TextStyles.fontStyle10
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget cardDesigntoday(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //   final provider = ref.watch(timetableProvider);
  //   return GestureDetector(
  //     onTap: () {
  //       // Navigate or perform an action when the card is tapped
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(10),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.2),
  //               spreadRadius: 2,
  //               blurRadius: 5,
  //               offset: const Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: Row(
  //           children: [
  //             // Time slot section
  //             Container(
  //               width: width * 0.30,
  //               padding: const EdgeInsets.symmetric(vertical: 40),
  //               decoration: BoxDecoration(
  //                 border: Border(
  //                   right: BorderSide(
  //                     color: AppColors.theme06primaryColor,
  //                     width: 6,
  //                   ),
  //                 ),
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     '${provider.timeTableData[index].dayorderdesc ?? '-'}',
  //                     style: TextStyles.fontStyle10
  //                         .copyWith(fontWeight: FontWeight.bold),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   const SizedBox(height: 10),
  //                   Text(
  //                     '${provider.timeTableData[index].hourid ?? '-'}',
  //                     style: TextStyles.fontStyle10
  //                         .copyWith(fontWeight: FontWeight.bold),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                   const SizedBox(height: 10),
  //                   Text(
  //                     '${provider.timeTableData[index].hourtime ?? '-'}',
  //                     style: TextStyles.fontStyle10
  //                         .copyWith(fontWeight: FontWeight.bold),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             // Session details section
  //             Expanded(
  //               child: Padding(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       '${provider.timeTableData[index].subjectcode ?? '-'}',
  //                       style: TextStyles.fontStyle8
  //                           .copyWith(fontWeight: FontWeight.bold),
  //                     ),
  //                     const SizedBox(height: 5),
  //                     Text(
  //                       '${provider.timeTableData[index].subjectdesc ?? '-'}',
  //                       style: TextStyles.fontStyle10
  //                           .copyWith(color: Colors.black87),
  //                     ),
  //                     const SizedBox(height: 5),
  //                     Text(
  //                       '${provider.timeTableData[index].faculty ?? '-'}',
  //                       style: TextStyles.fontStyle10
  //                           .copyWith(color: Colors.black54),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget cardDesigntoday(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(timetableProvider);

    // Get the current day of the week (e.g., Monday, Tuesday)
    String currentDay = DateFormat('EEEE').format(DateTime.now()).toLowerCase();

    // Filter data to show only today's entries
    var todayData = provider.timeTableData.where((data) {
      return data.dayorderdesc?.toLowerCase() == currentDay;
    }).toList();

    // // Ensure we only show today's data if available
    // if (todayData.isEmpty) {
    //   return Container(); // Or show a message if no data is available for today
    // }
    //
    // // Use the first entry of today's data
    // var data = todayData[index];

    if (todayData.isEmpty) {
      return Container();
    }

    if (index < 0 || index >= todayData.length) {
      print(
          "Invalid index: $index. Today's data has only ${todayData.length} entries.");
      return Container(); // Or show a placeholder widget
    }

    var data = todayData[index];

    return GestureDetector(
      onTap: () {
        // Navigate or perform an action when the card is tapped
      },
      child: Column(
        children: [
          if (provider.timeTableData[index].hourtime == '09:30:00-10:30:00')
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                width: width * 0.89,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${data.dayorderdesc ?? '-'}',
                          style: TextStyles.fontStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Username Input
                      ],
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Time slot section
                  Container(
                    width: width * 0.20,
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: AppColors.theme06primaryColor,
                          width: 6,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Text(
                        //   '${data.dayorderdesc ?? '-'}',
                        //   style: TextStyles.fontStyle10
                        //       .copyWith(fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.center,
                        // ),
                        // const SizedBox(height: 10),
                        Text(
                          '${data.hourid ?? '-'}',
                          style: TextStyles.fontStyle10
                              .copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        // const SizedBox(height: 10),
                        // Text(
                        //   '${data.hourtime ?? '-'}',
                        //   style: TextStyles.fontStyle10
                        //       .copyWith(fontWeight: FontWeight.bold),
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                  ),
                  // Session details section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.subjectcode ?? '-'}',
                            style: TextStyles.fontStyle8
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${data.subjectdesc ?? '-'}',
                            style: TextStyles.fontStyle10
                                .copyWith(color: Colors.black87),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${data.faculty ?? '-'}',
                            style: TextStyles.fontStyle10
                                .copyWith(color: Colors.black54),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${provider.timeTableData[index].hourtime ?? '-'}',
                            style: TextStyles.fontStyle10
                                .copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget cardDesigntoday(int index) {
//   final width = MediaQuery.of(context).size.width;
//   final provider = ref.watch(timetableProvider);
//   final calendarprovider = ref.watch(calendarProvider);
//
//   // Condition to check if the day orders match
//   bool isSameDay = calendarprovider.calendarHiveData[index].dayorder ==
//       provider.timeTableData[index].dayorderdesc;
//
//   log(' Calendar dayorder >>> ${calendarprovider.calendarHiveData[index].dayorder}');
//   log(' dayorder desc >>> ${provider.timeTableData[index].dayorderdesc}');
//
//   // If it's not the same day, return an empty widget to not display this card
//   if (!isSameDay) {
//     return SizedBox.shrink(); // Return an empty widget if not the same day
//   }
//
//   return GestureDetector(
//     onTap: () {
//       // Navigate or perform an action when the card is tapped
//     },
//     child: Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.green.withOpacity(0.1), // Color for same day
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Time slot section
//             Container(
//               width: width * 0.30,
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               decoration: BoxDecoration(
//                 border: Border(
//                   right: BorderSide(
//                     color: AppColors.theme06primaryColor,
//                     width: 6,
//                   ),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     '${provider.timeTableData[index].dayorderdesc ?? '-'}',
//                     style: TextStyles.fontStyle10
//                         .copyWith(fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     '${provider.timeTableData[index].hourid ?? '-'}',
//                     style: TextStyles.fontStyle10
//                         .copyWith(fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     '${provider.timeTableData[index].hourtime ?? '-'}',
//                     style: TextStyles.fontStyle10
//                         .copyWith(fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             // Session details section
//             Expanded(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${provider.timeTableData[index].subjectcode ?? '-'}',
//                       style: TextStyles.fontStyle8
//                           .copyWith(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       '${provider.timeTableData[index].subjectdesc ?? '-'}',
//                       style: TextStyles.fontStyle10
//                           .copyWith(color: Colors.black87),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       '${provider.timeTableData[index].faculty ?? '-'}',
//                       style: TextStyles.fontStyle10
//                           .copyWith(color: Colors.black54),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Text(
//                         'Same Day!',
//                         style: TextStyles.fontStyle10.copyWith(
//                             color: Colors.green, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
