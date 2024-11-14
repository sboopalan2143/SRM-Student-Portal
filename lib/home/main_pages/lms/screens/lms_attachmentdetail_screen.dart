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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

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
      key: scaffoldKey,
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
                else if (provider.lmsAttachmentDetailsData.isEmpty &&
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

    final pdfBytes = '${provider.lmsAttachmentDetailsData[index].imageBytes}';
    final imageBytes = base64Decode(pdfBytes);

    log('Attachment PDF >>> ${provider.lmsAttachmentDetailsData[index].imageBytes}');
    log('Attachment image PDF >>> $imageBytes');
    log('Model data>> ${provider.lmsAttachmentDetailsData[index].imageBytes}');

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
                Center(
                  child: SizedBox(
                    height: 200,
                    width: width - 100,
                    child: imageBytes != ''
                        ? PDFView(
                            pdfData: imageBytes,
                            fitPolicy: FitPolicy.BOTH,
                            backgroundColor: Colors.grey[300],
                          )
                        : const Center(
                            child: Text(
                              'No PDF available',
                              style: TextStyles.fontStyle10,
                            ),
                          ),
                  ),
                ),
                // Card(
                //   elevation: 10,
                //   child: ElevatedButton(
                //     child: const Text(
                //       'View Doc',
                //       style: TextStyle(fontSize: 20),
                //     ),
                //     // AppColors: Colors.blueGrey,
                //     // textColor: Colors.white,
                //     // highlightColor: Colors.red,
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (_) => const Pdfview(
                //             url:
                //                 'https://assets.website-files.com/603d0d2db8ec32ba7d44fffe/603d0e327eb2748c8ab1053f_loremipsum.pdf',
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
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

class Pdfview extends StatelessWidget {
  const Pdfview({
    super.key,
    required this.url,
  });
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PDF From URL',
        ),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(
          child: Text('$progress %'),
        ),
        errorWidget: (dynamic error) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}

class ExcelViewer extends StatefulWidget {
  @override
  _ExcelViewerState createState() => _ExcelViewerState();
}

class _ExcelViewerState extends State<ExcelViewer> {
  List<List<String>>? excelData;

  Future<void> loadExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      Uint8List? bytes = result.files.first.bytes;
      if (bytes != null) {
        var excel = Excel.decodeBytes(bytes);

        List<List<String>> rows = [];
        for (var table in excel.tables.keys) {
          for (var row in excel.tables[table]!.rows) {
            rows.add(row.map((e) => e?.value.toString() ?? '').toList());
          }
        }
        setState(() {
          excelData = rows;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel Viewer'),
      ),
      body: excelData != null
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: excelData![0]
                    .map((header) => DataColumn(label: Text(header)))
                    .toList(),
                rows: excelData!
                    .skip(1)
                    .map(
                      (row) => DataRow(
                        cells: row.map((cell) => DataCell(Text(cell))).toList(),
                      ),
                    )
                    .toList(),
              ),
            )
          : Center(
              child: ElevatedButton(
                onPressed: loadExcelFile,
                child: const Text('Load Excel File'),
              ),
            ),
    );
  }
}
