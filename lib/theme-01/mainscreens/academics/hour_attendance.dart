import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/circular_progress_indicators.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/loading_wrapper.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';

import 'package:sample/home/widgets/drawer_design.dart';

class Theme01HourAttendancePage extends ConsumerStatefulWidget {
  const Theme01HourAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01HourAttendancePageState();
}

class _Theme01HourAttendancePageState
    extends ConsumerState<Theme01HourAttendancePage> {
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
            .read(hourwiseProvider.notifier)
            .gethourwiseDetails(ref.read(encryptionProvider.notifier));
        await ref.read(hourwiseProvider.notifier).getHiveHourwise('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hourwiseProvider.notifier).getHiveHourwise('');
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
      backgroundColor: AppColors.theme01primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'HOURWISE ATTENDANCE',
                style: TextStyles.buttonStyle01theme4,
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
                              .read(hourwiseProvider.notifier)
                              .gethourwiseDetails(
                                  ref.read(encryptionProvider.notifier));
                          await ref
                              .read(hourwiseProvider.notifier)
                              .getHiveHourwise('');
                        },
                        child: Icon(
                          Icons.refresh,
                          color: AppColors.theme01primaryColor,
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
        color: AppColors.theme01primaryColor,
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
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '-',
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '1',
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '2',
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11.5,
                          child: const Text(
                            '3',
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11,
                          child: const Text(
                            '4',
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11,
                          child: const Text(
                            '5',
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 11,
                          child: const Text(
                            '6',
                            style: TextStyles.fontStyle13,
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
                        .theme01primaryColorProgressIndication,
                  ),
                )
              else if (provider.listHourWiseHiveData.isEmpty &&
                  provider is! HourwiseStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added',
                        style: TextStyles.fontStyle1,
                      ),
                    ),
                  ],
                ),
              if (provider.listHourWiseHiveData.isNotEmpty)
                const SizedBox(height: 5),
              ListView.builder(
                padding: const EdgeInsets.all(5),
                itemCount: provider.listHourWiseHiveData.length,
                controller: _listController,
                shrinkWrap: true,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: LoadingWrapper(
                    isLoading: provider is HourwiseStateLoading,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.theme01secondaryColor1,
                            AppColors.theme01secondaryColor2,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 6,
                              child: Text(
                                '${provider.listHourWiseHiveData[index].attendancedate}',
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
                                '${provider.listHourWiseHiveData[index].h1}' ==
                                        'null'
                                    ? '-'
                                    : '${provider.listHourWiseHiveData[index].h1}',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11.5,
                              child: Text(
                                '${provider.listHourWiseHiveData[index].h2}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseHiveData[index].h2}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11.5,
                              child: Text(
                                '${provider.listHourWiseHiveData[index].h3}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseHiveData[index].h3}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11,
                              child: Text(
                                '${provider.listHourWiseHiveData[index].h5}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseHiveData[index].h5}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11,
                              child: Text(
                                '${provider.listHourWiseHiveData[index].h6}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseHiveData[index].h6}''',
                                style: TextStyles.fontStyle16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: width / 11,
                              child: Text(
                                '${provider.listHourWiseHiveData[index].h7}' ==
                                        'null'
                                    ? '-'
                                    : '''${provider.listHourWiseHiveData[index].h7}''',
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
