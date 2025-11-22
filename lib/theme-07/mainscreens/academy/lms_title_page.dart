// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_entry_test_screen.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_classworkdetails.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_comment_screen.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_faclty_message.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07LmsTitlePage extends ConsumerStatefulWidget {
  const Theme07LmsTitlePage({
    required this.subjectID,
    super.key,
  });

  final String subjectID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07LmsTitlePageState();
}

class _Theme07LmsTitlePageState extends ConsumerState<Theme07LmsTitlePage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          title: Text(
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
              // const SizedBox(height: 20),

              if (provider is LmsStateLoading)
                Center(
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                )
              else if ((provider.lmsTitleData.isEmpty || provider is LmsStateError) && provider is! LmsStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          'No List Added',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                        ),
                      ),
                    ),
                  ],
                )
              else if (provider.lmsTitleData.isNotEmpty && provider is! LmsStateError && provider is! LmsStateLoading)
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    // log('$index');

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Work Type',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.lmsTitleData[index].classworktypedesc}' == ''
                          ? '-'
                          : '${provider.lmsTitleData[index].classworktypedesc}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Title',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.lmsTitleData[index].title}' == '' ? '-' : '${provider.lmsTitleData[index].title}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Start Date',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.lmsTitleData[index].startdatetime}' == ''
                          ? '-'
                          : '${provider.lmsTitleData[index].startdatetime}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'End Date',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.lmsTitleData[index].enddatetime}' == ''
                          ? '-'
                          : '${provider.lmsTitleData[index].enddatetime}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  _buildActionButton(
                    label: 'View',
                    icon: Icons.visibility,
                    onTap: () async {
                      log('${provider.lmsTitleData[index].classworkid}');

                      await Navigator.push(
                        context,
                        RouteDesign(
                          route: Theme07LmsClassworkDetailPage(
                            classworkID: '${provider.lmsTitleData[index].classworkid}',
                            subjectID: widget.subjectID,
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
                            route: Theme07LmsCommentScreen(
                              classworkID: '${provider.lmsTitleData[index].classworkid}',
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
                            route: Theme07LmsFacultyCommentScreen(
                              classworkID: '${provider.lmsTitleData[index].classworkid}',
                            ),
                          ),
                        );
                      },
                    ),
                  if (provider.lmsTitleData[index].classworktypedesc == 'Mcq')
                    _buildActionButton(
                      label: 'MCQ Test',
                      icon: Icons.question_mark_sharp,
                      onTap: () {
                        Navigator.push(
                          context,
                          RouteDesign(
                            route: Theme02McqEnteryPage(
                              mcqscheduleid: '${provider.classWorkDetailsData[index].mcqscheduleid}',
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
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
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
