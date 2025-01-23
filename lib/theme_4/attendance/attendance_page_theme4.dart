import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/circular_progress_indicators.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

class AttendancePageTheme4 extends ConsumerStatefulWidget {
  const AttendancePageTheme4({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttendancePageTheme4State();
}

class _AttendancePageTheme4State extends ConsumerState<AttendancePageTheme4> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

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
      backgroundColor: AppColors.secondaryColorTheme4,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.primaryColorTheme4.createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: SvgPicture.asset(
                'assets/images/wave.svg',
                fit: BoxFit.fill,
                width: double.infinity,
                color: AppColors.whiteColor,
                colorBlendMode: BlendMode.srcOut,
              ),
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const MainScreenPage4(),
                    ),
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
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
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
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: AppColors.theme4color1,
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
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(attendanceProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: AppColors.theme4color2.withOpacity(0.3),
              spreadRadius: 2,
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
                    // width: width / 2 + 40,
                    child: Text(
                      '${provider.attendancehiveData[index].subjectdesc}' == ''
                          ? '-'
                          : '${provider.attendancehiveData[index].subjectdesc}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.grey,
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
                    child: SizedBox(
                      width: width / 5,
                      child: Text(
                        '${provider.attendancehiveData[index].presentpercentage}' ==
                                ''
                            ? '-'
                            : '${provider.attendancehiveData[index].presentpercentage} %',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.theme4color3,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
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
                              color: AppColors.grey4,
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
                          width: 15,
                          child: Icon(
                            Icons.access_time_filled,
                            color: AppColors.theme4color2,
                            size: 22,
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
                              color: AppColors.grey4,
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
                          width: 15,
                          child: Icon(
                            Icons.av_timer,
                            color: AppColors.theme4color3,
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
                              color: AppColors.grey4,
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
                          width: 15,
                          child: Icon(
                            Icons.av_timer,
                            color: AppColors.redColor,
                            size: 22,
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
                              color: AppColors.grey4,
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
