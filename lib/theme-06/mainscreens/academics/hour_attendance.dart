import 'dart:async';

import 'package:badges/badges.dart' as badges;
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

class Theme06HourAttendancePage extends ConsumerStatefulWidget {
  const Theme06HourAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06HourAttendancePageState();
}

class _Theme06HourAttendancePageState
    extends ConsumerState<Theme06HourAttendancePage> {
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
                    onTap: () async {
                      await ref
                          .read(hourwiseProvider.notifier)
                          .gethourwiseDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref
                          .read(hourwiseProvider.notifier)
                          .getHiveHourwise('');
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
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.theme02secondaryColor1,
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
                          width: width / 4.8,
                          child: const Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.grey1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            padding: const EdgeInsets.all(7),
                            badgeColor: AppColors.theme02buttonColor2,
                          ),
                          position: badges.BadgePosition.topEnd(top: -10),
                          badgeContent: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            padding: const EdgeInsets.all(7),
                            badgeColor: AppColors.theme02buttonColor2,
                          ),
                          position: badges.BadgePosition.topEnd(top: -10),
                          badgeContent: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              '2',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            padding: const EdgeInsets.all(7),
                            badgeColor: AppColors.theme02buttonColor2,
                          ),
                          position: badges.BadgePosition.topEnd(top: -10),
                          badgeContent: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              '3',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            padding: const EdgeInsets.all(7),
                            badgeColor: AppColors.theme02buttonColor2,
                          ),
                          position: badges.BadgePosition.topEnd(top: -10),
                          badgeContent: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              '4',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            padding: const EdgeInsets.all(7),
                            badgeColor: AppColors.theme02buttonColor2,
                          ),
                          position: badges.BadgePosition.topEnd(top: -10),
                          badgeContent: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              '5',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.03),
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            padding: const EdgeInsets.all(7),
                            badgeColor: AppColors.theme02buttonColor2,
                          ),
                          position: badges.BadgePosition.topEnd(top: -10),
                          badgeContent: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Text(
                              '6',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
              else if (provider.listHourWiseHiveData.isEmpty &&
                  provider is! HourwiseStateLoading)
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
              if (provider.listHourWiseHiveData.isNotEmpty)
                const SizedBox(height: 5),
              ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            AppColors.theme06primaryColor,
                            AppColors.theme06primaryColor,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width / 3.5,
                              child: Text(
                                '${provider.listHourWiseHiveData[index].attendancedate}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: provider
                                            .listHourWiseHiveData[index].h1 ==
                                        'A'
                                    ? AppColors.redColor
                                    : provider.listHourWiseHiveData[index].h1 ==
                                            'P'
                                        ? AppColors.greenColor
                                        : AppColors.lightAshColor,
                              ),
                              position: badges.BadgePosition.topEnd(top: -10),
                              badgeContent: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '${provider.listHourWiseHiveData[index].h1}' ==
                                          'null'
                                      ? '-'
                                      : '${provider.listHourWiseHiveData[index].h1}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: provider
                                            .listHourWiseHiveData[index].h2 ==
                                        'A'
                                    ? AppColors.redColor
                                    : provider.listHourWiseHiveData[index].h2 ==
                                            'P'
                                        ? AppColors.greenColor
                                        : AppColors.lightAshColor,
                              ),
                              position: badges.BadgePosition.topEnd(top: -10),
                              badgeContent: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '${provider.listHourWiseHiveData[index].h2}' ==
                                          'null'
                                      ? '-'
                                      : '''${provider.listHourWiseHiveData[index].h2}''',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: provider
                                            .listHourWiseHiveData[index].h3 ==
                                        'A'
                                    ? AppColors.redColor
                                    : provider.listHourWiseHiveData[index].h3 ==
                                            'P'
                                        ? AppColors.greenColor
                                        : AppColors.lightAshColor,
                              ),
                              position: badges.BadgePosition.topEnd(top: -10),
                              badgeContent: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '${provider.listHourWiseHiveData[index].h3}' ==
                                          'null'
                                      ? '-'
                                      : '''${provider.listHourWiseHiveData[index].h3}''',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: provider
                                            .listHourWiseHiveData[index].h5 ==
                                        'A'
                                    ? AppColors.redColor
                                    : provider.listHourWiseHiveData[index].h5 ==
                                            'P'
                                        ? AppColors.greenColor
                                        : AppColors.lightAshColor,
                              ),
                              position: badges.BadgePosition.topEnd(top: -10),
                              badgeContent: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '${provider.listHourWiseHiveData[index].h5}' ==
                                          'null'
                                      ? '-'
                                      : '''${provider.listHourWiseHiveData[index].h5}''',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: provider
                                            .listHourWiseHiveData[index].h6 ==
                                        'A'
                                    ? AppColors.redColor
                                    : provider.listHourWiseHiveData[index].h6 ==
                                            'P'
                                        ? AppColors.greenColor
                                        : AppColors.lightAshColor,
                              ),
                              position: badges.BadgePosition.topEnd(top: -10),
                              badgeContent: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '${provider.listHourWiseHiveData[index].h6}' ==
                                          'null'
                                      ? '-'
                                      : '''${provider.listHourWiseHiveData[index].h6}''',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: provider
                                            .listHourWiseHiveData[index].h7 ==
                                        'A'
                                    ? AppColors.redColor
                                    : provider.listHourWiseHiveData[index].h7 ==
                                            'P'
                                        ? AppColors.greenColor
                                        : AppColors.lightAshColor,
                              ),
                              position: badges.BadgePosition.topEnd(top: -10),
                              badgeContent: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  '${provider.listHourWiseHiveData[index].h7}' ==
                                          'null'
                                      ? '-'
                                      : '''${provider.listHourWiseHiveData[index].h7}''',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
