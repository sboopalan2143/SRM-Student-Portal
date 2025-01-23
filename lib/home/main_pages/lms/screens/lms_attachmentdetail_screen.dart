import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
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
// import 'package:sample/home/riverpod/main_state.dart';

class LmsAttachmentDetailsDataPage extends ConsumerStatefulWidget {
  const LmsAttachmentDetailsDataPage({
    required this.classworkID,
    super.key,
  });

  final String classworkID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      LmsAttachmentDetailsDataPageState();
}

class LmsAttachmentDetailsDataPageState
    extends ConsumerState<LmsAttachmentDetailsDataPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
              ref.read(encryptionProvider.notifier),
              widget.classworkID,
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
      ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
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
                  ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
                        ref.read(encryptionProvider.notifier),
                        widget.classworkID,
                      );
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   RouteDesign(
                  //     route: const HomePage2(),
                  //   ),
                  // );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Attachment Details',
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
                              .getLmsAttachmentDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.classworkID,
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
                if (provider is LmsStateLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircularProgressIndicators
                          .primaryColorProgressIndication,
                    ),
                  )
                else if (provider.lmsAttachmentDetailsData.isEmpty &&
                    provider is! LmsStateLoading)
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      const Center(
                        child: Text(
                          'No Data Yet!',
                          style: TextStyles.fontStyle,
                        ),
                      ),
                    ],
                  ),
                if (provider.lmsAttachmentDetailsData.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.lmsAttachmentDetailsData.length,
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

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //   final provider = ref.watch(lmsProvider);
  //   // final base64Image =
  //   //     '${provider.lmsAttachmentDetailsData[index].imageBytes}'; // shortened for brevity
  //   // final imageBytes = base64Decode(base64Image);

  //   final pdfBytes = provider.lmsAttachmentDetailsData[index] as Uint8List?;

  //   log('Attachment PDF >>> $pdfBytes');

  //   // log('Attachment image >>> $imageBytes');
  //   return GestureDetector(
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 8),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: const BorderRadius.all(Radius.circular(20)),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.2),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: const Offset(0, 3),
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: Column(
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'File',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                 ],
  //               ),
  //               Center(
  //                 child: SizedBox(
  //                   height: 200,
  //                   width: width - 100,
  //                   child: pdfBytes != null
  //                       ? PDFView(
  //                           pdfData: pdfBytes,
  //                           fitEachPage: true,
  //                           fitPolicy: FitPolicy.BOTH,
  //                           backgroundColor: Colors.grey[300],
  //                         )
  //                       : const Center(
  //                           child: Text(
  //                             'No PDF available',
  //                             style: TextStyles.fontStyle10,
  //                           ),
  //                         ),
  //                 ),
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'Actual name',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.lmsAttachmentDetailsData[index].actualname}' ==
  //                               ''
  //                           ? '-'
  //                           : '''${provider.lmsAttachmentDetailsData[index].actualname}''',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   SizedBox(
  //                     width: width / 2 - 80,
  //                     child: const Text(
  //                       'File name',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                   const Text(
  //                     ':',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                   const SizedBox(width: 5),
  //                   SizedBox(
  //                     width: width / 2 - 60,
  //                     child: Text(
  //                       '${provider.lmsAttachmentDetailsData[index].filename}' ==
  //                               ''
  //                           ? '-'
  //                           : '${provider.lmsAttachmentDetailsData[index].filename}',
  //                       style: TextStyles.fontStyle10,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);

    // final pdfBytes = '${provider.lmsAttachmentDetailsData[index].imageBytes}';
    // final imageBytes = base64Decode(pdfBytes);

    // log('Attachment PDF >>> ${provider.lmsAttachmentDetailsData[index].imageBytes}');
    // log('Attachment image PDF >>> $imageBytes');
    // log('Model data>> ${provider.lmsAttachmentDetailsData[index].imageBytes}');
    final base64File = '${provider.lmsAttachmentDetailsData[index].imageBytes}';
    final fileBytes = base64Decode(base64File);

    // File name to determine type
    final actualname =
        provider.lmsAttachmentDetailsData[index].actualname ?? '';
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
                color: Colors.black,
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
                style: TextStyles.fontStyle10,
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
                //         'File',
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //     const Text(
                //       ':',
                //       style: TextStyles.fontStyle10,
                //     ),
                //     const SizedBox(width: 5),
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (_) => const Pdfview(
                //               url:
                //                   'https://assets.website-files.com/603d0d2db8ec32ba7d44fffe/603d0e327eb2748c8ab1053f_loremipsum.pdf',
                //             ),
                //           ),
                //         );
                //       },
                //       child: const Text('PDF From URL'),
                //     )
                //   ],
                // ),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     SizedBox(
                //       width: width / 2 - 80,
                //       child: const Text(
                //         'Excel',
                //         style: TextStyles.fontStyle10,
                //       ),
                //     ),
                //     const Text(
                //       ':',
                //       style: TextStyles.fontStyle10,
                //     ),
                //     const SizedBox(width: 5),
                //     const SizedBox(width: 5),
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (_) => ExcelViewer(),
                //           ),
                //         );
                //       },
                //       child: const Text('Excel'),
                //     )
                //   ],
                // ),
                // Center(
                //   child: SizedBox(
                //     height: 200,
                //     width: width - 100,
                //     child: imageBytes != ''
                //         ? PDFView(
                //             pdfData: imageBytes,
                //             fitPolicy: FitPolicy.BOTH,
                //             backgroundColor: Colors.grey[300],
                //           )
                //         : const Center(
                //             child: Text(
                //               'No PDF available',
                //               style: TextStyles.fontStyle10,
                //             ),
                //           ),
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

                const SizedBox(
                  height: 10,
                ),
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
                        '${provider.lmsAttachmentDetailsData[index].actualname}' ==
                                ''
                            ? '-'
                            : '${provider.lmsAttachmentDetailsData[index].actualname}',
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
                        '${provider.lmsAttachmentDetailsData[index].filename}' ==
                                ''
                            ? '-'
                            : '${provider.lmsAttachmentDetailsData[index].filename}',
                        style: TextStyles.fontStyle10,
                      ),
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
