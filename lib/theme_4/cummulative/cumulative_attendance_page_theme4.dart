import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

class CumulativeAttendancePageTheme4 extends ConsumerStatefulWidget {
  const CumulativeAttendancePageTheme4({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CumulativeAttendancePageTheme4State();
}

class _CumulativeAttendancePageTheme4State
    extends ConsumerState<CumulativeAttendancePageTheme4> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

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
        preferredSize: const Size.fromHeight(200),
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
            ColoredBox(
              color: Colors.transparent,
              child: Column(
                children: [
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.80,
                    child: const Text(
                      'CUMMULATIVE ATTENDANCE',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
        color: AppColors.theme4color1,
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
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(cummulativeAttendanceProvider);
    return Padding(
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
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: width / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.date_range,
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
                        color: AppColors.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                // width: width / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.date_range,
                      color: AppColors.redColor,
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
                        color: AppColors.redColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 15,
                      child: Icon(
                        Icons.medical_services,
                        color: AppColors.theme4color2,
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
                          color: AppColors.grey1,
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
                          color: AppColors.grey1,
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
                          color: AppColors.grey1,
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
