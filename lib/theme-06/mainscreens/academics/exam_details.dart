import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme06ExamDetailsPageTheme extends ConsumerStatefulWidget {
  const Theme06ExamDetailsPageTheme({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06ExamDetailsPageThemeState();
}

class _Theme06ExamDetailsPageThemeState
    extends ConsumerState<Theme06ExamDetailsPageTheme> {
  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

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
  Widget build(
    BuildContext context,
  ) {
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
            'EXAM DETAILS',
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
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: AppColors.theme02secondaryColor1,
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
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: ListView.builder(
              //     itemCount: provider.examDetailsHiveData.length,
              //     controller: _listController,
              //     shrinkWrap: true,
              //     itemBuilder: (BuildContext context, int index) {
              //       return cardDesign(0);
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
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
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 1; i <= 6; i++) ...[
                          if (provider.examDetailsHiveData
                              .any((exam) => exam.semester == '$i')) ...[
                            ExpansionTile(
                              title: Text(
                                'Semester $i',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              children: [
                                for (final exam
                                    in provider.examDetailsHiveData.where(
                                  (exam) => exam.semester == '$i',
                                )) ...[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/examdetailstheme3.svg',
                                        color: AppColors.theme02buttonColor2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                30,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          exam.subjectdesc!.isEmpty
                                              ? '-'
                                              : '${exam.subjectdesc}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const SizedBox(width: 30),
                                      Expanded(
                                        child: Text(
                                          exam.subjectcode!.isEmpty
                                              ? 'subjectcode: -'
                                              : 'subjectcode: ${exam.subjectcode}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Text(
                                        exam.grade!.isEmpty
                                            ? 'GRADE: -'
                                            : 'GRADE: ${exam.grade}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Icon(
                                        Icons.grade,
                                        color: AppColors.theme02buttonColor2,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    children: [
                                      const SizedBox(width: 30),
                                      Expanded(
                                        child: Text(
                                          exam.semester!.isEmpty
                                              ? 'SEMESTER  -'
                                              : 'SEMESTER ${exam.semester}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Expanded(
                                        child: Text(
                                          exam.credit!.isEmpty
                                              ? 'CREDIT -'
                                              : 'CREDIT ${exam.credit}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(
                                    color: AppColors.grey4,
                                    height: 1,
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'INTERNAL',
                                            style: TextStyles.fontStyle3,
                                          ),
                                          const SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 50,
                                            lineWidth: 15,
                                            animation: true,
                                            animationDuration: 1000,
                                            percent: exam.internal != null &&
                                                    exam.internal!.isNotEmpty
                                                ? (double.tryParse(
                                                          exam.internal!,
                                                        ) ??
                                                        0.0) /
                                                    100.0
                                                : 0.0,
                                            center: Text(
                                              exam.internal!.isEmpty
                                                  ? '-'
                                                  : '${exam.internal}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor:
                                                AppColors.theme02buttonColor2,
                                            backgroundColor:
                                                AppColors.whiteColor,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        children: [
                                          const Text(
                                            'EXTERNAL',
                                            style: TextStyles.fontStyle3,
                                          ),
                                          const SizedBox(height: 10),
                                          CircularPercentIndicator(
                                            radius: 50,
                                            lineWidth: 15,
                                            animation: true,
                                            animationDuration: 1000,
                                            percent: exam.external != null &&
                                                    exam.external!.isNotEmpty
                                                ? (double.tryParse(
                                                          exam.external!,
                                                        ) ??
                                                        0.0) /
                                                    100.0
                                                : 0.0,
                                            center: Text(
                                              exam.external!.isEmpty
                                                  ? '-'
                                                  : '${exam.external}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.whiteColor,
                                              ),
                                            ),
                                            circularStrokeCap:
                                                CircularStrokeCap.round,
                                            progressColor:
                                                AppColors.theme02buttonColor2,
                                            backgroundColor:
                                                AppColors.whiteColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Divider(
                                    thickness: 2,
                                    color: AppColors.theme02secondaryColor1,
                                    height: 1,
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ],
                            ),
                          ],
                        ],
                      ],
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

  Widget cardDesign(int index) {
    final provider = ref.watch(examDetailsProvider);
    final internal = double.parse(
      '${provider.examDetailsHiveData[index].internal}',
    ); // Example number
    final internalResult = internal / 100;
    double.parse(
      '${provider.examDetailsHiveData[index].external}',
    ); // Example number
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loop through semesters (1 to 6)
            for (int i = 1; i <= 6; i++) ...[
              if (provider.examDetailsHiveData
                  .any((exam) => exam.semester == '$i')) ...[
                // ExpansionTile for each semester
                ExpansionTile(
                  title: Text(
                    'Semester $i',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    // Display items for the specific semester
                    for (final exam in provider.examDetailsHiveData
                        .where((exam) => exam.semester == '$i')) ...[
                      // Subject Description
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/images/examdetailstheme3.svg',
                            color: AppColors.theme02buttonColor2,
                            height: MediaQuery.of(context).size.height / 30,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              exam.subjectdesc!.isEmpty
                                  ? '-'
                                  : '${exam.subjectdesc}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Grade and Subject Code
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              exam.subjectcode!.isEmpty
                                  ? 'subjectcode: -'
                                  : 'subjectcode: ${exam.subjectcode}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            exam.grade!.isEmpty
                                ? 'GRADE: -'
                                : 'GRADE: ${exam.grade}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(
                            Icons.grade,
                            color: AppColors.theme02buttonColor2,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Semester and Credit
                      Row(
                        children: [
                          const SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              exam.semester!.isEmpty
                                  ? 'SEMESTER  -'
                                  : 'SEMESTER ${exam.semester}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              exam.credit!.isEmpty
                                  ? 'CREDIT -'
                                  : 'CREDIT ${exam.credit}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(
                        color: AppColors.grey4,
                        height: 1,
                      ),

                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'INTERNAL',
                                style: TextStyles.fontStyle3,
                              ),
                              const SizedBox(height: 10),
                              CircularPercentIndicator(
                                radius: 50,
                                lineWidth: 15,
                                animation: true,
                                animationDuration: 1000,
                                percent: internalResult,
                                center: Text(
                                  exam.internal!.isEmpty
                                      ? '-'
                                      : '${exam.internal}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: AppColors.theme02buttonColor2,
                                backgroundColor: AppColors.whiteColor,
                              ),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              const Text(
                                'EXTERNAL',
                                style: TextStyles.fontStyle3,
                              ),
                              const SizedBox(height: 10),
                              CircularPercentIndicator(
                                radius: 50,
                                lineWidth: 15,
                                animation: true,
                                animationDuration: 1000,
                                percent: internalResult,
                                center: Text(
                                  exam.external!.isEmpty
                                      ? '-'
                                      : '${exam.external}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: AppColors.theme02buttonColor2,
                                backgroundColor: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(
                        thickness: 2,
                        color: AppColors.theme02secondaryColor1,
                        height: 1,
                      ),

                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ],
            ],
          ],
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
