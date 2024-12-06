import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme02McqGetAnswerPage extends ConsumerStatefulWidget {
  const Theme02McqGetAnswerPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02McqGetAnswerPageState();
}

class _Theme02McqGetAnswerPageState
    extends ConsumerState<Theme02McqGetAnswerPage> {
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
        await ref.read(lmsProvider.notifier).getMcqAnswerDetails(
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
      ref.read(lmsProvider.notifier).getMcqAnswerDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(lmsProvider);
    ref.listen(examDetailsProvider, (previous, next) {
      if (next is ExamDetailsError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is ExamDetailsStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
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
                  AppColors.theme02primaryColor,
                  AppColors.theme02secondaryColor1,
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
            'MCQ Entry Screen',
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
                      await ref.read(lmsProvider.notifier).getMcqAnswerDetails(
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
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
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
              else if (provider.mcqgetAnswerDetails.isEmpty &&
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
              if (provider.mcqgetAnswerDetails.isNotEmpty)
                const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  itemCount: provider.mcqgetAnswerDetails.length,
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
    final provider = ref.watch(lmsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Material(
        elevation: 6,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.theme02primaryColor,
                AppColors.theme02secondaryColor1,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.question_answer,
                      color: AppColors.theme02buttonColor2,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Answer:',
                      style: TextStyles.fontStyle13.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  provider.mcqgetAnswerDetails[index].answer == 'null'
                      ? '-'
                      : '${provider.mcqgetAnswerDetails[index].answer}',
                  style: TextStyles.fontStyle2.copyWith(
                    fontSize: 14,
                    color: AppColors.theme02buttonColor2,
                  ),
                ),
                const Divider(thickness: 1, color: Colors.grey),
                const SizedBox(height: 8),
                _buildDetailRow(
                  Icons.confirmation_num,
                  'Answer ID:',
                  provider.mcqgetAnswerDetails[index].answerid,
                ),
                _buildDetailRow(
                  Icons.insert_drive_file,
                  'Question File Name:',
                  provider.mcqgetAnswerDetails[index].questionfilename,
                ),
                const SizedBox(height: 16),
                _buildCircularIndicator(
                  provider.mcqgetAnswerDetails[index].totalmarks,
                  provider.mcqgetAnswerDetails[index].yourmarks,
                ),
                const SizedBox(height: 16),
                _buildDetailRow(
                  Icons.edit,
                  'Your Answer:',
                  provider.mcqgetAnswerDetails[index].youranswer,
                ),
                _buildDetailRow(
                  Icons.verified,
                  'Valid Answer:',
                  provider.mcqgetAnswerDetails[index].youranswervalid,
                ),
                _buildDetailRow(
                  Icons.file_copy,
                  'Answer Filename:',
                  provider.mcqgetAnswerDetails[index].youranswerfilename,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.theme02buttonColor2),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyles.fontStyle13.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value == 'null' || value == null || value.isEmpty ? '-' : value,
              style: TextStyles.fontStyle13.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator(String? totalMarksStr, String? yourMarksStr) {
    double totalMarks = double.tryParse(totalMarksStr ?? '0') ?? 0;
    double yourMarks = double.tryParse(yourMarksStr ?? '0') ?? 0;
    double percentage = totalMarks > 0 ? (yourMarks / totalMarks) : 0;

    return Row(
      children: [
        const Text(
          'Total Marks : ',
          style: TextStyles.fontStyle3,
        ),
        const SizedBox(height: 10),
        Center(
          child: CircularPercentIndicator(
            radius: 40,
            lineWidth: 8,
            animation: true,
            percent: percentage.clamp(
              0.0,
              1.0,
            ),
            center: Text(
              '${(percentage * 100).toStringAsFixed(1)}%',
              style: TextStyles.fontStyletheme2
                  .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: AppColors.theme02buttonColor2,
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //   final provider = ref.watch(lmsProvider);

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
  //     child: Material(
  //       elevation: 5,
  //       shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
  //       borderRadius: BorderRadius.circular(20),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               AppColors.theme01secondaryColor1,
  //               AppColors.theme01secondaryColor2,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: ExpansionTile(
  //             title: Row(
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 100,
  //                   child: Text(
  //                     'Answer :',
  //                     style: TextStyles.buttonStyle01theme2,
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     '${provider.mcqgetAnswerDetails[index].answer}' == 'null'
  //                         ? '-'
  //                         : '''${provider.mcqgetAnswerDetails[index].answer}''',
  //                     style: TextStyles.fontStyle2,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             collapsedIconColor: AppColors.theme01primaryColor,
  //             iconColor: AppColors.theme01primaryColor,
  //             children: [
  //               Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
  //               _buildRow(
  //                 'Answer id :',
  //                 '${provider.mcqgetAnswerDetails[index].answerid}' == 'null'
  //                     ? '-'
  //                     : '''${provider.mcqgetAnswerDetails[index].answerid}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Question file name',
  //                 '${provider.mcqgetAnswerDetails[index].questionfilename}' ==
  //                         'null'
  //                     ? '-'
  //                     : '''${provider.mcqgetAnswerDetails[index].questionfilename}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Total marks',
  //                 '${provider.mcqgetAnswerDetails[index].totalmarks}' == 'null'
  //                     ? '-'
  //                     : '''${provider.mcqgetAnswerDetails[index].totalmarks}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Your answer',
  //                 '${provider.mcqgetAnswerDetails[index].youranswer}' == 'null'
  //                     ? '-'
  //                     : '''${provider.mcqgetAnswerDetails[index].youranswer}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Your marks',
  //                 '${provider.mcqgetAnswerDetails[index].yourmarks}' == 'null'
  //                     ? '-'
  //                     : '''${provider.mcqgetAnswerDetails[index].yourmarks}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Your answer valid',
  //                 '${provider.mcqgetAnswerDetails[index].youranswervalid}' ==
  //                         'null'
  //                     ? '-'
  //                     : '''${provider.mcqgetAnswerDetails[index].youranswervalid}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Your answer filename',
  //                 '${provider.mcqgetAnswerDetails[index].youranswerfilename}' ==
  //                         'null'
  //                     ? '-'
  //                     : '''${provider.mcqgetAnswerDetails[index].youranswerfilename}''',
  //                 width,
  //               ),
  //               const SizedBox(height: 20),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildRow(String title, String value, double width) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(
  //         width: width / 2 - 60,
  //         child: Text(
  //           title,
  //           style: TextStyles.buttonStyle01theme2,
  //         ),
  //       ),
  //       const Expanded(
  //         child: Text(
  //           ':',
  //           style: TextStyles.fontStyle2,
  //         ),
  //       ),
  //       const SizedBox(width: 5),
  //       SizedBox(
  //         width: width / 2 - 60,
  //         child: Text(
  //           value.isEmpty ? '-' : value,
  //           style: TextStyles.fontStyle2,
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
