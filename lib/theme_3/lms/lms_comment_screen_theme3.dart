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
// import 'package:sample/home/riverpod/main_state.dart';

class LmsCommentScreenTheme3 extends ConsumerStatefulWidget {
  const LmsCommentScreenTheme3({
    required this.classworkID,
    super.key,
  });
  final String classworkID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LmsCommentScreenTheme3State();
}

class _LmsCommentScreenTheme3State
    extends ConsumerState<LmsCommentScreenTheme3> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmscommentDetails(
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
      ref.read(lmsProvider.notifier).getLmscommentDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);
    log('getReplayLog >> ${provider.lmsReplayfacultycommentData.length}');
    ref.listen(lmsProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColorTheme3);
      }
    });
    return Scaffold(
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
                'Comment Page',
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
                          ref.read(lmsProvider.notifier).getLmscommentDetails(
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
              else if (provider.lmsgetcommentData.isEmpty &&
                  provider is! LibraryTrancsactionStateLoading)
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'No List Added Yet!',
                          style: TextStyles.fontStyle,
                        ),
                      ),
                    ],
                  ),
                )
              else if (provider.lmsgetcommentData.isNotEmpty)
                Expanded(
                  // Allows the list to take available space and be scrollable
                  child: ListView.builder(
                    itemCount: provider.lmsgetcommentData.length,
                    controller: _listController,
                    itemBuilder: (BuildContext context, int index) {
                      return chatCardDesign(index);
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: provider.comment,
                        decoration: InputDecoration(
                          hintText: 'Type a Comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        await ref.read(lmsProvider.notifier).saveCommentfield(
                              ref.read(encryptionProvider.notifier),
                              widget.classworkID,
                            );
                        await ref
                            .read(lmsProvider.notifier)
                            .getLmscommentDetails(
                              ref.read(encryptionProvider.notifier),
                              widget.classworkID,
                            );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget chatCardDesign(int index) {
    final provider = ref.watch(lmsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender's Name and Message
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sender's Name
                      Text(
                        '${provider.lmsgetcommentData[index].names}' == 'null'
                            ? '-'
                            : '${provider.lmsgetcommentData[index].names}',
                        style: TextStyles.fontStyle10,
                      ),
                      const SizedBox(height: 4),

                      // Message Text
                      Text(
                        '${provider.lmsgetcommentData[index].comments}' ==
                                'null'
                            ? '-'
                            : '${provider.lmsgetcommentData[index].comments}',
                        style: TextStyles.lessSmallerBlackColorFontStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),

                // Timestamp
                Text(
                  '${provider.lmsgetcommentData[index].commentdatetime}' ==
                          'null'
                      ? 'Unknown time'
                      : '${provider.lmsgetcommentData[index].commentdatetime}',
                  style:
                      TextStyles.fontStyle10small.copyWith(color: Colors.grey),
                ),

                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: provider.lmsReplayfacultycommentData.length,
                //   itemBuilder: (BuildContext context, int index) {
                //     // final reply = 'Text'[index];
                //     return chatCard2Design(index);
                //   },
                // ),

                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       RouteDesign(
                //         route: CommentSection(),
                //         // route: LmsFacultyCommentScreen(
                //         //   studentclassworkcommentid:
                //         //       '${provider.lmsgetcommentData[index].studentclassworkcommentid}',
                //         // ),
                //       ),
                //     );
                //   },
                //   child: Text(
                //     '${provider.lmsgetcommentData[index].commentdatetime}' ==
                //             'null'
                //         ? 'Unknown time'
                //         : '${provider.lmsgetcommentData[index].commentdatetime}',
                //     style: TextStyles.fontStyle10small
                //         .copyWith(color: Colors.grey),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatCard2Design(int index) {
    final provider = ref.watch(lmsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender's Name and Message
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sender's Name
                      Text(
                        '${provider.lmsReplayfacultycommentData[index].replynames}' ==
                                'null'
                            ? '-'
                            : '${provider.lmsReplayfacultycommentData[index].replynames}',
                        style: TextStyles.fontStyle10,
                      ),
                      const SizedBox(height: 4),

                      // Message Text
                      Text(
                        '${provider.lmsReplayfacultycommentData[index].replycomments}' ==
                                'null'
                            ? '-'
                            : '${provider.lmsReplayfacultycommentData[index].replycomments}',
                        style: TextStyles.lessSmallerBlackColorFontStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),

                // Timestamp
                Text(
                  '${provider.lmsReplayfacultycommentData[index].replytime}' ==
                          'null'
                      ? 'Unknown time'
                      : '${provider.lmsReplayfacultycommentData[index].replytime}',
                  style:
                      TextStyles.fontStyle10small.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
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
