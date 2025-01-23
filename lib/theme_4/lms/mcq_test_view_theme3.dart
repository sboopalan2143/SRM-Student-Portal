import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme_3/lms/mcq_getanswer_data_theme3.dart';
import 'package:sample/theme_4/lms/mcq_getanswer_data_theme3.dart';

class McqTestViewPageTheme4 extends ConsumerStatefulWidget {
  const McqTestViewPageTheme4({
    required this.mcqtemplateid,
    required this.mcqscheduleid,
    required this.subjectid,
    required this.noofquestions,
    required this.marksperquestion,
    super.key,
  });

  final String mcqtemplateid;
  final String mcqscheduleid;
  final String subjectid;
  final String noofquestions;
  final String marksperquestion;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _McqTestViewPageTheme4State();
}

class _McqTestViewPageTheme4State extends ConsumerState<McqTestViewPageTheme4> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  final Map<int, String> selectedAnswers = {};
  final answerSelected = <String>[];

  String singleString = '';

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmsMcqQuestionandAnswerDetails(
              ref.read(encryptionProvider.notifier),
              widget.mcqscheduleid,
              widget.mcqtemplateid,
              widget.subjectid,
              widget.noofquestions,
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
      ref.read(lmsProvider.notifier).getLmsMcqQuestionandAnswerDetails(
            ref.read(encryptionProvider.notifier),
            widget.mcqscheduleid,
            widget.mcqtemplateid,
            widget.subjectid,
            widget.noofquestions,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(lmsProvider);

    ref.listen(lmsProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.secondaryColorTheme3,
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
                  ref.read(lmsProvider.notifier).getLmsSubgetDetails(
                        ref.read(encryptionProvider.notifier),
                      );
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Mcq Take Test',
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
                              .read(lmsProvider.notifier)
                              .getLmsMcqQuestionandAnswerDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.mcqscheduleid,
                                widget.mcqtemplateid,
                                widget.subjectid,
                                widget.noofquestions,
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
        onRefresh: _handleRefresh,
        color: AppColors.primaryColorTheme3,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                if (provider is LibraryTrancsactionStateLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircularProgressIndicators
                          .primaryColorProgressIndication,
                    ),
                  )
                else if (provider.mcqQuestionAndAnswerData.isEmpty &&
                    provider is! LibraryTrancsactionStateLoading)
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
                if (provider.mcqQuestionAndAnswerData.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.mcqQuestionAndAnswerData.length,
                    controller: _listController,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return cardDesign(index);
                    },
                  ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(lmsProvider.notifier)
                              .getMcqAnswerDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(lmsProvider.notifier)
                              .saveMCQAnswerDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.mcqscheduleid,
                                singleString,
                                widget.marksperquestion,
                              );

                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const McqGetAnswerPageTheme4(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme4color2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyles.fontStyle5,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(lmsProvider);
    final answers = provider.mcqQuestionAndAnswerData[index].answer!;
    final answerOptions = answers.split(',').map((e) => e.split('~')).toList();

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question No. ${index + 1}',
                  style: TextStyles.fontStyle10,
                ),
                const SizedBox(height: 10),
                Text(
                  provider.mcqQuestionAndAnswerData[index].questiondesc ?? '-',
                  style: TextStyles.fontStyle10,
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    for (int j = 0; j < answerOptions.length; j++)
                      RadioListTile<String>(
                        title: Text(
                          '${j + 1}. ${answerOptions[j][1]}',
                          style: TextStyles.fontStyle10,
                        ),
                        value: answerOptions[j][1],
                        groupValue: selectedAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            selectedAnswers[index] = value!;
                            // answerSelected.add(
                            //   '''${provider.mcqQuestionAndAnswerData[index].questionid}~${answerOptions[j][0]}~${answerOptions[j][2]}~${provider.mcqQuestionAndAnswerData[index].mcqanswertype}~${answerOptions[j][1]}~-''',
                            // );

                            answerSelected.add(
                              '''${provider.mcqQuestionAndAnswerData[index].questionid!.trim()}~${answerOptions[j][0].trim()}~${answerOptions[j][2].trim()}~${provider.mcqQuestionAndAnswerData[index].mcqanswertype!.trim()}~${answerOptions[j][1].trim()}''',
                            );

                            singleString = answerSelected.join(',');
                          });
                        },
                        activeColor: AppColors.primaryColorTheme3,
                      ),
                  ],
                ),
              ],
            ),
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
