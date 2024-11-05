import 'dart:async';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/main_pages/lms/screens/lms_classworkdetail_screen.dart';
import 'package:sample/home/main_pages/lms/screens/lms_comment_screen.dart';
import 'package:sample/home/main_pages/lms/screens/lms_example_chatting_screen.dart';
import 'package:sample/home/main_pages/lms/screens/lms_Faculty_comment_screen.dart';
import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class LmsTitlePage extends ConsumerStatefulWidget {
  const LmsTitlePage({
    required this.subjectID,
    super.key,
  });
  final String subjectID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LmsTitlePageState();
}

class _LmsTitlePageState extends ConsumerState<LmsTitlePage> {
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
        ref.read(lmsProvider.notifier).getLmsTitleDetails(
              ref.read(encryptionProvider.notifier),
              widget.subjectID,
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
      ref.read(lmsProvider.notifier).getLmsTitleDetails(
            ref.read(encryptionProvider.notifier),
            widget.subjectID,
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
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
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
                  ref.read(lmsProvider.notifier).getLmsSubgetDetails(
                        ref.read(encryptionProvider.notifier),
                      );
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   RouteDesign(
                  //     route: const HomePage2(),
                  //   ),
                  // );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'LMS Title',
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
                          ref.read(lmsProvider.notifier).getLmsTitleDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.subjectID,
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
                else if (provider.lmsTitleData.isEmpty &&
                    provider is! LibraryTrancsactionStateLoading)
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
                if (provider.lmsTitleData.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.lmsTitleData.length,
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
    return GestureDetector(
      onTap: () {
        ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
              ref.read(encryptionProvider.notifier),
              '${provider.lmsTitleData[index].classworkid}',
            );

        Navigator.push(
          context,
          RouteDesign(
            route: LmsClassworkDetailPage(
              classworkID: '${provider.lmsTitleData[index].classworkid}',
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
                if (provider.lmsTitleData[index].newwork != '0')
                  const BlinkText(
                    'New',
                    style: TextStyles.fontStyle6,
                    endColor: Colors.redAccent,
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          '${provider.lmsTitleData[index].title}' == 'null'
                              ? '-'
                              : '''${provider.lmsTitleData[index].title}''',
                          style: TextStyles.fontStyle6,
                        ),
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
                        'Start date time',
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
                        '${provider.lmsTitleData[index].startdatetime}' ==
                                'null'
                            ? '-'
                            : '''${provider.lmsTitleData[index].startdatetime}''',
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
                        'End date time',
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
                        '${provider.lmsTitleData[index].enddatetime}' == 'null'
                            ? '-'
                            : '''${provider.lmsTitleData[index].enddatetime}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width / 2 - 80,
                //       child: const Text(
                //         'Classwork Id',
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //     const Text(
                //       ':',
                //       style: TextStyles.fontStyle10,
                //     ),
                //     const SizedBox(width: 5),
                //     SizedBox(
                //       width: width / 2 - 60,
                //       child: Text(
                //         '${provider.lmsTitleData[index].classworkid}' == 'null'
                //             ? '-'
                //             : '''${provider.lmsTitleData[index].classworkid}''',
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'Classwork type desc',
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
                        '${provider.lmsTitleData[index].classworktypedesc}' ==
                                'null'
                            ? '-'
                            : '''${provider.lmsTitleData[index].classworktypedesc}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 70,
                      child: GestureDetector(
                        onTap: () {
                          ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
                                ref.read(encryptionProvider.notifier),
                                '${provider.lmsTitleData[index].classworkid}',
                              );

                          Navigator.push(
                            context,
                            RouteDesign(
                              route: LmsClassworkDetailPage(
                                classworkID:
                                    '${provider.lmsTitleData[index].classworkid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'View',
                                  style: TextStyles.fontStyle5,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // if (provider.lmsTitleData[index].classcomment != '0')
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                RouteDesign(
                                  route: LmsCommentScreen(
                                    classworkID:
                                        '${provider.lmsTitleData[index].classworkid}',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Comments',
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
                    Column(
                      children: [
                        if (provider.lmsTitleData[index].privatecomment != '0')
                          SizedBox(
                            height: 30,
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  RouteDesign(
                                    route: LmsFacultyCommentScreen(
                                      classworkID:
                                          '${provider.lmsTitleData[index].classworkid}',
                                      // studentclassworkcommentid:
                                      //     '${provider.lmsfacultygetcommentData[index].studentclassworkcommentid}',
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'faculty chat',
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
