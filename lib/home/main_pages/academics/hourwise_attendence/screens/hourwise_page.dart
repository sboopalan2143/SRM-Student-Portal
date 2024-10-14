import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/circular_progress_indicators.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/loading_wrapper.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';
import 'package:sample/home/main_pages/academics/screens/academics.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class HourAttendancePage extends ConsumerStatefulWidget {
  const HourAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HourAttendancePageState();
}

class _HourAttendancePageState extends ConsumerState<HourAttendancePage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(hourwiseProvider.notifier).gethourwiseDetails(
              ref.read(encryptionProvider.notifier),
            );
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hourwiseProvider.notifier).gethourwiseDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(hourwiseProvider);
    ref.listen(hourwiseProvider, (previous, next) {
      if (next is HourwiseError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is HourwiseStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
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
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const AcademicsPage(),
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
                'HOURWISE ATTENDANCE',
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
                        onTap: () {
                          ref
                              .read(hourwiseProvider.notifier)
                              .gethourwiseDetails(
                                ref.read(encryptionProvider.notifier),
                              );
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
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: width / 6,
                          child: const Text(
                            'Date',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '-',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '1',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '2',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '3',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11,
                          child: const Text(
                            '4',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11,
                          child: const Text(
                            '5',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11,
                          child: const Text(
                            '6',
                            style: TextStyles.fontStyle16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (provider is HourwiseStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.listHourWiseData.isEmpty &&
                  provider is! HourwiseStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle1,
                      ),
                    ),
                  ],
                ),
              if (provider.listHourWiseData.isNotEmpty)
                const SizedBox(height: 5),
              ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: provider.listHourWiseData.length,
                controller: _listController,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: LoadingWrapper(
                    isLoading: provider is HourwiseStateLoading,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
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
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 6,
                              child: Text(
                                '${provider.listHourWiseData[index].attendancedate}',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: width / 11.5,
                              child: const Text(
                                '-',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11.5,
                              child: Text(
                                '${provider.listHourWiseData[index].h1}' ==
                                        'null'
                                    ? '-'
                                    : '${provider.listHourWiseData[index].h1}',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11.5,
                              child: Text(
                                '${provider.listHourWiseData[index].h2}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseData[index].h2}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11.5,
                              child: Text(
                                '${provider.listHourWiseData[index].h3}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseData[index].h3}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11,
                              child: Text(
                                '${provider.listHourWiseData[index].h5}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseData[index].h5}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11,
                              child: Text(
                                '${provider.listHourWiseData[index].h6}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseData[index].h6}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11,
                              child: Text(
                                '${provider.listHourWiseData[index].h7}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseData[index].h7}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
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
