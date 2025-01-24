import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/main_pages/lms/screens/lms_title_screen.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/theme-02/notification_page.dart';

class NotificationHomePage extends ConsumerStatefulWidget {
  const NotificationHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationHomePageState();
}

class _NotificationHomePageState extends ConsumerState<NotificationHomePage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(notificationProvider.notifier).getNotificationDetails(
              ref.read(encryptionProvider.notifier),
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
      ref.read(notificationProvider.notifier).getNotificationDetails(
            ref.read(encryptionProvider.notifier),
          );

      ref.read(notificationCountProvider.notifier).getreadNotificationDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(notificationProvider);
    ref.listen(notificationCountProvider, (previous, next) {
      if (next is NotificationCountError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is NotificationCountSuccessFull) {
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
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  // ref
                  //     .read(notificationCountProvider.notifier)
                  //     .getNotificationCountDetails(
                  //       ref.read(encryptionProvider.notifier),
                  //     );
                  // ref
                  //     .read(notificationCountProvider.notifier)
                  //     .getreadNotificationDetails(
                  //       ref.read(encryptionProvider.notifier),
                  //     );
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
                'NOTIFICATION List',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
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
              else if (provider.notificationData.isEmpty &&
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
              if (provider.notificationData.isNotEmpty)
                ListView.builder(
                  itemCount: provider.notificationData.length,
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
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(notificationProvider);
    return GestureDetector(
      onTap: () {
        // ref.read(lmsProvider.notifier).getLmsTitleDetails(
        //       ref.read(encryptionProvider.notifier),
        //       '${provider.lmsSubjectData[index].subjectid}',
        //     );
        // Navigator.push(
        //   context,
        //   RouteDesign(
        //     route: LmsTitlePage(
        //       subjectID: '${provider.lmsSubjectData[index].staffname}',
        //     ),
        //   ),
        // );
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFF3F4F6),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(
                    Icons.paste_outlined,
                    size: 36,
                    color: Colors.indigo[400],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${provider.notificationData[index].notificationsubject}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        RouteDesign(route: const Theme02NotificationPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.blue,
                        //     blurRadius: 4,
                        //     offset: const Offset(0, 4),
                        //   ),
                        // ],
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //  Column(
            //   children: [
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: width / 2 - 80,
            //           child: const Text(
            //             'Staff Name',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //         const Text(
            //           ':',
            //           style: TextStyles.fontStyle10,
            //         ),
            //         const SizedBox(width: 5),
            //         SizedBox(
            //           width: width / 2 - 60,
            //           child: Text(
            //             '${provider.notificationData[index].staffname}' == 'null'
            //                 ? '-'
            //                 : '''${provider.notificationData[index].staffname}''',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: width / 2 - 80,
            //           child: const Text(
            //             'Subject Id',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //         const Text(
            //           ':',
            //           style: TextStyles.fontStyle10,
            //         ),
            //         const SizedBox(width: 5),
            //         SizedBox(
            //           width: width / 2 - 60,
            //           child: Text(
            //             '${provider.lmsSubjectData[index].subjectid}' == 'null'
            //                 ? '-'
            //                 : '${provider.lmsSubjectData[index].subjectid}',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: width / 2 - 80,
            //           child: const Text(
            //             'Subject Code',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //         const Text(
            //           ':',
            //           style: TextStyles.fontStyle10,
            //         ),
            //         const SizedBox(width: 5),
            //         SizedBox(
            //           width: width / 2 - 60,
            //           child: Text(
            //             '${provider.lmsSubjectData[index].subjectcode}' ==
            //                     'null'
            //                 ? '-'
            //                 : '''${provider.lmsSubjectData[index].subjectcode}''',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: width / 2 - 80,
            //           child: const Text(
            //             'Subjectdesc',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //         const Text(
            //           ':',
            //           style: TextStyles.fontStyle10,
            //         ),
            //         const SizedBox(width: 5),
            //         SizedBox(
            //           width: width / 2 - 60,
            //           child: Text(
            //             '${provider.lmsSubjectData[index].subjectdesc}' ==
            //                     'null'
            //                 ? '-'
            //                 : '''${provider.lmsSubjectData[index].subjectdesc}''',
            //             style: TextStyles.fontStyle10,
            //           ),
            //         ),
            //       ],
            //     ),
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     SizedBox(
            //       width: 200,
            //       child: ElevatedButton(
            //         style: ElevatedButton.styleFrom(
            //           shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(9),
            //             ),
            //           ),
            //           elevation: 0,
            //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //           backgroundColor: AppColors.primaryColor,
            //           shadowColor: Colors.transparent,
            //         ),
            //         onPressed: () {
            //           ref.read(lmsProvider.notifier).getLmsTitleDetails(
            //                 ref.read(encryptionProvider.notifier),
            //                 '${provider.lmsSubjectData[index].subjectid}',
            //               );
            //           Navigator.push(
            //             context,
            //             RouteDesign(
            //               route: LmsTitlePage(
            //                 subjectID:
            //                     '${provider.lmsSubjectData[index].staffname}',
            //               ),
            //             ),
            //           );
            //         },
            //         child: const Text(
            //           'view',
            //           style: TextStyles.fontStyle13,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
