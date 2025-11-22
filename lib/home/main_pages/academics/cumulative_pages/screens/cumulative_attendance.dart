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
import 'package:sample/home/main_pages/academics/screens/academics.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class CumulativeAttendancePage extends ConsumerStatefulWidget {
  const CumulativeAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CumulativeAttendancePageState();
}

class _CumulativeAttendancePageState extends ConsumerState<CumulativeAttendancePage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(cummulativeAttendanceProvider.notifier).getCummulativeAttendanceDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(cummulativeAttendanceProvider.notifier).getHiveCummulativeDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(cummulativeAttendanceProvider.notifier).getHiveCummulativeDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
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
              title: Text(
                'CUMMULATIVE ATTENDANCE',
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
                          await ref.read(cummulativeAttendanceProvider.notifier).getCummulativeAttendanceDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref.read(cummulativeAttendanceProvider.notifier).getHiveCummulativeDetails('');
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (provider is CummulativeAttendanceStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicators.primaryColorProgressIndication,
                ),
              )
            else if (provider.cummulativeHiveAttendanceData.isEmpty && provider is! CummulativeAttendanceStateLoading)
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  Center(
                    child: Text(
                      'No List Added Yet!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
            if (provider.cummulativeHiveAttendanceData.isNotEmpty) const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(cummulativeAttendanceProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        // elevation: 0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
          child: Row(
            children: [
              SizedBox(
                width: width / 2 - 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Month/Year',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Present',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Absent',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'OD Present',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'OD Absent',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Medical',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''${provider.cummulativeHiveAttendanceData[index].attendancemonthyear}''',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeHiveAttendanceData[index].present}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeHiveAttendanceData[index].absent}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeHiveAttendanceData[index].odpresent}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeHiveAttendanceData[index].odabsent}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeHiveAttendanceData[index].medical}',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
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
