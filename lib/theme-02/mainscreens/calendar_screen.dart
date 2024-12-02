// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
// import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
// import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:table_calendar/table_calendar.dart';

// class Theme02CalendarPage extends ConsumerStatefulWidget {
//   const Theme02CalendarPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _Theme02CalendarPageState();
// }

// class _Theme02CalendarPageState extends ConsumerState<Theme02CalendarPage> {
//   final ScrollController _listController = ScrollController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
//       GlobalKey<LiquidPullToRefreshState>();

//   late DateTime _selectedDay;
//   late DateTime _focusedDay;
//   late Map<DateTime, List<String>> _events;

//   Future<void> _handleRefresh() async {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) async {
//         await ref
//             .read(calendarProvider.notifier)
//             .getCalendarDetails(ref.read(encryptionProvider.notifier));
//         await ref.read(calendarProvider.notifier).getHiveCalendar('');
//       },
//     );

//     final completer = Completer<void>();
//     Timer(const Duration(seconds: 1), completer.complete);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = DateTime.now();
//     _focusedDay = DateTime.now();
//     _events = {}; // Initialize events map

//     // Simulating event data for testing
//     _events[DateTime.utc(2024, 3, 8)] = ['Event 1'];
//     _events[DateTime.utc(2024, 3, 23)] = ['Event 2', 'Event 3'];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = ref.watch(calendarProvider);
//     ref.listen(examDetailsProvider, (previous, next) {
//       if (next is ExamDetailsError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is ExamDetailsStateSuccessful) {
//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });

//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: AppColors.theme01primaryColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Stack(
//           children: [
//             AppBar(
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_ios_new,
//                   color: AppColors.theme01primaryColor,
//                 ),
//               ),
//               backgroundColor: AppColors.theme01secondaryColor4,
//               elevation: 0,
//               title: Text(
//                 'CALENDAR DETAILS',
//                 style: TextStyles.buttonStyle01theme4,
//                 overflow: TextOverflow.clip,
//               ),
//               centerTitle: true,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           await ref
//                               .read(calendarProvider.notifier)
//                               .getCalendarDetails(
//                                   ref.read(encryptionProvider.notifier));
//                           await ref
//                               .read(calendarProvider.notifier)
//                               .getHiveCalendar('');
//                         },
//                         child: Icon(
//                           Icons.refresh,
//                           color: AppColors.theme01primaryColor,
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
//         color: AppColors.theme01primaryColor,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               if (provider is CalendarStateLoading)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: CircularProgressIndicators
//                         .theme01primaryColorProgressIndication,
//                   ),
//                 )
//               else if (provider.calendarHiveData.isEmpty &&
//                   provider is! CalendarStateLoading)
//                 Column(
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height / 5),
//                   ],
//                 ),
//               if (provider.calendarHiveData.isNotEmpty)
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   // child: TableCalendar(
//                   //   firstDay: _firstDay,
//                   //   focusedDay: _focusedDay,
//                   //   selectedDayPredicate: (day) {
//                   //     return isSameDay(_selectedDay, day);
//                   //   },
//                   //   onDaySelected: (selectedDay, focusedDay) {
//                   //     setState(() {
//                   //       _selectedDay = selectedDay;
//                   //       _focusedDay = focusedDay;
//                   //       _firstDay = firstDay;
//                   //     });
//                   //   },
//                   //   eventLoader: (day) {
//                   //     // Return the list of events for the day
//                   //     return _events[day] ?? [];
//                   //   },
//                   //   calendarStyle: CalendarStyle(
//                   //     todayDecoration: BoxDecoration(
//                   //       color: AppColors.theme01primaryColor,
//                   //       shape: BoxShape.circle,
//                   //     ),
//                   //     selectedDecoration: BoxDecoration(
//                   //       color: AppColors.theme01secondaryColor2,
//                   //       shape: BoxShape.circle,
//                   //     ),
//                   //     weekendTextStyle: TextStyle(
//                   //       color: AppColors.redColor,
//                   //     ),
//                   //   ),
//                   //   headerStyle: HeaderStyle(
//                   //     formatButtonVisible: false,
//                   //     leftChevronIcon: Icon(
//                   //       Icons.chevron_left,
//                   //       color: AppColors.theme01primaryColor,
//                   //     ),
//                   //     rightChevronIcon: Icon(
//                   //       Icons.chevron_right,
//                   //       color: AppColors.theme01primaryColor,
//                   //     ),
//                   //   ),
//                   // ),
//                 ),
//               // Optionally, display selected day events
//               if (_events[_selectedDay] != null)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Events on ${_selectedDay.toLocal()}',
//                         style: TextStyles.buttonStyle01theme2,
//                       ),
//                       ..._events[_selectedDay]!.map((event) => Text(event)),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       endDrawer: const DrawerDesign(),
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
