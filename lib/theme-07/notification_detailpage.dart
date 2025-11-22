import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07NotificationPage extends ConsumerStatefulWidget {
  const Theme07NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07NotificationPageState();
}

class _Theme07NotificationPageState extends ConsumerState<Theme07NotificationPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).getNotificationDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(notificationProvider);
    ref.listen(lmsProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   ref.read(notificationCountProvider.notifier).getNotificationCountDetails(
            //         ref.read(encryptionProvider.notifier),
            //       );
            // });
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          'NOTIFICATION LIST',
          style: TextStyles.fontStyle4,
          overflow: TextOverflow.clip,
        ),
        centerTitle: true,
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
                    child: CircularProgressIndicators.primaryColorProgressIndication,
                  ),
                )
              else if (provider.notificationData.isEmpty && provider is! LibraryTrancsactionStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
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
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(notificationProvider);

    // Utility function to check if the string contains HTML tags
    bool isHtml(String input) {
      final htmlRegex = RegExp('<[^>]+>');
      return htmlRegex.hasMatch(input);
    }

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
            color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width / 2 - 80,
                //       child: const Text(
                //         'Notification Id',
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //     const Text(
                //       ':',
                //       style: TextStyles.fontStyle10,
                //     ),
                //     const SizedBox(width: 5),
                //     SizedBox(
                //       width: width / 2 - 60,
                //       child: Text(
                //         '${provider.notificationData[index].notificationid}' ==
                //                 'null'
                //             ? '-'
                //             : '''${provider.notificationData[index].notificationid}''',
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: Text(
                        'Notification Subject',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.notificationData[index].notificationsubject}' == 'null'
                            ? '-'
                            : '''${provider.notificationData[index].notificationsubject}''',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width / 2 - 80,
                //       child: Text(
                //         'View Status',
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Theme.of(context).colorScheme.inverseSurface,
                //         ),
                //       ),
                //     ),
                //     Text(
                //       ':',
                //       style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //         color: Theme.of(context).colorScheme.inverseSurface,
                //       ),
                //     ),
                //     const SizedBox(width: 5),
                //     SizedBox(
                //       width: width / 2 - 60,
                //       child: Text(
                //         '${provider.notificationData[index].viewstatus}' == 'null'
                //             ? '-'
                //             : '''${provider.notificationData[index].viewstatus}''',
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Theme.of(context).colorScheme.inverseSurface,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: Text(
                        'Notification Description',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: isHtml('${provider.notificationData[index].notificationdescription}')
                          ? Html(
                              data: provider.notificationData[index].notificationdescription == 'null'
                                  ? '-'
                                  : provider.notificationData[index].notificationdescription,
                              style: {
                                '*': Style(
                                  fontSize: FontSize(12),
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).colorScheme.inverseSurface,
                                ),
                              },
                            )
                          : Text(
                              '${provider.notificationData[index].notificationdescription}' == 'null'
                                  ? '-'
                                  : '${provider.notificationData[index].notificationdescription}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.inverseSurface,
                              ),
                            ),
                    ),
                  ],
                ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width / 2 - 80,
                //       child: Text(
                //         'Notification Category Description',
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Theme.of(context).colorScheme.inverseSurface,
                //         ),
                //       ),
                //     ),
                //     Text(
                //       ':',
                //       style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //         color: Theme.of(context).colorScheme.inverseSurface,
                //       ),
                //     ),
                //     const SizedBox(width: 5),
                //     SizedBox(
                //       width: width / 2 - 60,
                //       child: Text(
                //         '${provider.notificationData[index].notificationcategorydesc}' == 'null'
                //             ? '-'
                //             : '''${provider.notificationData[index].notificationcategorydesc}''',
                //         style: TextStyle(
                //           fontSize: 12,
                //           fontWeight: FontWeight.bold,
                //           color: Theme.of(context).colorScheme.inverseSurface,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 10),
              ],
            ),
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
