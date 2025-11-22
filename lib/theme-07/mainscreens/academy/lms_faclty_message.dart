import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07LmsFacultyCommentScreen extends ConsumerStatefulWidget {
  const Theme07LmsFacultyCommentScreen({
    required this.classworkID,
    // required this.studentclassworkcommentid,
    super.key,
  });

  final String classworkID;

  // final String studentclassworkcommentid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07LmsFacultyCommentScreenState();
}

class _Theme07LmsFacultyCommentScreenState extends ConsumerState<Theme07LmsFacultyCommentScreen> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  // Track the show replies state individually for each comment
  List<bool> showRepliesList = [];

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
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    if (showRepliesList.length != provider.lmsfacultygetcommentData.length) {
      showRepliesList = List<bool>.filled(provider.lmsfacultygetcommentData.length, false);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
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
          elevation: 0,
          title: Text(
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
                  ref.read(lmsProvider.notifier).getLmsFacultycommentDetails(
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            if (provider is LibraryTrancsactionStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicators.primaryColorProgressIndication,
                ),
              )
            else if (provider.lmsfacultygetcommentData.isEmpty && provider is! LibraryTrancsactionStateLoading)
              Expanded(
                child: Center(
                  child: Text(
                    'No List Added Yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                      ),
                      child: TextField(
                        controller: provider.comment,
                        cursorColor: Theme.of(context).colorScheme.inverseSurface,
                        decoration: InputDecoration(
                          hintText: 'Type a Comment...',
                          hintStyle: TextStyle(color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80)),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
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
                      color: AppColors.theme07primaryColor,
                    ), // Blue send icon
                    onPressed: () async {
                      await ref.read(lmsProvider.notifier).saveCommentfield(
                            ref.read(encryptionProvider.notifier),
                            widget.classworkID,
                          );
                      await ref.read(lmsProvider.notifier).getLmscommentDetails(
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget facultychatCardDesign(int index) {
    final provider = ref.watch(lmsProvider);
    final commentData = provider.lmsfacultygetcommentData[index];
    final isYou = commentData.names == 'You'; // Adjust this condition based on your logic.

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isYou)
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                commentData.names?[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10.copyWith(color: AppColors.theme07primaryColor),
              ),
            ),
          if (!isYou) const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: isYou ? AppColors.primaryColor.withOpacity(0.1) : Colors.grey.shade100,
                    borderRadius: BorderRadius.only(
                      topLeft: isYou ? const Radius.circular(12) : Radius.zero,
                      topRight: isYou ? Radius.zero : const Radius.circular(12),
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isYou)
                        Text(
                          commentData.names ?? '-',
                          style: TextStyles.fontStyle10.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      if (!isYou) const SizedBox(height: 8),
                      Text(
                        commentData.comments ?? '-',
                        style: TextStyles.lessSmallerBlackColorFontStyle.copyWith(
                          color: isYou ? AppColors.primaryColor : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          commentData.commentdatetime ?? 'Unknown time',
                          style: TextStyles.fontStyle10small.copyWith(
                            color: AppColors.theme02buttonColor2,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showRepliesList[index] = !showRepliesList[index];
                        if (showRepliesList[index]) {
                          ref.read(lmsProvider.notifier).getLmsReplayFacultycommentDetails(
                                ref.read(encryptionProvider.notifier),
                                '${commentData.studentclassworkcommentid}',
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
          if (isYou) const SizedBox(width: 12),
          if (isYou)
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                commentData.names?[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10.copyWith(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
    );
  }

  Widget chatCard2Design(int index) {
    final provider = ref.watch(lmsProvider);
    final replyData = provider.lmsReplayfacultycommentData[index];
    final isYou = replyData.replynames == 'You';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isYou)
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade300,
              child: Text(
                replyData.replynames?[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10.copyWith(color: AppColors.primaryColor),
              ),
            ),
          if (!isYou) const SizedBox(width: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isYou ? AppColors.primaryColor.withOpacity(0.1) : Colors.grey.shade100,
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
                  if (!isYou)
                    Text(
                      replyData.replynames ?? '-',
                      style: TextStyles.fontStyle10.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  if (!isYou) const SizedBox(height: 8),
                  Text(
                    replyData.replycomments ?? '-',
                    style: TextStyles.smallBlackColorFontStyle.copyWith(
                      color: isYou ? AppColors.primaryColor : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      replyData.replytime ?? 'Unknown time',
                      style: TextStyles.fontStyle10small.copyWith(
                        color: AppColors.theme02buttonColor2,
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
                replyData.replynames?[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10.copyWith(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
    );
  }
}
