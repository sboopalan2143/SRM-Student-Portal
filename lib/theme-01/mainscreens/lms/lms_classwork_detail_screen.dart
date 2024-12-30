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
import 'package:sample/home/main_pages/lms/screens/mcq_entry_page.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_attachment_screen.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_entry_test_screen.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_save_attachment.dart';
import 'package:sample/theme-01/mainscreens/lms/lms_student_attachment_screen.dart';

class Theme01LmsClassworkDetailPage extends ConsumerStatefulWidget {
  const Theme01LmsClassworkDetailPage({
    required this.classworkID,
    super.key,
  });
  final String classworkID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01LmsClassworkDetailPageState();
}

class _Theme01LmsClassworkDetailPageState
    extends ConsumerState<Theme01LmsClassworkDetailPage> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

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
                  ref.listen(lmsProvider, (previous, next) {
                    if (next is LibraryTrancsactionStateError) {
                      _showToast(
                          context, next.errorMessage, AppColors.redColor);
                    } else if (next is LibraryTrancsactionStateSuccessful) {
                      _showToast(
                          context, next.successMessage, AppColors.greenColor);
                    }
                  });
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
                'Class Work Details',
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
                          ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
                                ref.read(encryptionProvider.notifier),
                                widget.classworkID,
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
                      'ID :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.classWorkDetailsData[index].classworkid}' ==
                              'null'
                          ? '-'
                          : '''${provider.classWorkDetailsData[index].classworkid}''',
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
                  'Class Work Type Desc :',
                  '${provider.classWorkDetailsData[index].classworktypedesc}' ==
                          'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].classworktypedesc}''',
                  width,
                ),
                _buildRow(
                  'Dp Start Date Time',
                  '${provider.classWorkDetailsData[index].dpstartdatetime}' ==
                          'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].dpstartdatetime}''',
                  width,
                ),
                _buildRow(
                  'Dp End Date Time',
                  '${provider.classWorkDetailsData[index].dpenddatetime}' ==
                          'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].dpenddatetime}''',
                  width,
                ),
                _buildRow(
                  'Topic Desc',
                  '${provider.classWorkDetailsData[index].topicdesc}' == 'null'
                      ? '-'
                      : '''${provider.classWorkDetailsData[index].topicdesc}''',
                  width,
                ),
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SizedBox(
                //       height: 30,
                //       width: 150,
                //       child: GestureDetector(
                //         onTap: () {
                //           ref
                //               .read(lmsProvider.notifier)
                //               .getLmsAttachmentDetails(
                //                 ref.read(encryptionProvider.notifier),
                //                 '${provider.classWorkDetailsData[index].classworkid}',
                //               );

                //           Navigator.push(
                //             context,
                //             RouteDesign(
                //               route: Theme01LmsAttachmentDetailsDataPage(
                //                 classworkID:
                //                     '${provider.classWorkDetailsData[index].classworkid}',
                //               ),
                //             ),
                //           );
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: AppColors.theme01primaryColor,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: const Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Center(
                //                 child: Text(
                //                   'Attachments',
                //                   style: TextStyles.fontStyle5,
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     SizedBox(
                //       height: 30,
                //       width: 150,
                //       child: GestureDetector(
                //         onTap: () {
                //           // Navigator.push(
                //           //   context,
                //           //   RouteDesign(
                //           //     route: LmsStudentAttachmentDetailsDataPage(
                //           //       classworkID:
                //           //           '${provider.classWorkDetailsData[index].classworkid}',
                //           //     ),
                //           //   ),
                //           // );
                //           ref
                //               .read(lmsProvider.notifier)
                //               .getLmsStudentAttachmentDetails(
                //                 ref.read(encryptionProvider.notifier),
                //                 '${provider.classWorkDetailsData[index].classworkreplyid}',
                //               );
                //           Navigator.push(
                //             context,
                //             RouteDesign(
                //               route: Theme01LmsStudentAttachmentDetailsDataPage(
                //                 classworkreplyid:
                //                     '${provider.classWorkDetailsData[index].classworkreplyid}',
                //               ),
                //             ),
                //           );
                //         },
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: AppColors.theme01primaryColor,
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //           child: const Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Center(
                //                 child: Text(
                //                   'Student Attachments',
                //                   style: TextStyles.fontStyle5,
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                Wrap(
                  spacing: 10, // Horizontal spacing between buttons
                  runSpacing:
                      10, // Vertical spacing when wrapping to the next line
                  alignment: WrapAlignment.center, // Center the buttons
                  children: [
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(lmsProvider.notifier)
                              .getLmsAttachmentDetails(
                                ref.read(encryptionProvider.notifier),
                                '${provider.classWorkDetailsData[index].classworkid}',
                              );

                          Navigator.push(
                            context,
                            RouteDesign(
                              route: Theme01LmsAttachmentDetailsDataPage(
                                classworkID:
                                    '${provider.classWorkDetailsData[index].classworkid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme01primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              'Attachments',
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
                          ref
                              .read(lmsProvider.notifier)
                              .getLmsStudentAttachmentDetails(
                                ref.read(encryptionProvider.notifier),
                                '${provider.classWorkDetailsData[index].classworkreplyid}',
                              );

                          Navigator.push(
                            context,
                            RouteDesign(
                              route: Theme01LmsStudentAttachmentDetailsDataPage(
                                classworkreplyid:
                                    '${provider.classWorkDetailsData[index].classworkreplyid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme01primaryColor,
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

                const SizedBox(
                  height: 10,
                ),
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
                                route: Theme01LmsSaveWorkReplayDetailsDataPage(
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
                              color: AppColors.theme01primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Save Attachment',
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
                              route: Theme01McqEnteryPage(
                                mcqscheduleid:
                                    '${provider.classWorkDetailsData[index].mcqscheduleid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.theme01primaryColor,
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
