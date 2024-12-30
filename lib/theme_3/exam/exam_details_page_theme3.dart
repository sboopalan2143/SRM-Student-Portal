import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class ExamDetailsPageTheme3 extends ConsumerStatefulWidget {
  const ExamDetailsPageTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExamDetailsPageTheme3State();
}

class _ExamDetailsPageTheme3State extends ConsumerState<ExamDetailsPageTheme3> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(examDetailsProvider.notifier).getExamDetailsApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(examDetailsProvider.notifier).getHiveExamDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(examDetailsProvider.notifier).getHiveExamDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(examDetailsProvider);
    ref.listen(examDetailsProvider, (previous, next) {
      if (next is ExamDetailsError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      //  else if (next is ExamDetailsStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                'EXAM DETAILS',
                style: TextStyle(
                  fontSize: 18,
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
                              .read(examDetailsProvider.notifier)
                              .getExamDetailsApi(
                                ref.read(
                                  encryptionProvider.notifier,
                                ),
                              );
                          await ref
                              .read(examDetailsProvider.notifier)
                              .getHiveExamDetails('');
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
              if (provider is ExamDetailsStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.examDetailsHiveData.isEmpty &&
                  provider is! ExamDetailsStateLoading)
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
              if (provider.examDetailsHiveData.isNotEmpty)
                const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: provider.examDetailsHiveData.length,
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
    final provider = ref.watch(examDetailsProvider);
    final internal = double.parse(
        '${provider.examDetailsHiveData[index].internal}'); // Example number
    final internalResult = internal / 100;
    final external = double.parse(
        '${provider.examDetailsHiveData[index].external}'); // Example number
    final externalResult = external / 100;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.shield,
                color: AppColors.primaryColorTheme3,
                size: 20,
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 + 25,
                child: Text(
                  '${provider.examDetailsHiveData[index].subjectdesc}' == ''
                      ? '-'
                      : '${provider.examDetailsHiveData[index].subjectdesc}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: width / 6,
                child: Text(
                  '${provider.examDetailsHiveData[index].subjectcode}' == ''
                      ? '-'
                      : '${provider.examDetailsHiveData[index].subjectcode}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  '${provider.examDetailsHiveData[index].semester}' == ''
                      ? 'SEMESTER  -'
                      : 'SEMESTER ${provider.examDetailsHiveData[index].semester}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey4,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Text(
                  '${provider.examDetailsHiveData[index].semester}' == ''
                      ? 'CREDIT  -'
                      : 'CREDIT ${provider.examDetailsHiveData[index].semester}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.grey4,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${provider.examDetailsHiveData[index].grade}' == ''
                          ? 'GRADE  -'
                          : 'GRADE ${provider.examDetailsHiveData[index].grade}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey4,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(
                      width: 15,
                      child: Icon(
                        Icons.grade,
                        color: AppColors.grey4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              SizedBox(
                width: width / 2 - 100,
                child: const Text(
                  'INTERNAL',
                  style: TextStyles.fontStyle10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearPercentIndicator(
            trailing: Text(
              '${provider.examDetailsHiveData[index].internal}' == '' ||
                      '${provider.examDetailsHiveData[index].internal}' ==
                          'null'
                  ? '-'
                  : '${provider.examDetailsHiveData[index].internal}',
            ),
            width: MediaQuery.of(context).size.width - 90,
            animation: true,
            lineHeight: 15,
            animationDuration: 1500,
            percent: internalResult,
            barRadius: const Radius.circular(15),
            progressColor: AppColors.greenColorTheme3,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: width / 2 - 100,
                child: const Text(
                  'EXTERNAL',
                  style: TextStyles.fontStyle10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearPercentIndicator(
            trailing: Text(
              '${provider.examDetailsHiveData[index].external}' == '' ||
                      '${provider.examDetailsHiveData[index].external}' ==
                          'null'
                  ? '-'
                  : '${provider.examDetailsHiveData[index].external}',
            ),
            width: MediaQuery.of(context).size.width - 90,
            animation: true,
            lineHeight: 15,
            animationDuration: 1500,
            percent: externalResult,
            barRadius: const Radius.circular(15),
            progressColor: AppColors.greenColorTheme3,
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.grey4, height: 1),
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
