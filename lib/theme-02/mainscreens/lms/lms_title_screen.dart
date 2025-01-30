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
import 'package:sample/theme-02/mainscreens/lms/lms_classwork_detail_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_comment_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_faculty_comment_screen.dart';

class Theme02LmsTitlePage extends ConsumerStatefulWidget {
  const Theme02LmsTitlePage({
    required this.subjectID,
    super.key,
  });

  final String subjectID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02LmsTitlePageState();
}

class _Theme02LmsTitlePageState extends ConsumerState<Theme02LmsTitlePage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(lmsProvider.notifier).getLmsTitleDetails(
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(lmsProvider.notifier).getLmsTitleDetails(
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
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
              ref.read(lmsProvider.notifier).getLmsSubgetDetails(
                    ref.read(encryptionProvider.notifier),
                  );
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
            'LMS Title',
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
                      ref.read(lmsProvider.notifier).getLmsTitleDetails(
                            ref.read(encryptionProvider.notifier),
                            widget.subjectID,
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
      ),
      body: SingleChildScrollView(
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
                      padding: EdgeInsets.only(top: 100),
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
                  child:
                      CircularProgressIndicators.primaryColorProgressIndication,
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

          //  Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     const SizedBox(height: 20),
          //     if (provider is LibraryTrancsactionStateLoading)
          //       Padding(
          //         padding: const EdgeInsets.only(top: 100),
          //         child: Center(
          //           child: CircularProgressIndicators
          //               .primaryColorProgressIndication,
          //         ),
          //       )
          //     else if (provider.lmsTitleData.isEmpty &&
          //         provider is! LibraryTrancsactionStateLoading)
          //       Column(
          //         children: [
          //           SizedBox(height: MediaQuery.of(context).size.height / 5),
          //           const Center(
          //             child: Text(
          //               'No List Added Yet!',
          //               style: TextStyles.fontStyle1,
          //             ),
          //           ),
          //         ],
          //       ),
          //     if (provider.lmsTitleData.isNotEmpty)
          //       ListView.builder(
          //         itemCount: provider.lmsTitleData.length,
          //         controller: _listController,
          //         shrinkWrap: true,
          //         itemBuilder: (BuildContext context, int index) {
          //           return cardDesign(index);
          //         },
          //       ),
          //   ],
          // ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(lmsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Material(
        borderRadius: BorderRadius.circular(18),
        // Rounded corners for elegance
        color: Colors.white,
        elevation: 5,
        shadowColor: AppColors.theme01primaryColor.withOpacity(0.1),
        // Soft shadow
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppColors.theme02primaryColor,
                AppColors.theme02secondaryColor1,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20), // Clean and spacious padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Section with larger text for a bold look
                Row(
                  children: [
                    const Text(
                      'Work Type : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${provider.lmsTitleData[index].title}' == 'null'
                            ? '-'
                            : '${provider.lmsTitleData[index].classworktypedesc}',
                        style: TextStyle(
                          color: AppColors.theme02buttonColor2,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14), // More space between sections

                // Description Section with crisp text
                Row(
                  children: [
                    const Text(
                      'Title: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${provider.lmsTitleData[index].classworktypedesc}' ==
                                'null'
                            ? '-'
                            : '${provider.lmsTitleData[index].title}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Date Section with clear date format
                Row(
                  children: [
                    const Text(
                      'Start Date : ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${provider.lmsTitleData[index].startdatetime}' == 'null'
                          ? '-'
                          : '${provider.lmsTitleData[index].startdatetime}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text(
                      'End Date : ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${provider.lmsTitleData[index].enddatetime}' == 'null'
                          ? '-'
                          : '${provider.lmsTitleData[index].enddatetime}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 18), // Extra space for buttons
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
                            route: Theme02LmsClassworkDetailPage(
                              classworkID:
                                  '${provider.lmsTitleData[index].classworkid}',
                              // classworkreplyid:
                              //     '${provider.classWorkDetailsData[index].classworkid}',
                            ),
                          ),
                        );
                      },
                    ),
                    if (provider.lmsTitleData[index].classcomment != '0')
                      _buildActionButton(
                        label: 'Comments',
                        icon: Icons.comment,
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: Theme02LmsCommentScreen(
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
                              route: Theme02LmsFacultyCommentScreen(
                                classworkID:
                                    '${provider.lmsTitleData[index].classworkid}',
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
              AppColors.theme02buttonColor1,
              AppColors.theme02buttonColor2,
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
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
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
