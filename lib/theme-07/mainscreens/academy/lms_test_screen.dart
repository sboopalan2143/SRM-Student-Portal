import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme07McqTestViewPage extends ConsumerStatefulWidget {
  const Theme07McqTestViewPage({
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
      _Theme07McqTestViewPageState();
}

class _Theme07McqTestViewPageState
    extends ConsumerState<Theme07McqTestViewPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  final Map<int, String> selectedAnswers = {};
  final answerSelected = <String>[];

  String singleString = '';

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);


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
      backgroundColor: AppColors.theme07secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme07primaryColor,
                  AppColors.theme07primaryColor,
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
          title: Text(
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
      ),
      body: SingleChildScrollView(
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
                    Center(
                      child: Text(
                        'No List Added Yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
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
              if (provider.mcqQuestionAndAnswerData.isNotEmpty)
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

                          // await Navigator.push(
                          //   context,
                          //   RouteDesign(
                          //     route: const Theme02McqGetAnswerPage(),
                          //   ),
                          // );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme02secondaryColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyles.fontStyle13,
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
                  style: TextStyles.theme02fontStyle2,
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
                        activeColor: AppColors.primaryColor,
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
