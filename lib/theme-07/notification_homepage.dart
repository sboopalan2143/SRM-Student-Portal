import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_count_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/theme/theme_provider.dart';
import 'package:flutter_html/flutter_html.dart';

class Theme07NotificationHomePage extends ConsumerStatefulWidget {
  const Theme07NotificationHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07NotificationHomePageState();
}

class _Theme07NotificationHomePageState extends ConsumerState<Theme07NotificationHomePage> {
  final ScrollController _listController = ScrollController();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

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
    final provider = ref.watch(notificationProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ref.read(notificationCountProvider.notifier).getNotificationCountDetails(
                    ref.read(encryptionProvider.notifier),
                  );
            });
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
                    return cardDesign(context, index);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesign(BuildContext context, int index) {
    final provider = ref.watch(notificationProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
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
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.paste_outlined,
                  size: 36,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${provider.notificationData[index].notificationsubject}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    _showNotificationDetails(context, index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(20),
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
        ),
      ),
    );
  }

  // void _showNotificationDetails(BuildContext context, int index) {
  //   final provider = ref.watch(notificationProvider);
  //   final themeProvider = pro.Provider.of<ThemeProvider>(context, listen: false);
  //   final width = MediaQuery.of(context).size.width;

  //   bool isHtml(String? input) {
  //     if (input == null || input.isEmpty || input == 'null') return false;
  //     return RegExp('<[^>]+>', caseSensitive: false).hasMatch(input);
  //   }

  //   log(isHtml('${provider.notificationData[index].notificationdescription}').toString());

  //   String cleanHtml(String html) {
  //     if (html == 'null' || html.isEmpty) return '-';

  //     // Replace common messy patterns
  //     var cleaned = html
  //         .replaceAll(RegExp('<div>|<div[^>]*>'), '\n') // convert divs to newlines
  //         .replaceAll(RegExp('</div>'), '') // remove closing div
  //         .replaceAll(RegExp('<span[^>]*>'), '') // remove opening span with styles
  //         .replaceAll('</span>', '')
  //         .replaceAll(RegExp('<font[^>]*>'), '')
  //         .replaceAll('</font>', '')
  //         .replaceAll('<b>', '<strong>')
  //         .replaceAll('</b>', '</strong>')
  //         .replaceAll('&nbsp;', ' ')
  //         .replaceAll(RegExp(r'\n\s*\n'), '\n\n') // normalize multiple newlines
  //         .trim();

  //     // Ensure proper paragraph and line breaks
  //     cleaned = cleaned.replaceAll('\n', '<br>');

  //     // Wrap in <p> if needed (optional, improves styling)
  //     if (!cleaned.contains('<p') && !cleaned.startsWith('<')) {
  //       cleaned = '<p>$cleaned</p>';
  //     }

  //     return cleaned;
  //   }

  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => DraggableScrollableSheet(
  //       initialChildSize: 0.6,
  //       minChildSize: 0.3,
  //       maxChildSize: 0.9,
  //       snap: true,
  //       snapSizes: const [0.6, 0.9],
  //       builder: (context, scrollController) => Container(
  //         decoration: BoxDecoration(
  //           color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
  //           borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  //         ),
  //         child: SingleChildScrollView(
  //           controller: scrollController,
  //           child: Padding(
  //             padding: const EdgeInsets.all(20),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Center(
  //                   child: Container(
  //                     width: 40,
  //                     height: 5,
  //                     margin: const EdgeInsets.only(bottom: 10),
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey[400],
  //                       borderRadius: BorderRadius.circular(2.5),
  //                     ),
  //                   ),
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(
  //                       width: width / 2 - 80,
  //                       child: Text(
  //                         'Notification Subject',
  //                         style: TextStyle(
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.bold,
  //                           color: Theme.of(context).colorScheme.inverseSurface,
  //                         ),
  //                       ),
  //                     ),
  //                     Text(
  //                       ':',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.bold,
  //                         color: Theme.of(context).colorScheme.inverseSurface,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 5),
  //                     SizedBox(
  //                       width: width / 2 - 60,
  //                       child: Text(
  //                         '${provider.notificationData[index].notificationsubject}' == 'null'
  //                             ? '-'
  //                             : '${provider.notificationData[index].notificationsubject}',
  //                         style: TextStyle(
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.bold,
  //                           color: Theme.of(context).colorScheme.inverseSurface,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10),
  //                 // Row(
  //                 //   crossAxisAlignment: CrossAxisAlignment.start,
  //                 //   children: [
  //                 //     SizedBox(
  //                 //       width: width / 2 - 80,
  //                 //       child: Text(
  //                 //         'View Status',
  //                 //         style: TextStyle(
  //                 //           fontSize: 12,
  //                 //           fontWeight: FontWeight.bold,
  //                 //           color: Theme.of(context).colorScheme.inverseSurface,
  //                 //         ),
  //                 //       ),
  //                 //     ),
  //                 //     Text(
  //                 //       ':',
  //                 //       style: TextStyle(
  //                 //         fontSize: 12,
  //                 //         fontWeight: FontWeight.bold,
  //                 //         color: Theme.of(context).colorScheme.inverseSurface,
  //                 //       ),
  //                 //     ),
  //                 //     const SizedBox(width: 5),
  //                 //     SizedBox(
  //                 //       width: width / 2 - 60,
  //                 //       child: Text(
  //                 //         '${provider.notificationData[index].viewstatus}' == 'null'
  //                 //             ? '-'
  //                 //             : '${provider.notificationData[index].viewstatus}',
  //                 //         style: TextStyle(
  //                 //           fontSize: 12,
  //                 //           fontWeight: FontWeight.bold,
  //                 //           color: Theme.of(context).colorScheme.inverseSurface,
  //                 //         ),
  //                 //       ),
  //                 //     ),
  //                 //   ],
  //                 // ),
  //                 // const SizedBox(height: 10),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(
  //                       width: width / 2 - 80,
  //                       child: Text(
  //                         'Notification Description',
  //                         style: TextStyle(
  //                           fontSize: 12,
  //                           fontWeight: FontWeight.bold,
  //                           color: Theme.of(context).colorScheme.inverseSurface,
  //                         ),
  //                       ),
  //                     ),
  //                     Text(
  //                       ':',
  //                       style: TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.bold,
  //                         color: Theme.of(context).colorScheme.inverseSurface,
  //                       ),
  //                     ),
  //                     const SizedBox(width: 5),
  //                     SizedBox(
  //                       width: width / 2 - 60,
  //                       child: isHtml('${provider.notificationData[index].notificationdescription}')
  //                           ? Html(
  //                               data: cleanHtml(provider.notificationData[index].notificationdescription ?? ''),
  //                               style: {
  //                                 'body': Style(
  //                                   margin: Margins.zero,
  //                                   padding: HtmlPaddings.zero,
  //                                   fontSize: FontSize(14),
  //                                   lineHeight: LineHeight(1.6),
  //                                   color: Colors.black87,
  //                                 ),
  //                                 'p': Style(
  //                                   margin: Margins.symmetric(vertical: 6),
  //                                 ),
  //                                 'br': Style(
  //                                   display: Display.block,
  //                                   margin: Margins.symmetric(vertical: 8),
  //                                 ),
  //                               },
  //                             )
  //                           : Text(
  //                               '${provider.notificationData[index].notificationdescription}' == 'null'
  //                                   ? '-'
  //                                   : '${provider.notificationData[index].notificationdescription}',
  //                               style: TextStyle(
  //                                 fontSize: 12,
  //                                 fontWeight: FontWeight.bold,
  //                                 color: Theme.of(context).colorScheme.inverseSurface,
  //                               ),
  //                             ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10),
  //                 // Row(
  //                 //   crossAxisAlignment: CrossAxisAlignment.start,
  //                 //   children: [
  //                 //     SizedBox(
  //                 //       width: width / 2 - 80,
  //                 //       child: Text(
  //                 //         'Notification Category Description',
  //                 //         style: TextStyle(
  //                 //           fontSize: 12,
  //                 //           fontWeight: FontWeight.bold,
  //                 //           color: Theme.of(context).colorScheme.inverseSurface,
  //                 //         ),
  //                 //       ),
  //                 //     ),
  //                 //     Text(
  //                 //       ':',
  //                 //       style: TextStyle(
  //                 //         fontSize: 12,
  //                 //         fontWeight: FontWeight.bold,
  //                 //         color: Theme.of(context).colorScheme.inverseSurface,
  //                 //       ),
  //                 //     ),
  //                 //     const SizedBox(width: 5),
  //                 //     SizedBox(
  //                 //       width: width / 2 - 60,
  //                 //       child: Text(
  //                 //         '${provider.notificationData[index].notificationcategorydesc}' == 'null'
  //                 //             ? '-'
  //                 //             : '${provider.notificationData[index].notificationcategorydesc}',
  //                 //         style: TextStyle(
  //                 //           fontSize: 12,
  //                 //           fontWeight: FontWeight.bold,
  //                 //           color: Theme.of(context).colorScheme.inverseSurface,
  //                 //         ),
  //                 //       ),
  //                 //     ),
  //                 //   ],
  //                 // ),
  //                 // const SizedBox(height: 10),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showNotificationDetails(BuildContext context, int index) {
    final provider = ref.read(notificationProvider); // Use read() since it's inside a function
    final themeProvider = pro.Provider.of<ThemeProvider>(context, listen: false);
    final width = MediaQuery.of(context).size.width;

    // Step 1: Unescape HTML entities like &lt; → <, &gt; → >
    String unescapeHtml(String? html) {
      if (html == null || html.isEmpty || html == 'null') return '-';
      return html
          .replaceAll('&lt;', '<')
          .replaceAll('&gt;', '>')
          .replaceAll('&quot;', '"')
          .replaceAll('&#39;', "'")
          .replaceAll('&amp;', '&');
    }

    // Step 2: Clean messy HTML (same as before, but now works on real tags)
    String cleanHtml(String html) {
      if (html.isEmpty || html == 'null') return '-';

      String cleaned = html
          .replaceAll(RegExp('<div[^>]*>', caseSensitive: false), '\n')
          .replaceAll('</div>', '')
          .replaceAll(RegExp('<span[^>]*>', caseSensitive: false), '')
          .replaceAll('</span>', '')
          .replaceAll(RegExp('<font[^>]*>', caseSensitive: false), '')
          .replaceAll('</font>', '')
          .replaceAll('<b>', '<strong>')
          .replaceAll('</b>', '</strong>')
          .replaceAll('&nbsp;', ' ')
          .replaceAll(RegExp(r'\s+\n'), '\n')
          .replaceAll(RegExp(r'\n{3,}'), '\n\n')
          .trim();

      // Convert remaining newlines to <br> for proper spacing
      cleaned = cleaned.replaceAll('\n', '<br>');

      // Wrap in paragraph if needed
      if (!cleaned.startsWith('<') && cleaned != '-') {
        cleaned = '<p>$cleaned</p>';
      }

      return cleaned;
    }

    // Step 3: Detect if it's HTML (after unescaping!)
    bool isHtml(String? input) {
      if (input == null || input.isEmpty || input == 'null') return false;
      final unescaped = unescapeHtml(input);
      return RegExp('<[^>]+>', caseSensitive: false).hasMatch(unescaped);
    }

    // Get the description and process it
    final rawDescription = provider.notificationData[index].notificationdescription ?? '';
    final unescapedDescription = unescapeHtml(rawDescription);
    final cleanedDescription = cleanHtml(unescapedDescription);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),

                // Subject
                _buildInfoRow('Notification Subject', provider.notificationData[index].notificationsubject ?? '-'),

                const SizedBox(height: 16),

                // Description Label
                Text(
                  'Notification Description:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                const SizedBox(height: 8),

                // Final HTML/Text Widget
                if (isHtml(rawDescription))
                  Html(
                    data: cleanedDescription,
                    style: {
                      'body': Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                        fontSize: FontSize(15),
                        lineHeight: LineHeight(1.7),
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                      'p': Style(margin: Margins.symmetric(vertical: 8)),
                      'br': Style(height: Height(8)),
                      'strong': Style(fontWeight: FontWeight.bold),
                    },
                  )
                else
                  Text(
                    rawDescription == 'null' ? '-' : rawDescription,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Helper widget for consistent styling
  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        const Text(': ', style: TextStyle(fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            value == 'null' ? '-' : value,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
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
