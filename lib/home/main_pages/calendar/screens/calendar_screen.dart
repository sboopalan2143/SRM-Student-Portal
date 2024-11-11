// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
// import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
// import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
// import 'package:sample/home/widgets/drawer_design.dart';

// class CalendarPage extends ConsumerStatefulWidget {
//   const CalendarPage({
//     super.key,
//   });

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CalendarPageState();
// }

// class _CalendarPageState extends ConsumerState<CalendarPage> {
//   final ScrollController _listController = ScrollController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
//       GlobalKey<LiquidPullToRefreshState>();

//   static int refreshNum = 10;
//   Stream<int> counterStream =
//       Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

//   Future<void> _handleRefresh() async {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) {
//         ref
//             .read(calendarProvider.notifier)
//             .getCalendarDetails(ref.read(encryptionProvider.notifier));
//       },
//     );

//     final completer = Completer<void>();
//     Timer(const Duration(seconds: 1), completer.complete);
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref
//           .read(calendarProvider.notifier)
//           .getCalendarDetails(ref.read(encryptionProvider.notifier));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final width = MediaQuery.of(context).size.width;
//     final provider = ref.watch(calendarProvider);
//     ref.listen(calendarProvider, (previous, next) {
//       if (next is LibraryTrancsactionStateError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is LibraryTrancsactionStateSuccessful) {
//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });
//     return Scaffold(
//       key: scaffoldKey,
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
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back_ios_new,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: const Text(
//                 'MCQ Answer Screen',
//                 style: TextStyles.fontStyle4,
//                 overflow: TextOverflow.clip,
//               ),
//               centerTitle: true,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           ref
//                               .read(calendarProvider.notifier)
//                               .getCalendarDetails(
//                                   ref.read(encryptionProvider.notifier));
//                         },
//                         child: const Icon(
//                           Icons.refresh,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: LiquidPullToRefresh(
//         key: _refreshIndicatorKey,
//         onRefresh: _handleRefresh,
//         color: AppColors.primaryColor,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 if (provider is LibraryTrancsactionStateLoading)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 100),
//                     child: Center(
//                       child: CircularProgressIndicators
//                           .primaryColorProgressIndication,
//                     ),
//                   )
//                 else if (provider.calendarData.isEmpty &&
//                     provider is! LibraryTrancsactionStateLoading)
//                   Column(
//                     children: [
//                       SizedBox(height: MediaQuery.of(context).size.height / 5),
//                       const Center(
//                         child: Text(
//                           'No List Added Yet!',
//                           style: TextStyles.fontStyle1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 if (provider.calendarData.isNotEmpty)
//                   ListView.builder(
//                     itemCount: provider.calendarData.length,
//                     controller: _listController,
//                     shrinkWrap: true,
//                     itemBuilder: (BuildContext context, int index) {
//                       return cardDesign(index);
//                     },
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       endDrawer: const DrawerDesign(),
//     );
//   }

//   Widget cardDesign(int index) {
//     final provider = ref.watch(calendarProvider);

//     return GestureDetector(
//       onTap: () {
//         // ref.read(calendarProvider.notifier).getLmsAttachmentDetails(
//         //       ref.read(encryptionProvider.notifier),
//         //       '${provider.calendarData[index].classworkid}',
//         //     );

//         // Navigator.push(
//         //   context,
//         //   RouteDesign(
//         //     route: LmsAttachmentDetailsDataPage(
//         //       classworkID: '${provider.calendarData[index].classworkid}',
//         //     ),
//         //   ),
//         // );
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 8),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   Text('MCQ Entry ', style: TextStyles.titleFontStyle),
//                   const SizedBox(height: 20),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'Work Type : ',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         'MCQ',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Date',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Expanded(
//                         child: Text(
//                           '${provider.calendarData[index].date}',
//                           style: TextStyles.smallBlackColorFontStyle,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Day',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         '${provider.calendarData[index].day}',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Day Order',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         '${provider.calendarData[index].dayorder}',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Day Order',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         '${provider.calendarData[index].daystatus}',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Holiday status',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         '${provider.calendarData[index].holidaystatus}',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Remarks',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         '${provider.calendarData[index].remarks}',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Semester',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         '${provider.calendarData[index].semester}',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Week day no',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                       Text(
//                         '${provider.calendarData[index].weekdayno}',
//                         style: TextStyles.smallBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(calendarProvider.notifier).getHiveCalendar('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarProvider.notifier).getHiveCalendar('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(calendarProvider);
    ref.listen(examDetailsProvider, (previous, next) {
      if (next is ExamDetailsError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is ExamDetailsStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      key: scaffoldKey,
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
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'CALENDAR DETAILS',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ref
                              .read(calendarProvider.notifier)
                              .getHiveCalendar('');
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (provider is ExamDetailsStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.calendarHiveData.isEmpty &&
                  provider is! ExamDetailsStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle6,
                      ),
                    ),
                  ],
                ),
              if (provider.calendarHiveData.isNotEmpty)
                const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  itemCount: provider.calendarHiveData.length,
                  controller: _listController,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return cardDesign(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(calendarProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Date',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].date}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].date}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Day',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].day}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].day}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Day order',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].dayorder}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].dayorder}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Day status',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].daystatus}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].daystatus}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Holiday status',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].holidaystatus}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].holidaystatus}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Remarks',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].remarks}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].remarks}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Semester',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].semester}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].semester}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Week day no',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                  const Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].weekdayno}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].weekdayno}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
