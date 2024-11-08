import 'dart:async';
import 'dart:developer';
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
import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class McqGetAnswerPage extends ConsumerStatefulWidget {
  const McqGetAnswerPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _McqGetAnswerPageState();
}

class _McqGetAnswerPageState extends ConsumerState<McqGetAnswerPage> {
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
        ref.read(lmsProvider.notifier).getMcqAnswerDetails(
              ref.read(encryptionProvider.notifier),
              // widget.mcqscheduleid,
              // widget.mcqexamid,
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
            // widget.mcqscheduleid,
            // widget.mcqexamid,
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
                'MCQ Answer Screen',
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
                          ref.read(lmsProvider.notifier).getMcqAnswerDetails(
                                ref.read(encryptionProvider.notifier),
                                // widget.mcqscheduleid,
                                // widget.mcqexamid,
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
                else if (provider.mcqgetAnswerDetails.isEmpty &&
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
                if (provider.mcqgetAnswerDetails.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.mcqgetAnswerDetails.length,
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
      onTap: () {
        // ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
        //       ref.read(encryptionProvider.notifier),
        //       '${provider.mcqgetAnswerDetails[index].classworkid}',
        //     );

        // Navigator.push(
        //   context,
        //   RouteDesign(
        //     route: LmsAttachmentDetailsDataPage(
        //       classworkID: '${provider.mcqgetAnswerDetails[index].classworkid}',
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
                        'answer',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                      Expanded(
                        child: Text(
                          '${provider.mcqgetAnswerDetails[index].answer}',
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
                        'answerid',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                      Text(
                        '${provider.mcqgetAnswerDetails[index].answerid}',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'mcqanswertype',
                        style: TextStyles.smallBlackColorFontStyle,
                      ),
                      Text(
                        '${provider.mcqgetAnswerDetails[index].mcqanswertype}',
                        style: TextStyles.smallBlackColorFontStyle,
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
