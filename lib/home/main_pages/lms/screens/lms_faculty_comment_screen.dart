// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
// import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
// import 'package:sample/home/widgets/drawer_design.dart';
// // import 'package:sample/home/riverpod/main_state.dart';

// class LmsFacultyCommentScreen extends ConsumerStatefulWidget {
//   const LmsFacultyCommentScreen({
//     required this.classworkID,
//     required this.studentclassworkcommentid,
//     super.key,
//   });
//   final String classworkID;
//   final String studentclassworkcommentid;

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _LmsFacultyCommentScreenState();
// }

// class _LmsFacultyCommentScreenState
//     extends ConsumerState<LmsFacultyCommentScreen> {
//   final ScrollController _listController = ScrollController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
//       GlobalKey<LiquidPullToRefreshState>();

//   static int refreshNum = 10;
//   Stream<int> counterStream =
//       Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

//   Future<void> _handleRefresh() async {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) {
//         ref.read(lmsProvider.notifier).getLmsFacultycommentDetails(
//               ref.read(encryptionProvider.notifier),
//               widget.classworkID,
//             );
//         ref.read(lmsProvider.notifier).getLmsReplayFacultycommentDetails(
//               ref.read(encryptionProvider.notifier),
//               widget.studentclassworkcommentid,
//             );
//       },
//     );

//     final completer = Completer<void>();
//     Timer(const Duration(seconds: 1), completer.complete);
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(lmsProvider.notifier).getLmsFacultycommentDetails(
//             ref.read(encryptionProvider.notifier),
//             widget.classworkID,
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final width = MediaQuery.of(context).size.width;
//     final provider = ref.watch(lmsProvider);
//     log(
//       'replay faculty log >>>${provider.lmsReplayfacultycommentData.length}',
//     );
//     ref.listen(lmsProvider, (previous, next) {
//       if (next is LibraryTrancsactionStateError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is LibraryTrancsactionStateSuccessful) {
//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: AppColors.secondaryColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Stack(
//           children: [
//             SvgPicture.asset(
//               'assets/images/wave.svg',
//               fit: BoxFit.fill,
//               width: double.infinity,
//               color: AppColors.primaryColor,
//               colorBlendMode: BlendMode.srcOut,
//             ),
//             AppBar(
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   // Navigator.push(
//                   //   context,
//                   //   RouteDesign(
//                   //     route: const HomePage2(),
//                   //   ),
//                   // );
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back_ios_new,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: const Text(
//                 'Faculty Comment',
//                 style: TextStyles.fontStyle4,
//                 overflow: TextOverflow.clip,
//               ),
//               centerTitle: true,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           ref
//                               .read(lmsProvider.notifier)
//                               .getLmsFacultycommentDetails(
//                                 ref.read(encryptionProvider.notifier),
//                                 widget.classworkID,
//                               );
//                         },
//                         child: const Icon(
//                           Icons.refresh,
//                           color: AppColors.whiteColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: LiquidPullToRefresh(
//         key: _refreshIndicatorKey,
//         onRefresh: _handleRefresh,
//         color: AppColors.primaryColor,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               if (provider is LibraryTrancsactionStateLoading)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: CircularProgressIndicators
//                         .primaryColorProgressIndication,
//                   ),
//                 )
//               else if (provider.lmsfacultygetcommentData.isEmpty &&
//                   provider is! LibraryTrancsactionStateLoading)
//                 const Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: Text(
//                           'No List Added Yet!',
//                           style: TextStyles.fontStyle1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               else if (provider.lmsfacultygetcommentData.isNotEmpty)
//                 Expanded(
//                   // Allows the list to take available space and be scrollable
//                   child: ListView.builder(
//                     itemCount: provider.lmsfacultygetcommentData.length,
//                     controller: _listController,
//                     itemBuilder: (BuildContext context, int index) {
//                       return facultychatCardDesign(index);
//                     },
//                   ),
//                 ),
//               Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: provider.comment,
//                         decoration: InputDecoration(
//                           hintText: 'Type a Comment...',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.send),
//                       onPressed: () async {
//                         await ref.read(lmsProvider.notifier).saveCommentfield(
//                               ref.read(encryptionProvider.notifier),
//                               widget.classworkID,
//                             );
//                         await ref
//                             .read(lmsProvider.notifier)
//                             .getLmsFacultycommentDetails(
//                               ref.read(encryptionProvider.notifier),
//                               widget.classworkID,
//                             );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // child: SingleChildScrollView(
//         //   child: Padding(
//         //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         //     child: Column(
//         //       crossAxisAlignment: CrossAxisAlignment.start,
//         //       children: [
//         //         const SizedBox(height: 20),
//         //         if (provider is LibraryTrancsactionStateLoading)
//         //           Padding(
//         //             padding: const EdgeInsets.only(top: 100),
//         //             child: Center(
//         //               child: CircularProgressIndicators
//         //                   .primaryColorProgressIndication,
//         //             ),
//         //           )
//         //         else if (provider.lmsfacultygetcommentData.isEmpty &&
//         //             provider is! LibraryTrancsactionStateLoading)
//         //           Column(
//         //             children: [
//         //               SizedBox(height: MediaQuery.of(context).size.height / 5),
//         //               const Center(
//         //                 child: Text(
//         //                   'No List Added Yet!',
//         //                   style: TextStyles.fontStyle1,
//         //                 ),
//         //               ),
//         //             ],
//         //           ),
//         //         if (provider.lmsfacultygetcommentData.isNotEmpty)
//         //           ListView.builder(
//         //             itemCount: provider.lmsfacultygetcommentData.length,
//         //             controller: _listController,
//         //             shrinkWrap: true,
//         //             itemBuilder: (BuildContext context, int index) {
//         //               return cardDesign(index);
//         //             },
//         //           ),
//         //         Padding(
//         //           padding: const EdgeInsets.all(8),
//         //           child: Row(
//         //             children: [
//         //               Expanded(
//         //                 child: TextField(
//         //                   // controller: _controller,
//         //                   decoration: InputDecoration(
//         //                     hintText: 'Type a message...',
//         //                     border: OutlineInputBorder(
//         //                       borderRadius: BorderRadius.circular(20),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //               IconButton(
//         //                 icon: const Icon(Icons.send),
//         //                 onPressed: () {},
//         //               ),
//         //             ],
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       ),
//       endDrawer: const DrawerDesign(),
//     );
//   }

//   Widget facultychatCardDesign(int index) {
//     final provider = ref.watch(lmsProvider);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Sender's Name and Message
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Sender's Name
//                       Text(
//                         '${provider.lmsfacultygetcommentData[index].names}' ==
//                                 'null'
//                             ? '-'
//                             : '${provider.lmsfacultygetcommentData[index].names}',
//                         style: TextStyles.fontStyle10,
//                       ),
//                       const SizedBox(height: 4),

//                       // Message Text
//                       Text(
//                         '${provider.lmsfacultygetcommentData[index].comments}' ==
//                                 'null'
//                             ? '-'
//                             : '${provider.lmsfacultygetcommentData[index].comments}',
//                         style: TextStyles.lessSmallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 4),

//                 // Timestamp
//                 Text(
//                   '${provider.lmsfacultygetcommentData[index].commentdatetime}' ==
//                           'null'
//                       ? 'Unknown time'
//                       : '${provider.lmsfacultygetcommentData[index].commentdatetime}',
//                   style:
//                       TextStyles.fontStyle10small.copyWith(color: Colors.grey),
//                 ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: provider.lmsReplayfacultycommentData.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     // final reply = 'Text'[index];
//                     return chatCard2Design(index);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget chatCard2Design(int index) {
//     final provider = ref.watch(lmsProvider);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(width: 8),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Sender's Name and Message
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade200,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Sender's Name
//                       Text(
//                         '${provider.lmsReplayfacultycommentData[index].replynames}' ==
//                                 'null'
//                             ? '-'
//                             : '${provider.lmsReplayfacultycommentData[index].replynames}',
//                         style: TextStyles.fontStyle10,
//                       ),
//                       const SizedBox(height: 4),

//                       // Message Text
//                       Text(
//                         '${provider.lmsReplayfacultycommentData[index].replycomments}' ==
//                                 'null'
//                             ? '-'
//                             : '${provider.lmsReplayfacultycommentData[index].replycomments}',
//                         style: TextStyles.lessSmallerBlackColorFontStyle,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 4),

//                 // Timestamp
//                 Text(
//                   '${provider.lmsReplayfacultycommentData[index].replytime}' ==
//                           'null'
//                       ? 'Unknown time'
//                       : '${provider.lmsReplayfacultycommentData[index].replytime}',
//                   style:
//                       TextStyles.fontStyle10small.copyWith(color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showToast(BuildContext context, String message, Color color) {
//     showToast(
//       message,
//       context: context,
//       backgroundColor: color,
//       axis: Axis.horizontal,
//       alignment: Alignment.centerLeft,
//       position: StyledToastPosition.center,
//       borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(15),
//         bottomLeft: Radius.circular(15),
//       ),
//       toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
//     );
//   }
// }

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

class LmsFacultyCommentScreen extends ConsumerStatefulWidget {
  const LmsFacultyCommentScreen({
    required this.classworkID,
    // required this.studentclassworkcommentid,
    super.key,
  });
  final String classworkID;
  // final String studentclassworkcommentid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LmsFacultyCommentScreenState();
}

class _LmsFacultyCommentScreenState
    extends ConsumerState<LmsFacultyCommentScreen> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  bool showReplies = false;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

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
    log(
      'Replay faculty log >>>${provider.lmsReplayfacultycommentData.length}',
    );
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
                'Faculty Comment',
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'No List Added Yet!',
                          style: TextStyles.fontStyle1,
                        ),
                      ),
                    ],
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

    // // Check if the studentclassworkcommentid is not null before passing it
    // final studentClassworkCommentId =
    //     provider.lmsfacultygetcommentData[index].studentclassworkcommentid;

    // // Trigger getLmsReplayFacultycommentDetails only if studentclassworkcommentid exists
    // if (studentClassworkCommentId != null) {
    //   ref.read(lmsProvider.notifier).getLmsReplayFacultycommentDetails(
    //         ref.read(encryptionProvider.notifier),
    //         studentClassworkCommentId,
    //       );
    // }

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
                        showReplies = !showReplies;
                        ref
                            .read(lmsProvider.notifier)
                            .getLmsReplayFacultycommentDetails(
                                ref.read(encryptionProvider.notifier),
                                '${provider.lmsfacultygetcommentData[index].studentclassworkcommentid}');
                      });
                    },
                    child: Text(showReplies ? 'Hide Replies' : 'Show Replies'),
                  ),
                ),
                if (showReplies)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.lmsReplayfacultycommentData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return chatCard2Design(index);
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
                        provider.lmsfacultygetcommentData[index].names ?? '',
                        style: TextStyles.fontStyle10,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        provider.lmsfacultygetcommentData[index]
                                .commentdatetime ??
                            '',
                        style: TextStyles.lessSmallerBlackColorFontStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  provider.lmsfacultygetcommentData[index].commentdatetime ??
                      '',
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
    showToastWidget(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info, color: Colors.white),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      context: context,
      isIgnoring: false,
      duration: const Duration(seconds: 2),
    );
  }
}
