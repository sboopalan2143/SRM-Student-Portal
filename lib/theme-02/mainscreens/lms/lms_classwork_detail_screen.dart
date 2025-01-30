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
import 'package:sample/theme-01/mainscreens/lms/lms_entry_test_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_attachment_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_entry_test_screen.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_pdf_view_page.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_save_attachment.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_student_attachment_screen.dart';

class Theme02LmsClassworkDetailPage extends ConsumerStatefulWidget {
  const Theme02LmsClassworkDetailPage({
    required this.classworkID,
    super.key,
  });

  final String classworkID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02LmsClassworkDetailPageState();
}

class _Theme02LmsClassworkDetailPageState
    extends ConsumerState<Theme02LmsClassworkDetailPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
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
      ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
          );
      ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
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
            'Class Work Details',
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
                      ref.read(lmsProvider.notifier).getLmscommentDetails(
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
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.classWorkDetailsData.isEmpty &&
                  provider is! LibraryTrancsactionStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle,
                      ),
                    ),
                  ],
                ),
              if (provider.classWorkDetailsData.isNotEmpty)
                ListView.builder(
                  itemCount: provider.classWorkDetailsData.length,
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

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //   final provider = ref.watch(lmsProvider);
  //
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
  //     child: Material(
  //       elevation: 5,
  //       shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
  //       borderRadius: BorderRadius.circular(20),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           gradient: LinearGradient(
  //             colors: [
  //               AppColors.theme02primaryColor,
  //               AppColors.theme02secondaryColor1,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: ExpansionTile(
  //             title: Row(
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 100,
  //                   child: const Text(
  //                     'ID :',
  //                     style: TextStyles.fontStyle13,
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     '${provider.classWorkDetailsData[index].classworkid}' ==
  //                             'null'
  //                         ? '-'
  //                         : '''${provider.classWorkDetailsData[index].classworkid}''',
  //                     style: TextStyles.theme02fontStyle2,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             collapsedIconColor: AppColors.theme02buttonColor2,
  //             iconColor: AppColors.theme02buttonColor2,
  //             children: [
  //               Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
  //               _buildRow(
  //                 'class work type desc :',
  //                 '${provider.classWorkDetailsData[index].classworktypedesc}' ==
  //                         'null'
  //                     ? '-'
  //                     : '''${provider.classWorkDetailsData[index].classworktypedesc}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Dp start date time',
  //                 '${provider.classWorkDetailsData[index].dpstartdatetime}' ==
  //                         'null'
  //                     ? '-'
  //                     : '''${provider.classWorkDetailsData[index].dpstartdatetime}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Dp end date time',
  //                 '${provider.classWorkDetailsData[index].dpenddatetime}' ==
  //                         'null'
  //                     ? '-'
  //                     : '''${provider.classWorkDetailsData[index].dpenddatetime}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Topic desc',
  //                 '${provider.classWorkDetailsData[index].topicdesc}' == 'null'
  //                     ? '-'
  //                     : '''${provider.classWorkDetailsData[index].topicdesc}''',
  //                 width,
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const SizedBox(height: 20),
  //                   if (provider is LibraryTrancsactionStateLoading)
  //                     const Center(
  //                       child: Text(
  //                         'No List Added',
  //                         style: TextStyles.fontStyle1,
  //                       ),
  //                     )
  //                   else if (provider.lmsAttachmentDetailsData.isEmpty &&
  //                       provider is! LibraryTrancsactionStateLoading)
  //                     Column(
  //                       children: [
  //                         SizedBox(
  //                             height: MediaQuery.of(context).size.height / 5),
  //                         Center(
  //                           child: CircularProgressIndicators
  //                               .primaryColorProgressIndication,
  //                         ),
  //                       ],
  //                     ),
  //                   if (provider.lmsAttachmentDetailsData.isNotEmpty)
  //                     ListView.builder(
  //                       itemCount: provider.lmsAttachmentDetailsData.length,
  //                       controller: _listController,
  //                       shrinkWrap: true,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return cardStaffAttachmentDesign(index);
  //                       },
  //                     ),
  //                 ],
  //               ),
  //               Wrap(
  //                 spacing: 10, // Horizontal spacing between buttons
  //                 runSpacing:
  //                     10, // Vertical spacing when wrapping to the next line
  //                 alignment: WrapAlignment.center, // Center the buttons
  //                 children: [
  //                   SizedBox(
  //                     height: 30,
  //                     width: 150,
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         ref
  //                             .read(lmsProvider.notifier)
  //                             .getLmsAttachmentDetails(
  //                               ref.read(encryptionProvider.notifier),
  //                               '${provider.classWorkDetailsData[index].classworkid}',
  //                             );
  //
  //                         Navigator.push(
  //                           context,
  //                           RouteDesign(
  //                             route: Theme02LmsAttachmentDetailsDataPage(
  //                               classworkID:
  //                                   '${provider.classWorkDetailsData[index].classworkid}',
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           color: AppColors.theme02buttonColor2,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: const Center(
  //                           child: Text(
  //                             'Attachments',
  //                             style: TextStyles.fontStyle5,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 30,
  //                     width: 150,
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         ref
  //                             .read(lmsProvider.notifier)
  //                             .getLmsStudentAttachmentDetails(
  //                               ref.read(encryptionProvider.notifier),
  //                               '${provider.classWorkDetailsData[index].classworkreplyid}',
  //                             );
  //                         Navigator.push(
  //                           context,
  //                           RouteDesign(
  //                             route: Theme02LmsStudentAttachmentDetailsDataPage(
  //                               classworkreplyid:
  //                                   '${provider.classWorkDetailsData[index].classworkreplyid}',
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           color: AppColors.theme02buttonColor2,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: const Center(
  //                           child: Text(
  //                             'Student Attachments',
  //                             style: TextStyles.fontStyle5,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: 10,
  //               ),
  //               Wrap(
  //                 spacing: 10, // Horizontal spacing between buttons
  //                 runSpacing:
  //                     10, // Vertical spacing between rows when wrapping occurs
  //                 alignment: WrapAlignment.center, // Center the buttons
  //                 children: [
  //                   if (provider.classWorkDetailsData[index].classworkreplyid ==
  //                       '0')
  //                     SizedBox(
  //                       height: 30,
  //                       width: 150,
  //                       child: GestureDetector(
  //                         onTap: () {
  //                           Navigator.push(
  //                             context,
  //                             RouteDesign(
  //                               route: Theme02LmsSaveWorkReplayDetailsDataPage(
  //                                 classworkID:
  //                                     '${provider.classWorkDetailsData[index].classworkid}',
  //                                 classworkreplyid:
  //                                     '${provider.classWorkDetailsData[index].classworkreplyid}',
  //                                 fieldrequirements:
  //                                     '${provider.classWorkDetailsData[index].fieldrequirement}',
  //                                 imageattachmentid:
  //                                     '${provider.classWorkDetailsData[index].stuimageattachmentid}',
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                         child: Container(
  //                           decoration: BoxDecoration(
  //                             color: AppColors.theme02buttonColor2,
  //                             borderRadius: BorderRadius.circular(10),
  //                           ),
  //                           child: const Center(
  //                             child: Text(
  //                               'Save Attachment',
  //                               style: TextStyles.fontStyle5,
  //                               textAlign: TextAlign.center,
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   SizedBox(
  //                     height: 30,
  //                     width: 150,
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         Navigator.push(
  //                           context,
  //                           RouteDesign(
  //                             route: Theme02McqEnteryPage(
  //                               mcqscheduleid:
  //                                   '${provider.classWorkDetailsData[index].mcqscheduleid}',
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                       child: Container(
  //                         decoration: BoxDecoration(
  //                           color: AppColors.theme02buttonColor2,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         child: const Center(
  //                           child: Text(
  //                             'MCQ Test',
  //                             style: TextStyles.fontStyle5,
  //                             textAlign: TextAlign.center,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 20),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title section
                Row(
                  children: [
                    SizedBox(
                      width: width / 2 - 100,
                      child: const Text(
                        'ID :',
                        style: TextStyles.fontStyle13,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${provider.classWorkDetailsData[index].classworkid}' ==
                                'null'
                            ? '-'
                            : '''${provider.classWorkDetailsData[index].classworkid}''',
                        style: TextStyles.theme02fontStyle2,
                      ),
                    ),
                  ],
                ),
                Divider(
                    color: AppColors.theme01primaryColor,
                    thickness: 1,
                    height: 20),

                // Data rows
                _buildRow(
                  'Class work type desc:',
                  '${provider.classWorkDetailsData[index].classworktypedesc}' ==
                          'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].classworktypedesc}''',
                  width,
                ),
                _buildRow(
                  'Dp start date time:',
                  '${provider.classWorkDetailsData[index].dpstartdatetime}' ==
                          'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].dpstartdatetime}''',
                  width,
                ),
                _buildRow(
                  'Dp end date time:',
                  '${provider.classWorkDetailsData[index].dpenddatetime}' ==
                          'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].dpenddatetime}''',
                  width,
                ),
                _buildRow(
                  'Topic desc:',
                  '${provider.classWorkDetailsData[index].topicdesc}' == 'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].topicdesc}''',
                  width,
                ),
                const SizedBox(height: 20),

                // Attachments section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (provider is LibraryTrancsactionStateLoading)
                      const Center(
                        child: Text(
                          'No List Added',
                          style: TextStyles.fontStyle1,
                        ),
                      )
                    else if (provider.lmsAttachmentDetailsData.isEmpty &&
                        provider is! LibraryTrancsactionStateLoading)
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 5),
                          Center(
                              child: CircularProgressIndicators
                                  .primaryColorProgressIndication),
                        ],
                      ),
                    if (provider.lmsAttachmentDetailsData.isNotEmpty)
                      ListView.builder(
                        itemCount: provider.lmsAttachmentDetailsData.length,
                        controller: _listController,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return cardStaffAttachmentDesign(index);
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 10),

                // Buttons section
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    // Attachments button
                    // SizedBox(
                    //   height: 30,
                    //   width: 150,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       ref
                    //           .read(lmsProvider.notifier)
                    //           .getLmsAttachmentDetails(
                    //             ref.read(encryptionProvider.notifier),
                    //             '${provider.classWorkDetailsData[index].classworkid}',
                    //           );
                    //       Navigator.push(
                    //         context,
                    //         RouteDesign(
                    //           route: Theme02LmsAttachmentDetailsDataPage(
                    //             classworkID:
                    //                 '${provider.classWorkDetailsData[index].classworkid}',
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: AppColors.theme02buttonColor2,
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: const Center(
                    //         child: Text(
                    //           'Attachments',
                    //           style: TextStyles.fontStyle5,
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Student Attachments button
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(lmsProvider.notifier)
                              .getLmsStudentAttachmentDetails(
                                ref.read(encryptionProvider.notifier),
                                '${provider.classWorkDetailsData[index].classworkreplyid}',
                              );
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: Theme02LmsStudentAttachmentDetailsDataPage(
                                classworkreplyid:
                                    '${provider.classWorkDetailsData[index].classworkreplyid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme02buttonColor2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Student Attachments',
                              style: TextStyles.fontStyle5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Additional Buttons (e.g., Save Attachment and MCQ Test)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    if (provider.classWorkDetailsData[index].classworkreplyid ==
                        '0')
                      SizedBox(
                        height: 30,
                        width: 150,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              RouteDesign(
                                route: Theme02LmsSaveWorkReplayDetailsDataPage(
                                  classworkID:
                                      '${provider.classWorkDetailsData[index].classworkid}',
                                  classworkreplyid:
                                      '${provider.classWorkDetailsData[index].classworkreplyid}',
                                  fieldrequirements:
                                      '${provider.classWorkDetailsData[index].fieldrequirement}',
                                  imageattachmentid:
                                      '${provider.classWorkDetailsData[index].stuimageattachmentid}',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.theme02buttonColor2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Classwork Attachment',
                                style: TextStyles.fontStyle5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: Theme02McqEnteryPage(
                                mcqscheduleid:
                                    '${provider.classWorkDetailsData[index].mcqscheduleid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme02buttonColor2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'MCQ Test',
                              style: TextStyles.fontStyle5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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

  Widget cardStaffAttachmentDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);

    final base64File = '${provider.lmsAttachmentDetailsData[index].imageBytes}';
    final fileBytes = base64Decode(base64File);

    final actualname =
        provider.lmsAttachmentDetailsData[index].actualname ?? '';
    final fileExtension = actualname.split('.').last.toLowerCase();

    log('File Name: $actualname');
    log('File Extension: $fileExtension');

    Widget fileDisplayWidget;

    if (['png', 'jpg', 'jpeg', 'gif'].contains(fileExtension)) {
      fileDisplayWidget = Image.memory(
        fileBytes,
        fit: BoxFit.cover,
        width: width - 100,
        height: 200,
      );
    } else if (fileExtension == 'pdf') {
      fileDisplayWidget = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Theme02PDFViewPage(
                pdfData: fileBytes,
                fileName: actualname,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              actualname,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.table_chart,
              color: Colors.green,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              actualname,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
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
            child: Column(
              children: [
                const Text(
                  'Staff Attachment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: fileDisplayWidget,
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
            style: TextStyles.fontStyle13,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle13,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle13,
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
