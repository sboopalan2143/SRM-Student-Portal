import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/time_table_state.dart';

class Theme07TimetablePageScreen extends ConsumerStatefulWidget {
  const Theme07TimetablePageScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07TimetablePageScreenState();
}

class _Theme07TimetablePageScreenState
    extends ConsumerState<Theme07TimetablePageScreen> {
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
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.theme07secondaryColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.theme07primaryColor,
                    AppColors.theme07primaryColor,
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
              'TIMETABLE',
              style: TextStyles.fontStyle4,
              overflow: TextOverflow.clip,
            ),
            centerTitle: true,
            bottom:const  TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: AppColors.lightAshColor,
              indicatorColor: Colors.white,
              tabs:  [
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
                          color: AppColors.theme07primaryColor,
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
  //                     color: AppColors.theme07primaryColor,
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
                          color: AppColors.theme07primaryColor,
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
//                     color: AppColors.theme07primaryColor,
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
