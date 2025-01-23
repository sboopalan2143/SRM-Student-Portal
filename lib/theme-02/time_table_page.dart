// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:intl/intl.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
// import 'package:sample/home/main_pages/calendar/model/calendar_hive_model.dart';
// import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
// import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';
// import 'package:sample/home/widgets/drawer_design.dart';
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
//   final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
//       GlobalKey<LiquidPullToRefreshState>();
//
//   static int refreshNum = 10;
//   Stream<int> counterStream =
//       Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);
//
//   Future<void> _handleRefresh() async {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) async {
//         await ref
//             .read(timetableProvider.notifier)
//             .getTimeTableDetails(ref.read(encryptionProvider.notifier));
//       },
//     );
//
//     final completer = Completer<void>();
//     Timer(const Duration(seconds: 1), completer.complete);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) async {
//         await ref
//             .read(timetableProvider.notifier)
//             .getTimeTableDetails(ref.read(encryptionProvider.notifier));
//       },
//     );
//   }
//
//   Widget cardDesign(int index) {
//     final width = MediaQuery.of(context).size.width;
//     final provider = ref.watch(timetableProvider);
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 25),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               AppColors.theme02primaryColor,
//               AppColors.theme02secondaryColor1,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     // width: width / 2 - 60,
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 15,
//                           child: Icon(
//                             Icons.calendar_month,
//                             color: AppColors.theme02buttonColor2,
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         Expanded(
//                           child: Text(
//                             '${provider.timeTableData[index].dayorderdesc}' ==
//                                     ''
//                                 ? '-'
//                                 : '${provider.timeTableData[index].dayorderdesc}',
//                             style: TextStyle(
//                               fontSize: 25,
//                               color:
//                                   provider.timeTableData[index].dayorderdesc ==
//                                           '0'
//                                       ? AppColors.whiteColor
//                                       : AppColors.whiteColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         // Expanded(
//                         //   child: Text(
//                         //     // Check if the date matches today
//                         // provider.calendarCurrentDateData[index].date ==
//                         //         DateTime.now().day.toString()
//                         //     ? '${provider.calendarCurrentDateData[index].date}'
//                         //     : '-', // Show '-' if it is not today's date
//                         //     style: TextStyle(
//                         //       fontSize: 25,
//                         //       color: provider.calendarCurrentDateData[index]
//                         //                   .holidaystatus ==
//                         //               '0'
//                         //           ? AppColors.whiteColor
//                         //           : AppColors.whiteColor,
//                         //       fontWeight: FontWeight.bold,
//                         //     ),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   // SizedBox(
//                   //   // width: width / 2 - 60,
//                   //   child: Text(
//                   //     '${provider.calendarCurrentDateData[index].daystatus}' ==
//                   //             ''
//                   //         ? '-'
//                   //         : '${provider.calendarCurrentDateData[index].daystatus}',
//                   //     style: TextStyle(
//                   //       fontSize: 20,
//                   //       color: provider.calendarCurrentDateData[index]
//                   //                   .holidaystatus ==
//                   //               '0'
//                   //           ? AppColors.whiteColor
//                   //           : AppColors.whiteColor,
//                   //       fontWeight: FontWeight.bold,
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               const SizedBox(height: 5),
//               // Row(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     Expanded(
//               //       // width: width / 2 - 60,
//               //       child: Text(
//               //         '${provider.calendarCurrentDateData[index].semester}' ==
//               //                 ''
//               //             ? '-'
//               //             : '${provider.calendarCurrentDateData[index].semester} Semester',
//               //         style: TextStyle(
//               //           fontSize: 18,
//               //           color: provider.calendarCurrentDateData[index]
//               //                       .holidaystatus ==
//               //                   '0'
//               //               ? AppColors.whiteColor
//               //               : AppColors.whiteColor,
//               //         ),
//               //       ),
//               //     ),
//               //     Expanded(
//               //       // width: width / 2 - 20,
//               //       child: Text(
//               //         '${provider.calendarCurrentDateData[index].date}' == ''
//               //             ? '-'
//               //             : 'Week Day No ${provider.calendarCurrentDateData[index].date}',
//               //         style: TextStyle(
//               //           fontSize: 18,
//               //           color: provider.calendarCurrentDateData[index]
//               //                       .holidaystatus ==
//               //                   '0'
//               //               ? AppColors.whiteColor
//               //               : AppColors.whiteColor,
//               //         ),
//               //         textAlign: TextAlign.right,
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               const SizedBox(height: 20),
//               // if (provider.calendarCurrentDateData[index].remarks != '' ||
//               //     provider.calendarCurrentDateData[index].remarks != '-')
//               //   Row(
//               //     crossAxisAlignment: CrossAxisAlignment.start,
//               //     children: [
//               //       SizedBox(
//               //         width: 15,
//               //         child: Icon(
//               //           Icons.report,
//               //           color: AppColors.theme02buttonColor2,
//               //         ),
//               //       ),
//               //       const SizedBox(width: 20),
//               //       SizedBox(
//               //         width: width / 1.5,
//               //         child: Text(
//               //           '${provider.calendarCurrentDateData[index].remarks}' ==
//               //                   ''
//               //               ? '-'
//               //               : '${provider.calendarCurrentDateData[index].remarks}',
//               //           style: TextStyle(
//               //             fontSize: 14,
//               //             color: provider.calendarCurrentDateData[index]
//               //                         .holidaystatus ==
//               //                     '0'
//               //                 ? AppColors.whiteColor
//               //                 : AppColors.whiteColor,
//               //             fontWeight: FontWeight.bold,
//               //           ),
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final provider = ref.watch(calendarProvider);
//
//     final provider = ref.watch(timetableProvider);
//     ref.listen(examDetailsProvider, (previous, next) {
//       if (next is ExamDetailsError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is ExamDetailsStateSuccessful) {
//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });
//
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   AppColors.theme02primaryColor,
//                   AppColors.theme02secondaryColor1,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(
//                 context,
//               );
//             },
//             icon: const Icon(
//               Icons.arrow_back_ios_new,
//               color: AppColors.whiteColor,
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           title: const Text(
//             'Time Table DETAILS',
//             style: TextStyles.fontStyle4,
//             overflow: TextOverflow.clip,
//           ),
//           centerTitle: true,
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 20),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       await ref
//                           .read(calendarProvider.notifier)
//                           .getCalendarDetails(
//                             ref.read(encryptionProvider.notifier),
//                           );
//                       await ref
//                           .read(calendarProvider.notifier)
//                           .getHiveCalendar('');
//                     },
//                     child: const Icon(
//                       Icons.refresh,
//                       color: AppColors.whiteColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: LiquidPullToRefresh(
//         key: _refreshIndicatorKey,
//         onRefresh: _handleRefresh,
//         color: AppColors.primaryColorTheme3,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               if (provider is CalendarStateLoading) ...[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: CircularProgressIndicators
//                         .primaryColorProgressIndication,
//                   ),
//                 ),
//               ] else if (provider.timeTableData.isEmpty &&
//                   provider is! CalendarStateLoading) ...[
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: CircularProgressIndicators
//                         .primaryColorProgressIndication,
//                   ),
//                 ),
//               ] else ...[
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: ListView.builder(
//                     itemCount: provider.timeTableData.length,
//                     controller: _listController,
//                     shrinkWrap: true,
//                     itemBuilder: (BuildContext context, int index) {
//                       final formattedDate =
//                           DateFormat('dd-MM-yyyy').format(DateTime.now());
//                       log('date >>> ${provider.timeTableData[index].subjects}');
//                       log('date to string >>> ${formattedDate}');
//                       return cardDesign(index); //
//
//                       // return cardDesign(index);
//                     },
//                   ),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//       endDrawer: const DrawerDesign(),
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/main_pages/lms/screens/lms_title_screen.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class Theme02TimetablePageScreen extends ConsumerStatefulWidget {
  const Theme02TimetablePageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02TimetablePageScreenState();
}

class _Theme02TimetablePageScreenState
    extends ConsumerState<Theme02TimetablePageScreen> {
  final ScrollController _listController = ScrollController();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  // Future<void> _handleRefresh() async {
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) {
  //       ref.read(timetableProvider.notifier).getTimeTableDetails(
  //             ref.read(encryptionProvider.notifier),
  //           );
  //     },
  //   );

  //   final completer = Completer<void>();
  //   Timer(const Duration(seconds: 1), completer.complete);
  // }

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
    // final width = MediaQuery.of(context).size.width;
    // final provider = ref.watch(notificationProvider);

    final provider = ref.watch(timetableProvider);
    ref.listen(lmsProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColor,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
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
                'Time Table Page',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (provider is LibraryTrancsactionStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.timeTableData.isEmpty &&
                  provider is! LibraryTrancsactionStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle,
                      ),
                    ),
                  ],
                ),
              if (provider.timeTableData.isNotEmpty)
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
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(timetableProvider);

    return GestureDetector(
      onTap: () {
        // Navigate or perform an action when the card is tapped
      },
      child: Padding(
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
                width: width * 0.25,
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
                    Text(
                      '${provider.timeTableData[index].dayorderdesc ?? '-'}',
                      style: TextStyles.fontStyle10
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${provider.timeTableData[index].hourid ?? '-'}',
                      style: TextStyles.fontStyle10
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Session details section
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //
  //   // final provider = ref.watch(notificationProvider);
  //
  //   final provider = ref.watch(timetableProvider);
  //   return GestureDetector(
  //     onTap: () {
  //       // ref.read(lmsProvider.notifier).getLmsTitleDetails(
  //       //       ref.read(encryptionProvider.notifier),
  //       //       '${provider.lmsSubjectData[index].subjectid}',
  //       //     );
  //       // Navigator.push(
  //       //   context,
  //       //   RouteDesign(
  //       //     route: LmsTitlePage(
  //       //       subjectID: '${provider.lmsSubjectData[index].staffname}',
  //       //     ),
  //       //   ),
  //       // );
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 8),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: const BorderRadius.all(Radius.circular(20)),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.2),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: const Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'Faculty',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.timeTableData[index].faculty}' == 'null'
  //                           ? '-'
  //                           : '''${provider.timeTableData[index].faculty}''',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'Dayorder id',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.timeTableData[index].dayorderid}' == 'null'
  //                           ? '-'
  //                           : '''${provider.timeTableData[index].dayorderid}''',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'Dayorder Desc',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.timeTableData[index].dayorderdesc}' ==
  //                               'null'
  //                           ? '-'
  //                           : '''${provider.timeTableData[index].dayorderdesc}''',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'Hour Id',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.timeTableData[index].hourid}' == 'null'
  //                           ? '-'
  //                           : '''${provider.timeTableData[index].hourid}''',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'Subject Code',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.timeTableData[index].subjectcode}' == 'null'
  //                           ? '-'
  //                           : '''${provider.timeTableData[index].subjectcode}''',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'Subject Desc',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.timeTableData[index].subjectdesc}' == 'null'
  //                           ? '-'
  //                           : '''${provider.timeTableData[index].subjectdesc}''',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
