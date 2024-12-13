// ignore_for_file: lines_longer_than_80_chars
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_pdf_view_page.dart';

class Theme02LmsStudentAttachmentDetailsDataPage
    extends ConsumerStatefulWidget {
  const Theme02LmsStudentAttachmentDetailsDataPage({
    required this.classworkreplyid,
    super.key,
  });
  final String classworkreplyid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      Theme02LmsStudentAttachmentDetailsDataPageState();
}

class Theme02LmsStudentAttachmentDetailsDataPageState
    extends ConsumerState<Theme02LmsStudentAttachmentDetailsDataPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmsStudentAttachmentDetails(
              ref.read(encryptionProvider.notifier),
              widget.classworkreplyid,
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
      ref.read(lmsProvider.notifier).getLmsStudentAttachmentDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkreplyid,
          );
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
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
      key: scaffoldKey,
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
            'Student Attachment Details',
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
                          .getLmsStudentAttachmentDetails(
                            ref.read(encryptionProvider.notifier),
                            widget.classworkreplyid,
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
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primaryColor,
        child: SingleChildScrollView(
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
                else if (provider.lmsStudentAttachmentDetailsData.isEmpty &&
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
                if (provider.lmsStudentAttachmentDetailsData.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.lmsStudentAttachmentDetailsData.length,
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

    final base64File =
        '${provider.lmsStudentAttachmentDetailsData[index].imageBytes}';
    final fileBytes = base64Decode(base64File);

    // File name to determine type
    final actualname =
        provider.lmsStudentAttachmentDetailsData[index].actualname ?? '';
    final fileExtension = actualname.split('.').last.toLowerCase();

    // Log details (optional for debugging)
    log('File Name: $actualname');
    log('File Extension: $fileExtension');

    // Widget to display based on file type
    Widget fileDisplayWidget;

    if (['png', 'jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
      // Image display
      fileDisplayWidget = Image.memory(
        fileBytes,
        fit: BoxFit.cover,
      );
    } else if (fileExtension == 'pdf') {
      fileDisplayWidget = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Theme01PDFViewPage(
                pdfData: fileBytes,
                fileName: actualname,
              ),
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
              size: 30,
            ),
            SizedBox(width: 12),
            Text(
              'Tap to view PDF',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else if (fileExtension == 'xls' || fileExtension == 'xlsx') {
      fileDisplayWidget = GestureDetector(
        onTap: () {
          showToast(
            'Excel viewing not supported. File downloaded.',
          );
        },
        child: const Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.table_chart,
                color: Colors.green,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Tap to download Excel',
                style: TextStyles.fontStyle3,
              ),
            ],
          ),
        ),
      );
    } else {
      // Unsupported file type
      fileDisplayWidget = const Center(
        child: Text(
          'Unsupported file type',
          style: TextStyles.fontStyle3,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Material(
        elevation: 5,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: Container(
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
            padding: const EdgeInsets.all(20),
            child: ExpansionTile(
              title: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: width - 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: fileDisplayWidget,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              collapsedIconColor: AppColors.theme02buttonColor2,
              iconColor: AppColors.theme02buttonColor2,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Actual name :',
                  '${provider.lmsStudentAttachmentDetailsData[index].actualname}' ==
                          'null'
                      ? '-'
                      : '''${provider.lmsStudentAttachmentDetailsData[index].actualname}''',
                  width,
                ),
                _buildRow(
                  'File name :',
                  '${provider.lmsStudentAttachmentDetailsData[index].filename}' ==
                          'null'
                      ? '-'
                      : '''${provider.lmsStudentAttachmentDetailsData[index].filename}''',
                  width,
                ),
                const SizedBox(
                  height: 10,
                ),
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
            style: TextStyles.fontStyle3,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle3,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle3,
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
