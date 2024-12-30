import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme02CumulativeAttendancePage extends ConsumerStatefulWidget {
  const Theme02CumulativeAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02CumulativeAttendancePageState();
}

class _Theme02CumulativeAttendancePageState
    extends ConsumerState<Theme02CumulativeAttendancePage> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(cummulativeAttendanceProvider.notifier)
            .getCummulativeAttendanceDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref
            .read(cummulativeAttendanceProvider.notifier)
            .getHiveCummulativeDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(cummulativeAttendanceProvider.notifier)
          .getHiveCummulativeDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = ref.watch(cummulativeAttendanceProvider);
    log('cumlative log >> ${provider.cummulativeHiveAttendanceData.length}');
    ref.listen(cummulativeAttendanceProvider, (previous, next) {
      if (next is CummulativeAttendanceStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is CummulativeAttendanceStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
            'CUMMULAT ATTENDANCE',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () async {
                  await ref
                      .read(cummulativeAttendanceProvider.notifier)
                      .getCummulativeAttendanceDetails(
                        ref.read(encryptionProvider.notifier),
                      );
                  await ref
                      .read(cummulativeAttendanceProvider.notifier)
                      .getHiveCummulativeDetails('');
                },
                child: const Icon(
                  Icons.refresh,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
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
              if (provider is CummulativeAttendanceStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.cummulativeHiveAttendanceData.isEmpty &&
                  provider is! CummulativeAttendanceStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.alertContentStyle,
                      ),
                    ),
                  ],
                ),
              if (provider.cummulativeHiveAttendanceData.isNotEmpty)
                const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  itemCount: provider.cummulativeHiveAttendanceData.length,
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

    final provider = ref.watch(cummulativeAttendanceProvider);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.theme02primaryColor,
            AppColors.theme02secondaryColor1,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width / 2.5,
                  child: Text(
                    '${provider.cummulativeHiveAttendanceData[index].attendancemonthyear}' ==
                            ''
                        ? '-'
                        : '${provider.cummulativeHiveAttendanceData[index].attendancemonthyear}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: width / 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.how_to_reg,
                        color: AppColors.greenColor,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${provider.cummulativeHiveAttendanceData[index].present}' ==
                                ''
                            ? '-'
                            : '${provider.cummulativeHiveAttendanceData[index].present}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: width / 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.person_off,
                        color: AppColors.theme02buttonColor2,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${provider.cummulativeHiveAttendanceData[index].absent}' ==
                                ''
                            ? '-'
                            : '${provider.cummulativeHiveAttendanceData[index].absent}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(thickness: 2, color: AppColors.grey1),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                        child: Icon(
                          Icons.medical_services,
                          color: AppColors.theme02buttonColor2,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: width / 3 - 100,
                        child: Text(
                          '${provider.cummulativeHiveAttendanceData[index].medical}' ==
                                  ''
                              ? '-'
                              : '${provider.cummulativeHiveAttendanceData[index].medical}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                        child: Text(
                          'OD',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.greenColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.how_to_reg,
                        color: AppColors.greenColor,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: width / 3 - 100,
                        child: Text(
                          '${provider.cummulativeHiveAttendanceData[index].odpresent}' ==
                                  ''
                              ? '-'
                              : '${provider.cummulativeHiveAttendanceData[index].odpresent}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 30,
                        child: Text(
                          'OD',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.redColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.person_off,
                        color: AppColors.theme02buttonColor2,
                        size: 25,
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: width / 3 - 100,
                        child: Text(
                          '${provider.cummulativeHiveAttendanceData[index].odabsent}' ==
                                  ''
                              ? '-'
                              : '${provider.cummulativeHiveAttendanceData[index].odpresent}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          // textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(thickness: 2, color: AppColors.grey1),
          ],
        ),
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.only(bottom: 8),
    //   child: Container(
    //     // elevation: 0,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: const BorderRadius.all(Radius.circular(20)),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.2),
    //           spreadRadius: 5,
    //           blurRadius: 7,
    //           offset: const Offset(0, 3),
    //         ),
    //       ],
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: width / 2 - 80,
    //             child: const Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Text(
    //                   'Month/Year',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'Present',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'Absent',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'OD Present',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'OD Absent',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'Medical',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //             ],
    //           ),
    //           const SizedBox(width: 5),
    //           SizedBox(
    //             width: width / 2 - 60,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   '''${provider.cummulativeHiveAttendanceData[index].attendancemonthyear}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.cummulativeHiveAttendanceData[index].present}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.cummulativeHiveAttendanceData[index].absent}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.cummulativeHiveAttendanceData[index].odpresent}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.cummulativeHiveAttendanceData[index].odabsent}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.cummulativeHiveAttendanceData[index].medical}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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
