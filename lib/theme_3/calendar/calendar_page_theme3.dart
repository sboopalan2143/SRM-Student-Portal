import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class CalendarPageTheme3 extends ConsumerStatefulWidget {
  const CalendarPageTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CalendarPageTheme3State();
}

class _CalendarPageTheme3State extends ConsumerState<CalendarPageTheme3> {
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
        await ref
            .read(calendarProvider.notifier)
            .getCalendarDetails(ref.read(encryptionProvider.notifier));
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
        _showToast(context, next.successMessage, AppColors.greenColorTheme3);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColorTheme3,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: const Icon(
                  Icons.menu,
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
                              .getCalendarDetails(
                                  ref.read(encryptionProvider.notifier));
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
        color: AppColors.primaryColorTheme3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (provider is CalendarStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.calendarHiveData.isEmpty &&
                  provider is! CalendarStateLoading)
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
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        decoration: BoxDecoration(
          color: provider.calendarHiveData[index].holidaystatus == '0'
              ? AppColors.primaryColorTheme3
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    // width: width / 2 - 60,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 15,
                            child: Icon(
                              Icons.calendar_month,
                              color: provider.calendarHiveData[index]
                                          .holidaystatus ==
                                      '0'
                                  ? AppColors.whiteColor
                                  : AppColors.grey,
                            )),
                        const SizedBox(width: 20),
                        Text(
                          '${provider.calendarHiveData[index].day}' == ''
                              ? '-'
                              : '${provider.calendarHiveData[index].day}',
                          style: TextStyle(
                            fontSize: 25,
                            color: provider.calendarHiveData[index]
                                        .holidaystatus ==
                                    '0'
                                ? AppColors.whiteColor
                                : AppColors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    // width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].daystatus}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].daystatus}',
                      style: TextStyle(
                        fontSize: 20,
                        color: provider.calendarHiveData[index].holidaystatus ==
                                '0'
                            ? AppColors.whiteColor
                            : AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    // width: width / 2 - 60,
                    child: Text(
                      '${provider.calendarHiveData[index].semester}' == ''
                          ? '-'
                          : '${provider.calendarHiveData[index].semester} Semester',
                      style: TextStyle(
                        fontSize: 18,
                        color: provider.calendarHiveData[index].holidaystatus ==
                                '0'
                            ? AppColors.whiteColor
                            : AppColors.grey,
                      ),
                    ),
                  ),
                  Expanded(
                    // width: width / 2 - 20,
                    child: Text(
                      '${provider.calendarHiveData[index].weekdayno}' == ''
                          ? '-'
                          : 'Week Day No ${provider.calendarHiveData[index].weekdayno}',
                      style: TextStyle(
                        fontSize: 18,
                        color: provider.calendarHiveData[index].holidaystatus ==
                                '0'
                            ? AppColors.whiteColor
                            : AppColors.grey,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (provider.calendarHiveData[index].remarks != '' ||
                  provider.calendarHiveData[index].remarks != '-')
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 15,
                        child: Icon(
                          Icons.report,
                          color:
                              provider.calendarHiveData[index].holidaystatus ==
                                      '0'
                                  ? AppColors.whiteColor
                                  : AppColors.grey,
                        )),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: width / 1.5,
                      child: Text(
                        '${provider.calendarHiveData[index].remarks}' == ''
                            ? '-'
                            : '${provider.calendarHiveData[index].remarks}',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              provider.calendarHiveData[index].holidaystatus ==
                                      '0'
                                  ? AppColors.whiteColor
                                  : AppColors.grey,
                          fontWeight: FontWeight.bold,
                        ),
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
