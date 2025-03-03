import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20details%20riverpod/lms_content_details_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_content_details_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_title_screen.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/lms_content_details.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/lms_title_page.dart';

class Theme07LmsHomePage extends ConsumerStatefulWidget {
  const Theme07LmsHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07LmsHomePageState();
}

class _Theme07LmsHomePageState extends ConsumerState<Theme07LmsHomePage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(lmsProvider.notifier).getLmsSubgetDetails(
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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(lmsProvider.notifier).getLmsSubgetDetails(
              ref.read(encryptionProvider.notifier),
            );
      },
    );
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
      backgroundColor: AppColors.theme07secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme07primaryColor,
                  AppColors.theme07primaryColor,
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
          title: const Text(
            'LMS Subject',
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
                      ref.read(lmsProvider.notifier).getLmsSubgetDetails(
                            ref.read(encryptionProvider.notifier),
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
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.lmsSubjectData.isEmpty &&
                  provider is! LmsStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added',
                        style: TextStyles.fontStyle1,
                      ),
                    ),
                  ],
                ),
              if (provider.lmsSubjectData.isNotEmpty)
                ListView.builder(
                  itemCount: provider.lmsSubjectData.length,
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
    final provider = ref.watch(lmsProvider);

    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Card Header with Gradient
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.theme07primaryColor,
                    AppColors.theme07primaryColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text(
                  provider.lmsSubjectData[index].subjectdesc ?? 'Course Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            // Card Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.code, 'Course Code',
                      provider.lmsSubjectData[index].subjectcode),
                  const SizedBox(height: 8),
                  _infoRow(Icons.person, 'Staff',
                      provider.lmsSubjectData[index].staffname),
                ],
              ),
            ),

            // Action Buttons
            const Divider(height: 1, color: Colors.grey),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      ref.read(lmsProvider.notifier).getLmsTitleDetails(
                            ref.read(encryptionProvider.notifier),
                            '${provider.lmsSubjectData[index].subjectid}',
                          );
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: Theme07LmsTitlePage(
                            subjectID:
                                '${provider.lmsSubjectData[index].subjectid}',
                          ),
                        ),
                      );
                    },
                    // icon: const Icon(Icons.book, color: Colors.white),
                    label: Text(
                      'Classwork Details',
                      style: TextStyle(
                          color: AppColors.theme07primaryColor,
                          fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.grey),
                Expanded(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () {
                      ref
                          .read(lmsContentDetailsProvider.notifier)
                          .getLmsContentDetails(
                            ref.read(encryptionProvider.notifier),
                            '${provider.lmsSubjectData[index].subjectid}',
                          );
                      Navigator.push(
                        context,
                        RouteDesign(
                          route: Theme07LmsContentDetailsPage(
                            subjectid:
                                '${provider.lmsSubjectData[index].subjectid}',
                          ),
                        ),
                      );
                    },
                    // icon: const Icon(Icons.file_copy, color: Colors.white),
                    label: Text(
                      'Content Details',
                      style: TextStyle(
                          // color: AppColors.theme02buttonColor2,

                          color: AppColors.theme07primaryColor,
                          fontWeight: FontWeight.bold,),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Helper method to create info rows
  Widget _infoRow(IconData icon, String title, String? value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.theme07primaryColor, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$title: ${value ?? 'N/A'}',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
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
