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

class Theme01LmsCommentScreen extends ConsumerStatefulWidget {
  const Theme01LmsCommentScreen({
    required this.classworkID,
    super.key,
  });
  final String classworkID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01LmsCommentScreenState();
}

class _Theme01LmsCommentScreenState
    extends ConsumerState<Theme01LmsCommentScreen> {
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
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.theme01primaryColor,
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
                  // Navigator.push(
                  //   context,
                  //   RouteDesign(
                  //     route: const HomePage2(),
                  //   ),
                  // );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'Comment Page',
                style: TextStyles.buttonStyle01theme4,
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
                        child: Icon(
                          Icons.refresh,
                          color: AppColors.theme01primaryColor,
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
        color: AppColors.theme01primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (provider is LibraryTrancsactionStateLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: Text(
                      'No List Added',
                      style: TextStyles.fontStyle1,
                    ),
                  ),
                )
              else if (provider.lmsgetcommentData.isEmpty &&
                  provider is! LibraryTrancsactionStateLoading)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicators
                            .theme01primaryColorProgressIndication,
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (value) {
                            log('Textfield : ${value}');
                            log('${provider.comment.text}');
                          },
                          controller: provider.comment,
                          decoration: const InputDecoration(
                            hintText: 'Type a Comment...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: AppColors.theme01secondaryColor1,
                      ), // Blue send icon
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
    final commentData = provider.lmsgetcommentData[index];
    final isYou = commentData.names == 'You';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isYou)
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                commentData.names?[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10
                    .copyWith(color: AppColors.primaryColor),
              ),
            ),
          if (!isYou) const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isYou
                    ? AppColors.primaryColor.withOpacity(0.1)
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isYou ? const Radius.circular(12) : Radius.zero,
                  bottomRight: isYou ? Radius.zero : const Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sender's Name
                  if (!isYou)
                    Text(
                      commentData.names ?? '-',
                      style: TextStyles.fontStyle10.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  if (!isYou) const SizedBox(height: 8),
                  // Comment Text
                  Text(
                    commentData.comments ?? '-',
                    style: TextStyles.lessSmallerBlackColorFontStyle.copyWith(
                      color: isYou ? AppColors.primaryColor : Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),
                  // Timestamp
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      commentData.commentdatetime ?? 'Unknown time',
                      style: TextStyles.fontStyle10small.copyWith(
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isYou) const SizedBox(width: 12),
          if (isYou)
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                commentData.names?[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10
                    .copyWith(color: AppColors.primaryColor),
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
