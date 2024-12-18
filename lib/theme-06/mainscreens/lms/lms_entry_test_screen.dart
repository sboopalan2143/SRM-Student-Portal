import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_mcq_test_screen.dart';
import 'package:sample/theme-06/mainscreens/lms/lms_mcq_test_screen.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class Theme06McqEnteryPage extends ConsumerStatefulWidget {
  const Theme06McqEnteryPage({
    required this.mcqscheduleid,
    super.key,
  });
  final String mcqscheduleid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06McqEnteryPageState();
}

class _Theme06McqEnteryPageState extends ConsumerState<Theme06McqEnteryPage> {
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
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
                    onTap: () {
                      ref.read(lmsProvider.notifier).getLmsMcqSheduleDetails(
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
                else if (provider.mcqSheduleData.isEmpty &&
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(lmsProvider);

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Stack(
          children: [
            // Card background
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    AppColors.theme06primaryColor,
                    AppColors.theme06primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'MCQ Entry',
                    style: TextStyles.theme01titleFontStyle.copyWith(
                      color: AppColors.theme02buttonColor2,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Work Type
                  Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: AppColors.theme02buttonColor2,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Work Type: ',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'MCQ',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Submission Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: AppColors.theme02buttonColor2,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Submission Date: ',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${provider.mcqSheduleData[index].date}',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.yellowAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Test Info
                  Row(
                    children: [
                      Icon(Icons.book,
                          color: AppColors.theme02buttonColor2, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Test: ',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${provider.mcqSheduleData[index].subjectid}',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.lightGreenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // No of Questions
                  Row(
                    children: [
                      Icon(
                        Icons.question_answer,
                        color: AppColors.theme02buttonColor2,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'No of Questions: ',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${provider.mcqSheduleData[index].noofquestions}',
                        style: TextStyles.smallBlackColorFontStyle.copyWith(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Take Test Button
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: Theme06McqTestViewPage(
                            mcqscheduleid:
                                '${provider.mcqSheduleData[index].scheduleid}',
                            mcqtemplateid:
                                '${provider.mcqSheduleData[index].mcqtemplateid}',
                            subjectid:
                                '${provider.mcqSheduleData[index].subjectid}',
                            noofquestions:
                                '${provider.mcqSheduleData[index].noofquestions}',
                            marksperquestion:
                                '${provider.mcqSheduleData[index].marksperquestions}',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Take Test',
                          style: TextStyles.buttonStyle01theme2.copyWith(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 10,
              right: 15,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.5),
                      blurRadius: 12,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'New',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
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
