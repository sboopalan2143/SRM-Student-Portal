import 'dart:async';
import 'dart:developer';
import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07LmsCommentScreen extends ConsumerStatefulWidget {
  const Theme07LmsCommentScreen({
    required this.classworkID,
    super.key,
  });

  final String classworkID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07LmsCommentScreenState();
}

class _Theme07LmsCommentScreenState extends ConsumerState<Theme07LmsCommentScreen> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

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
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
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
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
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
                      color: Colors.white,
                    ),
                  ),
                ],
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
            else if (provider.lmsgetcommentData.isEmpty && provider is! LibraryTrancsactionStateLoading)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'No List Added ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
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
                      color: Theme.of(context).colorScheme.inverseSurface.withAlpha(160),
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

  Widget chatCardDesign(int index) {
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final provider = ref.watch(lmsProvider);
    final commentData = provider.lmsgetcommentData[index];
    final isYou = commentData.names!.toLowerCase().contains('you'); // Adjust this condition based on your logic.
    log('${commentData.names} >>>> $isYou');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isYou ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isYou) ...[
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.inverseSurface.withAlpha(20),
              child: Text(
                commentData.names?.replaceAll('UAT ', '')[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10.copyWith(color: Theme.of(context).colorScheme.primary.withAlpha(255)),
              ),
            ),
            const SizedBox(width: 4),
          ],
          Padding(
            padding: EdgeInsets.only(top: isYou ? 18 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sender's Name
                if (!isYou) ...[
                  Text(
                    commentData.names?.split(':')[0] ?? '-',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.primary.withAlpha(255),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],

                // Message Clipper
                ClipPath(
                  clipper: UpperNipMessageClipperTwo(isYou ? MessageType.send : MessageType.receive, nipWidth: 12),
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * .45,
                      maxWidth: MediaQuery.of(context).size.width * .7,
                    ),
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: isYou ? 20 : 12, left: isYou ? 12 : 20),
                    decoration: BoxDecoration(
                      color: isYou
                          ? Theme.of(context).colorScheme.primary.withAlpha(150)
                          : Theme.of(context).colorScheme.inverseSurface.withAlpha(20),
                      // borderRadius: BorderRadius.only(
                      //   topLeft: isYou ? const Radius.circular(12) : Radius.zero,
                      //   topRight: isYou ? Radius.zero : const Radius.circular(12),
                      //   bottomLeft: const Radius.circular(12),
                      //   bottomRight: const Radius.circular(12),
                      // ),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sender's Name
                            // if (!isYou) ...[
                            //   Text(
                            //     commentData.names?.split(':')[0] ?? '-',
                            //     style: TextStyles.fontStyle10.copyWith(
                            //       color: Theme.of(context).colorScheme.primary.withAlpha(255),
                            //     ),
                            //   ),
                            //   const SizedBox(height: 8),
                            // ],

                            // Comment Text
                            Text(
                              commentData.comments ?? '-',
                              style: TextStyles.smallBlackColorFontStyle.copyWith(
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                            ),

                            const SizedBox(height: 18),
                          ],
                        ),
                        // Timestamp positioned at bottom right
                        Positioned(
                          bottom: 0,
                          right: 4,
                          child: Text(
                            commentData.commentdatetime?.split('.')[0] ?? 'Unknown time',
                            style: TextStyles.fontStyle10small.copyWith(
                              color: Theme.of(context).colorScheme.inverseSurface.withAlpha(120),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isYou) ...[
            const SizedBox(width: 4),
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(150),
              child: Text(
                commentData.names?[0].toUpperCase() ?? '-',
                style: TextStyles.fontStyle10.copyWith(color: Theme.of(context).colorScheme.inverseSurface),
              ),
            ),
          ],
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

// class MessageClipper extends CustomClipper<Path> {
//   final bool isMe;
//   MessageClipper(this.isMe);

//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     if (isMe) {
//       // Tail on right
//       path
//         ..moveTo(0, 0)
//         ..lineTo(size.width - 10, 0)
//         ..lineTo(size.width - 10, size.height - 10)
//         ..lineTo(size.width, size.height)
//         ..lineTo(size.width - 20, size.height)
//         ..lineTo(0, size.height)
//         ..close();
//     } else {
//       // Tail on left
//       path
//         ..moveTo(10, 0)
//         ..lineTo(size.width, 0)
//         ..lineTo(size.width, size.height)
//         ..lineTo(20, size.height)
//         ..lineTo(0, size.height - 10)
//         ..lineTo(10, size.height - 10)
//         ..close();
//     }
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }
