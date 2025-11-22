import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/main_pages/lms/screens/lms_title_screen.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';

class Theme02NotificationPage extends ConsumerStatefulWidget {
  const Theme02NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme02NotificationPageState();
}

class _Theme02NotificationPageState extends ConsumerState<Theme02NotificationPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

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
              title: Text(
                'NOTIFICATION',
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
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(notificationProvider);

    bool isHtml(String? input) {
      if (input == null || input.isEmpty || input == 'null') return false;
      return RegExp('<[^>]+>', caseSensitive: false).hasMatch(input);
    }

    String cleanHtml(String html) {
      if (html == 'null' || html.isEmpty) return '-';

      // Replace common messy patterns
      var cleaned = html
          .replaceAll(RegExp('<div>|<div[^>]*>'), '\n') // convert divs to newlines
          .replaceAll(RegExp('</div>'), '') // remove closing div
          .replaceAll(RegExp('<span[^>]*>'), '') // remove opening span with styles
          .replaceAll('</span>', '')
          .replaceAll(RegExp('<font[^>]*>'), '')
          .replaceAll('</font>', '')
          .replaceAll('<b>', '<strong>')
          .replaceAll('</b>', '</strong>')
          .replaceAll('&nbsp;', ' ')
          .replaceAll(RegExp(r'\n\s*\n'), '\n\n') // normalize multiple newlines
          .trim();

      // Ensure proper paragraph and line breaks
      cleaned = cleaned.replaceAll('\n', '<br>');

      // Wrap in <p> if needed (optional, improves styling)
      if (!cleaned.contains('<p') && !cleaned.startsWith('<')) {
        cleaned = '<p>$cleaned</p>';
      }

      return cleaned;
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
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.notificationData[index].notificationsubject}' == 'null'
                            ? '-'
                            : '''${provider.notificationData[index].notificationsubject}''',
                        style: TextStyles.fontStyle10,
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
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //     Text(
                //       ':',
                //       style: TextStyles.fontStyle10,
                //     ),
                //     const SizedBox(width: 5),
                //     SizedBox(
                //       width: width / 2 - 60,
                //       child: Text(
                //         '${provider.notificationData[index].viewstatus}' == 'null'
                //             ? '-'
                //             : '''${provider.notificationData[index].viewstatus}''',
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
                        'Notification Description',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: isHtml('${provider.notificationData[index].notificationdescription}')
                          ? Html(
                              data: cleanHtml(provider.notificationData[index].notificationdescription ?? ''),
                              style: {
                                'body': Style(
                                  margin: Margins.zero,
                                  padding: HtmlPaddings.zero,
                                  fontSize: FontSize(14),
                                  lineHeight: LineHeight(1.6),
                                  color: Colors.black87,
                                ),
                                'p': Style(
                                  margin: Margins.symmetric(vertical: 6),
                                ),
                                'br': Style(
                                  display: Display.block,
                                  margin: Margins.symmetric(vertical: 8),
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
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //     Text(
                //       ':',
                //       style: TextStyles.fontStyle10,
                //     ),
                //     const SizedBox(width: 5),
                //     SizedBox(
                //       width: width / 2 - 60,
                //       child: Text(
                //         '${provider.notificationData[index].notificationcategorydesc}' == 'null'
                //             ? '-'
                //             : '''${provider.notificationData[index].notificationcategorydesc}''',
                //         style: TextStyles.fontStyle10,
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
