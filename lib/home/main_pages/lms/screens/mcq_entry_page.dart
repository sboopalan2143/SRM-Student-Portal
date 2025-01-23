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
import 'package:sample/home/main_pages/lms/screens/mcq_test_view.dart';
import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class McqEnteryPage extends ConsumerStatefulWidget {
  const McqEnteryPage({
    required this.mcqscheduleid,
    super.key,
  });

  final String mcqscheduleid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _McqEnteryPageState();
}

class _McqEnteryPageState extends ConsumerState<McqEnteryPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmsMcqSheduleDetails(
              ref.read(encryptionProvider.notifier),
              widget.mcqscheduleid,
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
      ref.read(lmsProvider.notifier).getLmsMcqSheduleDetails(
            ref.read(encryptionProvider.notifier),
            widget.mcqscheduleid,
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
                        onTap: () {
                          ref
                              .read(lmsProvider.notifier)
                              .getLmsMcqSheduleDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.mcqscheduleid,
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
              else if (provider.mcqSheduleData.isEmpty &&
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
              if (provider.mcqSheduleData.isNotEmpty)
                ListView.builder(
                  itemCount: provider.mcqSheduleData.length,
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(lmsProvider);

    return GestureDetector(
      onTap: () {
        // ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
        //       ref.read(encryptionProvider.notifier),
        //       '${provider.mcqSheduleData[index].classworkid}',
        //     );

        // Navigator.push(
        //   context,
        //   RouteDesign(
        //     route: LmsAttachmentDetailsDataPage(
        //       classworkID: '${provider.mcqSheduleData[index].classworkid}',
        //     ),
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text('MCQ Entry ', style: TextStyles.titleFontStyle),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Work Type : ',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                      Text(
                        'MCQ',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Last Submission Date : ',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                      Expanded(
                        child: Text(
                          '${provider.mcqSheduleData[index].date}',
                          style: TextStyles.smallBlackColorFontStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Test : ',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                      Text(
                        '${provider.mcqSheduleData[index].subjectid}',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'no of questions: ',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                      Text(
                        '${provider.mcqSheduleData[index].noofquestions}',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const BlinkText(
                    'New',
                    style: TextStyles.fontStyle6,
                    endColor: Colors.redAccent,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                RouteDesign(
                                  route: McqTestViewPage(
                                      mcqscheduleid:
                                          '${provider.mcqSheduleData[index].scheduleid}',
                                      mcqtemplateid:
                                          '${provider.mcqSheduleData[index].mcqtemplateid}',
                                      subjectid:
                                          '${provider.mcqSheduleData[index].subjectid}',
                                      noofquestions:
                                          '${provider.mcqSheduleData[index].noofquestions}',
                                      marksperquestion:
                                          '${provider.mcqSheduleData[index].marksperquestions}'),
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
                                      'Take test',
                                      style: TextStyles.fontStyle5,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          width: 150,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   RouteDesign(
                              //     route: const McqEnteryPage(),
                              //   ),
                              // );
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
                                      'Top 3',
                                      style: TextStyles.fontStyle5,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
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
