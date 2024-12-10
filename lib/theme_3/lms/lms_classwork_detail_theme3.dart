// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:developer';
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
import 'package:sample/theme_3/lms/lms_attachment_detail_theme3.dart';
import 'package:sample/theme_3/lms/lms_save_work_reply_theme3.dart';
import 'package:sample/theme_3/lms/lms_student_attachment_screen_theme3.dart';
import 'package:sample/theme_3/lms/mcq_entry_page_theme3.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class LmsClassworkDetailPageTheme3 extends ConsumerStatefulWidget {
  const LmsClassworkDetailPageTheme3({
    required this.classworkID,
    super.key,
  });
  final String classworkID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LmsClassworkDetailPageTheme3State();
}

class _LmsClassworkDetailPageTheme3State
    extends ConsumerState<LmsClassworkDetailPageTheme3> {
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
        ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
              ref.read(encryptionProvider.notifier),
              widget.classworkID,
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
      ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);
    ref.listen(lmsProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColorTheme3);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColorTheme3,
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
                'Class Work Details',
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
                          ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.classworkID,
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
                else if (provider.classWorkDetailsData.isEmpty &&
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
                if (provider.classWorkDetailsData.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.classWorkDetailsData.length,
                    controller: _listController,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return cardDesign(index);
                    },
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
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);
    log('mcqshedykeid >> ${provider.classWorkDetailsData[index].mcqscheduleid}');

    return GestureDetector(
      onTap: () {
        ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
              ref.read(encryptionProvider.notifier),
              '${provider.classWorkDetailsData[index].classworkid}',
            );

        Navigator.push(
          context,
          RouteDesign(
            route: LmsAttachmentDetailsDataPageTheme3(
              classworkID:
                  '${provider.classWorkDetailsData[index].classworkid}',
            ),
          ),
        );
      },
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
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Classwork Id',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].classworkid}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].classworkid}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Classwork reply Id',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].classworkreplyid}' ==
                                ''
                            ? '-'
                            : '${provider.classWorkDetailsData[index].classworkreplyid}',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Classwork typed desc',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].classworktypedesc}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].classworktypedesc}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Classwork type id',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].classworktypeid}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].classworktypeid}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Cnt',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].cnt}' == ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].cnt}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Dpend date time',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].dpenddatetime}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].dpenddatetime}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Dpstart date time',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].dpstartdatetime}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].dpstartdatetime}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Field requirement',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].fieldrequirement}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].fieldrequirement}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Instructions',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].instructions}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].instructions}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Mcqmarksperquestions',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].mcqmarksperquestions}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].mcqmarksperquestions}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Mcq min mark to pass',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].mcqminmarktopass}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].mcqminmarktopass}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Mcqtime limit',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].mcqtimelimit}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].mcqtimelimit}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Remarks',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].remarks}' == ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].remarks}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Stuimage attachment id',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].stuimageattachmentid}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].stuimageattachmentid}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Title Tam',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].titleTam}' == ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].titleTam}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Topic Tam',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].topicTam}' == ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].topicTam}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Title desc',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.classWorkDetailsData[index].topicdesc}' ==
                                ''
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].topicdesc}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
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
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   RouteDesign(
                          //     route: LmsStudentAttachmentDetailsDataPage(
                          //       classworkID:
                          //           '${provider.lmsTitleData[index].classworkid}',
                          //     ),
                          //   ),
                          // );
                          ref
                              .read(lmsProvider.notifier)
                              .getLmsStudentAttachmentDetails(
                                ref.read(encryptionProvider.notifier),
                                '${provider.classWorkDetailsData[index].classworkreplyid}',
                              );
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: LmsStudentAttachmentDataPageTheme3(
                                classworkreplyid:
                                    '${provider.classWorkDetailsData[index].classworkreplyid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorTheme3,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Student Attachments',
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
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: LmsSaveWorkReplayDataPageTheme3(
                                classworkID:
                                    '${provider.classWorkDetailsData[index].classworkid}',
                                classworkreplyid:
                                    '${provider.classWorkDetailsData[index].classworkreplyid}',
                                fieldrequirements:
                                    '${provider.classWorkDetailsData[index].fieldrequirement}',
                                imageattachmentid:
                                    '${provider.classWorkDetailsData[index].stuimageattachmentid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorTheme3,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Save Attachment',
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
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: McqEntryPageTheme3(
                                mcqscheduleid:
                                    '${provider.classWorkDetailsData[index].mcqscheduleid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorTheme3,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'MCQ Test',
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
