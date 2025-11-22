// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';
//
// class Theme07TimetablePageScreen extends ConsumerStatefulWidget {
//   const Theme07TimetablePageScreen({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _Theme07TimetablePageScreenState();
// }
//
// class _Theme07TimetablePageScreenState
//     extends ConsumerState<Theme07TimetablePageScreen> {
//   final ScrollController _listController = ScrollController();
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
//     final provider = ref.watch(timetableProvider);
//
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: AppColors.theme07secondaryColor,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(110),
//           child: AppBar(
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.theme07primaryColor,
//                     AppColors.theme07primaryColor,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//             leading: IconButton(
//               onPressed: () => Navigator.pop(context),
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: AppColors.whiteColor,
//               ),
//             ),
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             title: const Text(
//               'TIMETABLE',
//               style: TextStyles.fontStyle4,
//               overflow: TextOverflow.clip,
//             ),
//             centerTitle: true,
//             bottom:const  TabBar(
//               labelColor: Colors.white,
//               unselectedLabelColor: AppColors.lightAshColor,
//               indicatorColor: Colors.white,
//               tabs:  [
//                 Tab(
//                   text: 'Monday',
//                 ),
//                 Tab(
//                   text: 'Tuesday',
//                 ),
//                 Tab(
//                   text: 'Wednesday',
//                 ),
//                 Tab(
//                   text: 'Thursday',
//                 ),
//                 Tab(
//                   text: 'Friday',
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             // First tab: Timetable view
//             SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (provider is TimetableLoading)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 100),
//                         child: Center(
//                           child: CircularProgressIndicators
//                               .primaryColorProgressIndication,
//                         ),
//                       )
//                     else if (provider.timeTableData.isEmpty &&
//                         provider is! TimetableLoading)
//                       Column(
//                         children: [
//                           SizedBox(
//                               height: MediaQuery.of(context).size.height / 5),
//                           const Center(
//                             child: Text(
//                               'No List Added Yet!',
//                               style: TextStyles.fontStyle,
//                             ),
//                           ),
//                         ],
//                       )
//                     else
//                       ListView.builder(
//                         itemCount: provider.timeTableData.length,
//                         controller: _listController,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           return cardDesignmonday(index);
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//             // Second tab: Calendar view
//
//             SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     if (provider is TimetableLoading)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 100),
//                         child: Center(
//                           child: CircularProgressIndicators
//                               .primaryColorProgressIndication,
//                         ),
//                       )
//                     else if (provider.timeTableData.isEmpty &&
//                         provider is! TimetableLoading)
//                       Column(
//                         children: [
//                           SizedBox(
//                               height: MediaQuery.of(context).size.height / 5),
//                           const Center(
//                             child: Text(
//                               'No List Added Yet!',
//                               style: TextStyles.fontStyle,
//                             ),
//                           ),
//                         ],
//                       )
//                     else
//                       ListView.builder(
//                         itemCount: provider.timeTableData.length,
//                         controller: _listController,
//                         shrinkWrap: true,
//                         itemBuilder: (BuildContext context, int index) {
//                           return cardDesignmonday(index);
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget cardDesign(int index) {
//   //   final width = MediaQuery.of(context).size.width;
//   //   final provider = ref.watch(timetableProvider);
//   //   return GestureDetector(
//   //     onTap: () {
//   //       // Navigate or perform an action when the card is tapped
//   //     },
//   //     child: Column(
//   //       children: [
//   //         if (provider.timeTableData[index].hourtime == '09:30:00-10:30:00')
//   //           Row(
//   //             children: [
//   //               Padding(
//   //                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//   //                 child: Container(
//   //                   width: width * 0.89,
//   //                   child: Card(
//   //                     elevation: 10,
//   //                     shape: RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(10),
//   //                     ),
//   //                     child: Padding(
//   //                       padding: const EdgeInsets.symmetric(vertical: 10),
//   //                       child: Column(
//   //                         crossAxisAlignment: CrossAxisAlignment.center,
//   //                         children: [
//   //                           Text(
//   //                             '${provider.timeTableData[index].dayorderdesc ?? '-'}',
//   //                             style: TextStyles.fontStyle.copyWith(
//   //                               fontWeight: FontWeight.bold,
//   //                             ),
//   //                           ),
//   //
//   //                           // Username Input
//   //                         ],
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //         // Input const SizedBox(
//   //         //    height: 10,
//   //         //  ),
//   //         Padding(
//   //           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               color: Colors.white,
//   //               borderRadius: BorderRadius.circular(10),
//   //               boxShadow: [
//   //                 BoxShadow(
//   //                   color: Colors.grey.withOpacity(0.2),
//   //                   spreadRadius: 2,
//   //                   blurRadius: 5,
//   //                   offset: const Offset(0, 3),
//   //                 ),
//   //               ],
//   //             ),
//   //             child: Row(
//   //               children: [
//   //                 // Time slot section
//   //                 Container(
//   //                   width: width * 0.20,
//   //                   padding: const EdgeInsets.symmetric(vertical: 40),
//   //                   decoration: BoxDecoration(
//   //                     border: Border(
//   //                       right: BorderSide(
//   //                         color: AppColors.theme07primaryColor,
//   //                         width: 6,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.center,
//   //                     children: [
//   //                       // Text(
//   //                       //   '${provider.timeTableData[index].dayorderdesc ?? '-'}',
//   //                       //   style: TextStyles.fontStyle10
//   //                       //       .copyWith(fontWeight: FontWeight.bold),
//   //                       //   textAlign: TextAlign.center,
//   //                       // ),
//   //                       // const SizedBox(height: 10),
//   //                       Text(
//   //                         '${provider.timeTableData[index].hourid ?? '-'}',
//   //                         style: TextStyles.fontStyle10
//   //                             .copyWith(fontWeight: FontWeight.bold),
//   //                         textAlign: TextAlign.center,
//   //                       ),
//   //                       // const SizedBox(height: 10),
//   //                       // Text(
//   //                       //   '${provider.timeTableData[index].hourtime ?? '-'}',
//   //                       //   style: TextStyles.fontStyle10
//   //                       //       .copyWith(fontWeight: FontWeight.bold),
//   //                       //   textAlign: TextAlign.center,
//   //                       // ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 // Session details sect
//   //                 Expanded(
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.symmetric(
//   //                         horizontal: 15, vertical: 10),
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Text(
//   //                           '${provider.timeTableData[index].subjectcode ?? '-'}',
//   //                           style: TextStyles.fontStyle8
//   //                               .copyWith(fontWeight: FontWeight.bold),
//   //                         ),
//   //                         const SizedBox(height: 5),
//   //                         Text(
//   //                           '${provider.timeTableData[index].subjectdesc ?? '-'}',
//   //                           style: TextStyles.fontStyle10
//   //                               .copyWith(color: Colors.black87),
//   //                         ),
//   //                         const SizedBox(height: 5),
//   //                         Text(
//   //                           '${provider.timeTableData[index].faculty ?? '-'}',
//   //                           style: TextStyles.fontStyle10
//   //                               .copyWith(color: Colors.black54),
//   //                         ),
//   //                         const SizedBox(height: 5),
//   //                         Text(
//   //                           '${provider.timeTableData[index].hourtime ?? '-'}',
//   //                           style: TextStyles.fontStyle10
//   //                               .copyWith(color: Colors.black54),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//
//   Widget cardDesignmonday(int index) {
//     final width = MediaQuery.of(context).size.width;
//     final provider = ref.watch(timetableProvider);
//
//     // Always filter for Monday
//     String targetDay = 'monday'; // Set the target day to Monday
//
//     // Filter data to show only Monday's entries
//     var mondayData = provider.timeTableData.where((data) {
//       return data.dayorderdesc?.toLowerCase() == targetDay;
//     }).toList();
//
//     // If no data is available for Monday, return an empty container
//     if (mondayData.isEmpty) {
//       return Container();
//     }
//
//     // Check if the index is valid
//     if (index < 0 || index >= mondayData.length) {
//       print(
//           "Invalid index: $index. Monday's data has only ${mondayData.length} entries.");
//       return Container(); // Or show a placeholder widget
//     }
//
//     // Use the data for Monday
//     var data = mondayData[index];
//
//     return GestureDetector(
//       onTap: () {
//         // Navigate or perform an action when the card is tapped
//       },
//       child: Column(
//         children: [
//           if (provider.timeTableData[index].hourtime == '09:30:00-10:30:00')
//             Padding(
//               padding: const EdgeInsets.only(top: 10, bottom: 10),
//               child: Container(
//                 width: width * 0.89,
//                 child: Card(
//                   elevation: 10,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${data.dayorderdesc ?? '-'}',
//                           style: TextStyles.fontStyle.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           const SizedBox(
//             height: 5,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 children: [
//                   // Time slot section
//                   Container(
//                     width: width * 0.20,
//                     padding: const EdgeInsets.symmetric(vertical: 40),
//                     decoration: BoxDecoration(
//                       border: Border(
//                         right: BorderSide(
//                           color: AppColors.theme07primaryColor,
//                           width: 6,
//                         ),
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${data.hourid ?? '-'}',
//                           style: TextStyles.fontStyle10
//                               .copyWith(fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                   // Session details section
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${data.subjectcode ?? '-'}',
//                             style: TextStyles.fontStyle8
//                                 .copyWith(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             '${data.subjectdesc ?? '-'}',
//                             style: TextStyles.fontStyle10
//                                 .copyWith(color: Colors.black87),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             '${data.faculty ?? '-'}',
//                             style: TextStyles.fontStyle10
//                                 .copyWith(color: Colors.black54),
//                           ),
//                           const SizedBox(height: 5),
//                           Text(
//                             '${provider.timeTableData[index].hourtime ?? '-'}',
//                             style: TextStyles.fontStyle10
//                                 .copyWith(color: Colors.black54),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   // Widget cardDesigntoday(int index) {
//   //   final width = MediaQuery.of(context).size.width;
//   //   final provider = ref.watch(timetableProvider);
//   //
//   //   // Get the current day of the week (e.g., Monday, Tuesday)
//   //   String currentDay = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
//   //
//   //   // Filter data to show only today's entries
//   //   var todayData = provider.timeTableData.where((data) {
//   //     return data.dayorderdesc?.toLowerCase() == currentDay;
//   //   }).toList();
//   //
//   //   // // Ensure we only show today's data if available
//   //   // if (todayData.isEmpty) {
//   //   //   return Container(); // Or show a message if no data is available for today
//   //   // }
//   //   //
//   //   // // Use the first entry of today's data
//   //   // var data = todayData[index];
//   //
//   //   if (todayData.isEmpty) {
//   //     return Container();
//   //   }
//   //
//   //   if (index < 0 || index >= todayData.length) {
//   //     print(
//   //         "Invalid index: $index. Today's data has only ${todayData.length} entries.");
//   //     return Container(); // Or show a placeholder widget
//   //   }
//   //
//   //   var data = todayData[index];
//   //
//   //   return GestureDetector(
//   //     onTap: () {
//   //       // Navigate or perform an action when the card is tapped
//   //     },
//   //     child: Column(
//   //       children: [
//   //         if (provider.timeTableData[index].hourtime == '09:30:00-10:30:00')
//   //           Padding(
//   //             padding: const EdgeInsets.only(top: 10, bottom: 10),
//   //             child: Container(
//   //               width: width * 0.89,
//   //               child: Card(
//   //                 elevation: 10,
//   //                 shape: RoundedRectangleBorder(
//   //                   borderRadius: BorderRadius.circular(10),
//   //                 ),
//   //                 child: Padding(
//   //                   padding: const EdgeInsets.symmetric(vertical: 10),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.center,
//   //                     children: [
//   //                       Text(
//   //                         '${data.dayorderdesc ?? '-'}',
//   //                         style: TextStyles.fontStyle.copyWith(
//   //                           fontWeight: FontWeight.bold,
//   //                         ),
//   //                       ),
//   //
//   //                       // Username Input
//   //                     ],
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ),
//   //         const SizedBox(
//   //           height: 5,
//   //         ),
//   //         Padding(
//   //           padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//   //           child: Container(
//   //             decoration: BoxDecoration(
//   //               color: Colors.white,
//   //               borderRadius: BorderRadius.circular(10),
//   //               boxShadow: [
//   //                 BoxShadow(
//   //                   color: Colors.grey.withOpacity(0.2),
//   //                   spreadRadius: 2,
//   //                   blurRadius: 5,
//   //                   offset: const Offset(0, 3),
//   //                 ),
//   //               ],
//   //             ),
//   //             child: Row(
//   //               children: [
//   //                 // Time slot section
//   //                 Container(
//   //                   width: width * 0.20,
//   //                   padding: const EdgeInsets.symmetric(vertical: 40),
//   //                   decoration: BoxDecoration(
//   //                     border: Border(
//   //                       right: BorderSide(
//   //                         color: AppColors.theme07primaryColor,
//   //                         width: 6,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.center,
//   //                     children: [
//   //                       // Text(
//   //                       //   '${data.dayorderdesc ?? '-'}',
//   //                       //   style: TextStyles.fontStyle10
//   //                       //       .copyWith(fontWeight: FontWeight.bold),
//   //                       //   textAlign: TextAlign.center,
//   //                       // ),
//   //                       // const SizedBox(height: 10),
//   //                       Text(
//   //                         '${data.hourid ?? '-'}',
//   //                         style: TextStyles.fontStyle10
//   //                             .copyWith(fontWeight: FontWeight.bold),
//   //                         textAlign: TextAlign.center,
//   //                       ),
//   //                       // const SizedBox(height: 10),
//   //                       // Text(
//   //                       //   '${data.hourtime ?? '-'}',
//   //                       //   style: TextStyles.fontStyle10
//   //                       //       .copyWith(fontWeight: FontWeight.bold),
//   //                       //   textAlign: TextAlign.center,
//   //                       // ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 // Session details section
//   //                 Expanded(
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.symmetric(
//   //                         horizontal: 15, vertical: 10),
//   //                     child: Column(
//   //                       crossAxisAlignment: CrossAxisAlignment.start,
//   //                       children: [
//   //                         Text(
//   //                           '${data.subjectcode ?? '-'}',
//   //                           style: TextStyles.fontStyle8
//   //                               .copyWith(fontWeight: FontWeight.bold),
//   //                         ),
//   //                         const SizedBox(height: 5),
//   //                         Text(
//   //                           '${data.subjectdesc ?? '-'}',
//   //                           style: TextStyles.fontStyle10
//   //                               .copyWith(color: Colors.black87),
//   //                         ),
//   //                         const SizedBox(height: 5),
//   //                         Text(
//   //                           '${data.faculty ?? '-'}',
//   //                           style: TextStyles.fontStyle10
//   //                               .copyWith(color: Colors.black54),
//   //                         ),
//   //                         const SizedBox(height: 5),
//   //                         Text(
//   //                           '${provider.timeTableData[index].hourtime ?? '-'}',
//   //                           style: TextStyles.fontStyle10
//   //                               .copyWith(color: Colors.black54),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//
// }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07TimetablePageScreen extends ConsumerStatefulWidget {
  const Theme07TimetablePageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07TimetablePageScreenState();
}

class _Theme07TimetablePageScreenState extends ConsumerState<Theme07TimetablePageScreen> {
  final ScrollController _listController = ScrollController();
  int _initialIndex = 0; // Default to Monday

  @override
  void initState() {
    super.initState();
    _initialIndex = _getCurrentDayIndex();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(timetableProvider.notifier).getTimeTableDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  int _getCurrentDayIndex() {
    final now = DateTime.now();
    final currentDay = now.weekday; // 1 (Monday) to 7 (Sunday)
    return currentDay - 1; // Convert to 0-based index (0: Monday, 4: Friday)
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(profileProvider);
    final width = MediaQuery.of(context).size.width;
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return DefaultTabController(
      length: 6, // Monday to Friday
      initialIndex: _initialIndex, // Set the initial index to today's day
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'TIMETABLE',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  _initialIndex = _getCurrentDayIndex();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref.read(timetableProvider.notifier).getTimeTableDetails(
                          ref.read(encryptionProvider.notifier),
                        );
                  });
                },
                icon: const Icon(
                  Icons.refresh,
                  size: 30,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 2 - 80,
                            child: Text(
                              'Academic Year',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                            ),
                          ),
                          Text(
                            ':',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: width / 2 - 60,
                            child: Text(
                              '${provider.profileDataHive.academicyear}' == ''
                                  ? '-'
                                  : '${provider.profileDataHive.academicyear}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 2 - 80,
                            child: Text(
                              'Semester',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                            ),
                          ),
                          Text(
                            ':',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: width / 2 - 60,
                            child: Text(
                              '${provider.profileDataHive.semester}' == ''
                                  ? '-'
                                  : '${provider.profileDataHive.semester}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary.withAlpha(180), // Match the AppBar color
                  borderRadius: BorderRadius.circular(40), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14), // Adjust padding
                child: TabBar(
                  dividerColor: Colors.transparent,
                  labelColor: Colors.white, // Text color for the selected tab
                  unselectedLabelColor: Colors.white.withAlpha(180), // Text color for unselected tabs
                  indicator: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary, // Background color for the selected tab
                    borderRadius: BorderRadius.circular(20), // Rounded corners for the indicator
                  ),
                  indicatorSize: TabBarIndicatorSize.tab, // Make the indicator cover the entire tab
                  indicatorPadding: const EdgeInsets.symmetric(vertical: 6), // Reduce height of the indicator
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto', // Custom font
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Roboto', // Custom font
                  ),
                  tabs: const [
                    Tab(child: Text('Mon', style: TextStyle(fontSize: 10))),
                    Tab(child: Text('Tue', style: TextStyle(fontSize: 10))),
                    Tab(child: Text('Wed', style: TextStyle(fontSize: 10))),
                    Tab(child: Text('Thu', style: TextStyle(fontSize: 10))),
                    Tab(child: Text('Fri', style: TextStyle(fontSize: 10))),
                    Tab(child: Text('Sat', style: TextStyle(fontSize: 10))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildDayTimetable('monday'), // Monday
                  _buildDayTimetable('tuesday'), // Tuesday
                  _buildDayTimetable('wednesday'), // Wednesday
                  _buildDayTimetable('thursday'), // Thursday
                  _buildDayTimetable('friday'), // Friday
                  _buildDayTimetable('Saturday'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayTimetable(String day) {
    final provider = ref.watch(timetableProvider);
    final dayDataLength = provider.timeTableData
        .where(
          (data) => data.dayorderdesc?.toLowerCase() == day,
        )
        .length;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (provider is TimetableLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              )
            else if (provider.timeTableData.isEmpty && provider is! TimetableLoading)
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  Center(
                    child: Text(
                      'No List Added Yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              )
            else
              ListView.builder(
                itemCount: dayDataLength != 0
                    ? provider.timeTableData
                        .where(
                          (data) => data.dayorderdesc?.toLowerCase() == day.toLowerCase(),
                        )
                        .length
                    : 1,
                controller: _listController,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cardDesign(day, index);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget cardDesign(String day, int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(timetableProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    // Filter data for the specific day
    final dayData =
        provider.timeTableData.where((data) => data.dayorderdesc?.toLowerCase() == day.toLowerCase()).toList();
    log('$day >>>> $dayData');

    // If no data is available for the day, return an empty container
    if (dayData.isEmpty) {
      return Center(
        child: Text(
          'No Timetable Sheduled on $day',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      );
    }

    // Check if the index is valid
    if (index < 0 || index >= dayData.length) {
      print("Invalid index: $index. $day's data has only ${dayData.length} entries.");
      return Container(); // Or show a placeholder widget
    }

    // Use the data for the specific day
    final data = dayData[index];

    return GestureDetector(
      onTap: () {
        // Navigate or perform an action when the card is tapped
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Container(
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),

                  Container(
                    width: width * 0.15,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.inverseSurface.withAlpha(20), // Border color
                        width: 0.5, // Border width
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          data.hourid ?? '-',
                          style: TextStyles.fontStyle8.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(200),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // Session details section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   '${data.subjectcode ?? '-'}',
                          //   style: TextStyles.fontStyle8
                          //       .copyWith(fontWeight: FontWeight.bold),
                          // ),
                          const SizedBox(height: 5),
                          Text(
                            data.subjectdesc ?? '-',
                            style: TextStyles.fontStyle10.copyWith(
                              color: Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data.faculty ?? '-',
                            style: TextStyles.fontStyle10.copyWith(
                              color: Theme.of(context).colorScheme.inverseSurface.withAlpha(200),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              //    const  Icon(
                              //   Icons.login,
                              //   color:Colors.black54,
                              //   size: 18,
                              // ),
                              Image.asset(
                                'assets/images/out.png',
                                width: MediaQuery.of(context).size.width / 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                data.hourtime ?? '-',
                                style: TextStyles.fontStyle10.copyWith(
                                  color: Theme.of(context).colorScheme.inverseSurface.withAlpha(200),
                                ),
                              ),
                            ],
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
}
