// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_classwork_detail_screen.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_comment_screen.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_faculty_comment_screen.dart';

class Theme01LmsTitlePage extends ConsumerStatefulWidget {
  const Theme01LmsTitlePage({
    required this.subjectID,
    super.key,
  });
  final String subjectID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01LmsTitlePageState();
}

class _Theme01LmsTitlePageState extends ConsumerState<Theme01LmsTitlePage> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmsTitleDetails(
              ref.read(encryptionProvider.notifier),
              widget.subjectID,
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
      ref.read(lmsProvider.notifier).getLmsTitleDetails(
            ref.read(encryptionProvider.notifier),
            widget.subjectID,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);
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
            AppBar(
              leading: IconButton(
                onPressed: () {
                  ref.read(lmsProvider.notifier).getLmsSubgetDetails(
                        ref.read(encryptionProvider.notifier),
                      );
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'LMS Title',
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
                          ref.read(lmsProvider.notifier).getLmsTitleDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.subjectID,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                if (provider is LmsStateLoading)
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      const Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text(
                            'No List Added',
                            style: TextStyles.fontStyle1,
                          ),
                        ),
                      ),
                    ],
                  )
                else if (provider.lmsTitleData.isEmpty &&
                    provider is! LmsStateLoading)
                  Center(
                    child: CircularProgressIndicators
                        .theme01primaryColorProgressIndication,
                  ),
                if (provider.lmsTitleData.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.lmsTitleData.length,
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Material(
        elevation: 5,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.theme01secondaryColor1,
                AppColors.theme01secondaryColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ExpansionTile(
              title: Row(
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: Text(
                      'Title :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.lmsTitleData[index].title}' == 'null'
                          ? '-'
                          : '''${provider.lmsTitleData[index].title}''',
                      style: TextStyles.fontStyle2,
                    ),
                  ),
                ],
              ),
              collapsedIconColor: AppColors.theme01primaryColor,
              iconColor: AppColors.theme01primaryColor,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Start Date Time :',
                  '${provider.lmsTitleData[index].startdatetime}' == 'null'
                      ? '-'
                      : '''${provider.lmsTitleData[index].startdatetime}''',
                  width,
                ),
                _buildRow(
                  'End Date Time',
                  '${provider.lmsTitleData[index].enddatetime}' == 'null'
                      ? '-'
                      : '''${provider.lmsTitleData[index].enddatetime}''',
                  width,
                ),
                _buildRow(
                  'Subject Desc',
                  '${provider.lmsTitleData[index].classworktypedesc}' == 'null'
                      ? '-'
                      : '''${provider.lmsTitleData[index].classworktypedesc}''',
                  width,
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      label: 'View',
                      icon: Icons.visibility,
                      onTap: () {
                        ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
                              ref.read(encryptionProvider.notifier),
                              '${provider.lmsTitleData[index].classworkid}',
                            );
                        Navigator.push(
                          context,
                          RouteDesign(
                            route: Theme01LmsClassworkDetailPage(
                              classworkID:
                                  '${provider.lmsTitleData[index].classworkid}',
                            ),
                          ),
                        );
                      },
                    ),
                    _buildActionButton(
                      label: 'Comments',
                      icon: Icons.comment,
                      onTap: () {
                        Navigator.push(
                          context,
                          RouteDesign(
                            route: Theme01LmsCommentScreen(
                              classworkID:
                                  '${provider.lmsTitleData[index].classworkid}',
                            ),
                          ),
                        );
                      },
                    ),
                    if (provider.lmsTitleData[index].privatecomment != '0')
                      _buildActionButton(
                        label: 'Faculty Chat',
                        icon: Icons.chat,
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: Theme01LmsFacultyCommentScreen(
                                classworkID:
                                    '${provider.lmsTitleData[index].classworkid}',
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     SizedBox(
                //       height: 30,
                //       width: 70,
                //       child: GestureDetector(
                //         onTap: () {
                //           ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
                //                 ref.read(encryptionProvider.notifier),
                //                 '${provider.lmsTitleData[index].classworkid}',
                //               );

                //           Navigator.push(
                //             context,
                //             RouteDesign(
                //               route: Theme01LmsClassworkDetailPage(
                //                 classworkID:
                //                     '${provider.lmsTitleData[index].classworkid}',
                //               ),
                //             ),
                //           );
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: AppColors.theme01primaryColor,
                //             borderRadius: BorderRadius.circular(12),
                //           ),
                //           child: const Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Center(
                //                 child: Text(
                //                   'View',
                //                   style: TextStyles.fontStyle5,
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     // if (provider.lmsTitleData[index].classcomment != '0')
                //     Column(
                //       children: [
                //         SizedBox(
                //           height: 30,
                //           width: 100,
                //           child: GestureDetector(
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 RouteDesign(
                //                   route: Theme01LmsCommentScreen(
                //                     classworkID:
                //                         '${provider.lmsTitleData[index].classworkid}',
                //                   ),
                //                 ),
                //               );
                //             },
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 color: AppColors.theme01primaryColor,
                //                 borderRadius: BorderRadius.circular(12),
                //               ),
                //               child: const Column(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Center(
                //                     child: Text(
                //                       'Comments',
                //                       style: TextStyles.fontStyle5,
                //                       textAlign: TextAlign.center,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     Column(
                //       children: [
                //         if (provider.lmsTitleData[index].privatecomment != '0')
                //           SizedBox(
                //             height: 30,
                //             width: 100,
                //             child: GestureDetector(
                //               onTap: () {
                //                 Navigator.push(
                //                   context,
                //                   RouteDesign(
                //                     route: Theme01LmsFacultyCommentScreen(
                //                       classworkID:
                //                           '${provider.lmsTitleData[index].classworkid}',
                //                       // studentclassworkcommentid:
                //                       //     '${provider.lmsfacultygetcommentData[index].studentclassworkcommentid}',
                //                     ),
                //                   ),
                //                 );
                //               },
                //               child: Container(
                //                 decoration: BoxDecoration(
                //                   color: AppColors.theme01primaryColor,
                //                   borderRadius: BorderRadius.circular(10),
                //                 ),
                //                 child: const Column(
                //                   mainAxisAlignment: MainAxisAlignment.center,
                //                   children: [
                //                     Center(
                //                       child: Text(
                //                         'Faculty Chat',
                //                         style: TextStyles.fontStyle5,
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           ),
                //       ],
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            title,
            style: TextStyles.buttonStyle01theme2,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle2,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle2,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40, // Adequate height for buttons
        width: 100, // Optimized width
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.theme01primaryColor,
              AppColors.theme01primaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.theme01primaryColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.whiteColor, size: 16),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
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
