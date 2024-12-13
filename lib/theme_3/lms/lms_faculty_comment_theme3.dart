import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class LmsFacultyCommentScreen03 extends ConsumerStatefulWidget {
  const LmsFacultyCommentScreen03({
    required this.classworkID,
    // required this.studentclassworkcommentid,
    super.key,
  });
  final String classworkID;
  // final String studentclassworkcommentid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LmsFacultyCommentScreen03State();
}

class _LmsFacultyCommentScreen03State
    extends ConsumerState<LmsFacultyCommentScreen03> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  // Track the show replies state individually for each comment
  List<bool> showRepliesList = [];

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmsFacultycommentDetails(
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
      ref.read(lmsProvider.notifier).getLmsFacultycommentDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(lmsProvider);

    if (showRepliesList.length != provider.lmsfacultygetcommentData.length) {
      showRepliesList =
          List<bool>.filled(provider.lmsfacultygetcommentData.length, false);
    }

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
                'Faculty Comment',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      ref
                          .read(lmsProvider.notifier)
                          .getLmsFacultycommentDetails(
                            ref.read(encryptionProvider.notifier),
                            widget.classworkID,
                          );
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: AppColors.whiteColor,
                    ),
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
              else if (provider.lmsfacultygetcommentData.isEmpty &&
                  provider is! LibraryTrancsactionStateLoading)
                const Expanded(
                  child: Center(
                    child: Text(
                      'No List Added Yet!',
                      style: TextStyles.fontStyle,
                    ),
                  ),
                )
              else if (provider.lmsfacultygetcommentData.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.lmsfacultygetcommentData.length,
                    controller: _listController,
                    itemBuilder: (BuildContext context, int index) {
                      return facultychatCardDesign(index);
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
                            .getLmsFacultycommentDetails(
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

  Widget facultychatCardDesign(int index) {
    final provider = ref.watch(lmsProvider);

    log('faculty comment >>> ${provider.lmsfacultygetcommentData[index].studentclassworkcommentid}');

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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.lmsfacultygetcommentData[index].names ?? '-',
                        style: TextStyles.fontStyle10,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        provider.lmsfacultygetcommentData[index].comments ??
                            '-',
                        style: TextStyles.lessSmallerBlackColorFontStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider.lmsfacultygetcommentData[index].commentdatetime ??
                      'Unknown time',
                  style:
                      TextStyles.fontStyle10small.copyWith(color: Colors.grey),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showRepliesList[index] = !showRepliesList[index];
                        if (showRepliesList[index]) {
                          ref
                              .read(lmsProvider.notifier)
                              .getLmsReplayFacultycommentDetails(
                                ref.read(encryptionProvider.notifier),
                                '${provider.lmsfacultygetcommentData[index].studentclassworkcommentid}',
                              );
                        }
                      });
                    },
                    child: Text(
                      showRepliesList[index] ? 'Hide Replies' : 'Show Replies',
                    ),
                  ),
                ),
                if (showRepliesList[index])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.lmsReplayfacultycommentData.length,
                      itemBuilder: (BuildContext context, int replyIndex) {
                        return chatCard2Design(replyIndex);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chatCard2Design(int index) {
    final provider = ref.watch(lmsProvider);
    log('lmsReplayfacultycommentData >>> ${provider.lmsReplayfacultycommentData.length}');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8),
          if (provider.lmsReplayfacultycommentData[index].replycomments != '')
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.lmsReplayfacultycommentData[index]
                                  .replynames ??
                              '',
                          style: TextStyles.fontStyle10,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          provider.lmsReplayfacultycommentData[index]
                                  .replycomments ??
                              '',
                          style: TextStyles.lessSmallerBlackColorFontStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    provider.lmsReplayfacultycommentData[index].replytime ?? '',
                    style: TextStyles.fontStyle10small
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
