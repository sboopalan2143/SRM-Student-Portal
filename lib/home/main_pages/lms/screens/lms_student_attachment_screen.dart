// ignore_for_file: lines_longer_than_80_chars
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/main_pages/lms/screens/pdf_view_page.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class LmsStudentAttachmentDetailsDataPage extends ConsumerStatefulWidget {
  const LmsStudentAttachmentDetailsDataPage({
    required this.classworkreplyid,
    super.key,
  });

  final String classworkreplyid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      LmsStudentAttachmentDetailsDataPageState();
}

class LmsStudentAttachmentDetailsDataPageState
    extends ConsumerState<LmsStudentAttachmentDetailsDataPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

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
                  ref.read(lmsProvider.notifier).getLmsStudentAttachmentDetails(
                        ref.read(encryptionProvider.notifier),
                        widget.classworkreplyid,
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
          ],
        ),
      ),
      body: LiquidPullToRefresh(
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

    // final pdfBytes =
    //     '${provider.lmsStudentAttachmentDetailsData[index].imageBytes}';
    // final imageBytes = base64Decode(pdfBytes);

    // final base64Image =
    //     '${provider.lmsStudentAttachmentDetailsData[index].imageBytes}'; // shortened for brevity
    // final imageBytes = base64Decode(base64Image);

    // log('Student Attachment PDF >>> ${provider.lmsStudentAttachmentDetailsData[index].imageBytes}');
    // log('Student Attachment image PDF >>> $imageBytes');
    // log('Student Model data>> ${provider.lmsStudentAttachmentDetailsData[index].imageBytes}');

    // Get base64 data and decode
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
      // PDF display
      fileDisplayWidget = GestureDetector(
        onTap: () {
          // Navigate to a PDF viewer page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PDFViewPage(
                pdfData: fileBytes, // Pass the PDF bytes here
                fileName: actualname, // Pass the file name (or title)
              ),
            ),
          );
        },
        child: const Center(
          child: Text(
            'Tap to view PDF',
            style: TextStyles.fontStyle10,
          ),
        ),
      );
    } else if (fileExtension == 'xls' || fileExtension == 'xlsx') {
      // Placeholder for Excel
      fileDisplayWidget = GestureDetector(
        onTap: () {
          // Handle Excel file (e.g., download or navigate to a viewer)
          showToast(
            'Excel viewing not supported. File downloaded.',
          );
        },
        child: const Center(
          child: Text(
            'Tap to download Excel',
            style: TextStyles.fontStyle10,
          ),
        ),
      );
    } else {
      // Unsupported file type
      fileDisplayWidget = const Center(
        child: Text(
          'Unsupported file type',
          style: TextStyles.fontStyle10,
        ),
      );
    }

    return GestureDetector(
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
                //         'Image',
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
                //         '${provider.lmsStudentAttachmentDetailsData[index].imageBytes}' ==
                //                 ''
                //             ? '-'
                //             : '${provider.lmsStudentAttachmentDetailsData[index].imageBytes}',
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
                      child: const Text(
                        'Actual name',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.lmsStudentAttachmentDetailsData[index].actualname}' ==
                                ''
                            ? '-'
                            : '''${provider.lmsStudentAttachmentDetailsData[index].actualname}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width / 2 - 80,
                      child: const Text(
                        'File name',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                    const Text(
                      ':',
                      style: TextStyles.fontStyle10,
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 2 - 60,
                      child: Text(
                        '${provider.lmsStudentAttachmentDetailsData[index].filename}' ==
                                ''
                            ? '-'
                            : '${provider.lmsStudentAttachmentDetailsData[index].filename}',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),

                Center(
                  child:
                      //  SizedBox(
                      //   height: 200,
                      //   width: width - 100,
                      //   child: ClipRRect(
                      //     // borderRadius: BorderRadius.circular(50),
                      //     child: Image.memory(
                      //       imageBytes,
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                    height: 200,
                    width: width - 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: fileDisplayWidget,
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
