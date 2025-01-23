import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/circular_progress_indicators.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme06AttendancePage extends ConsumerStatefulWidget {
  const Theme06AttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06AttendancePageState();
}

class _Theme06AttendancePageState extends ConsumerState<Theme06AttendancePage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  // static int refreshNum = 10;
  // Stream<int> counterStream =
  //     Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(attendanceProvider.notifier).getAttendanceDetails(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref
            .read(attendanceProvider.notifier)
            .getHiveAttendanceDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(attendanceProvider);

    ref.listen(attendanceProvider, (previous, next) {
      if (next is AttendanceStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
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
                  AppColors.theme06primaryColor,
                  AppColors.theme06primaryColor,
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
            'ATTENDANCE',
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
                          .read(attendanceProvider.notifier)
                          .getAttendanceDetails(
                            ref.read(
                              encryptionProvider.notifier,
                            ),
                          );
                      await ref
                          .read(attendanceProvider.notifier)
                          .getHiveAttendanceDetails('');
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
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: AppColors.theme02secondaryColor1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (provider is AttendanceStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.attendancehiveData.isEmpty &&
                  provider is! AttendanceStateLoading)
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
              if (provider.attendancehiveData.isNotEmpty)
                const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  itemCount: provider.attendancehiveData.length,
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

    final provider = ref.watch(attendanceProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.theme06primaryColor,
              AppColors.theme06primaryColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 + 40,
                    child: Text(
                      '${provider.attendancehiveData[index].subjectdesc}' == ''
                          ? '-'
                          : '${provider.attendancehiveData[index].subjectdesc}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '${provider.attendancehiveData[index].presentpercentage}' ==
                              ''
                          ? '-'
                          : '${provider.attendancehiveData[index].presentpercentage} %',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.theme02buttonColor2,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                          child: Icon(
                            Icons.numbers,
                            color: AppColors.grey4,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 2 - 120,
                          child: Text(
                            '${provider.attendancehiveData[index].subjectcode}' ==
                                    ''
                                ? '-'
                                : '${provider.attendancehiveData[index].subjectcode}',
                            style: const TextStyle(
                              fontSize: 14,
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
                        SizedBox(
                          width: 15,
                          child: Icon(
                            Icons.groups,
                            color: AppColors.theme02buttonColor2,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: width / 3 - 100,
                          child: Text(
                            '${provider.attendancehiveData[index].total}' == ''
                                ? '-'
                                : '${provider.attendancehiveData[index].total}',
                            style: const TextStyle(
                              fontSize: 14,
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
                        SizedBox(
                          width: 15,
                          child: Icon(
                            Icons.how_to_reg,
                            color: AppColors.theme02buttonColor2,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: width / 3 - 100,
                          child: Text(
                            '${provider.attendancehiveData[index].present}' ==
                                    ''
                                ? '-'
                                : '${provider.attendancehiveData[index].present}',
                            style: const TextStyle(
                              fontSize: 14,
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
                        SizedBox(
                          width: 15,
                          child: Icon(
                            Icons.person_off,
                            color: AppColors.theme02buttonColor2,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: width / 3 - 100,
                          child: Text(
                            '${provider.attendancehiveData[index].absent}' == ''
                                ? '-'
                                : '${provider.attendancehiveData[index].absent}',
                            style: const TextStyle(
                              fontSize: 14,
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
