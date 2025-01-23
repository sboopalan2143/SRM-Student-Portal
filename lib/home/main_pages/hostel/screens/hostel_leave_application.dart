import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/hostel/screens/hostel.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class LeaveApplicationPage extends ConsumerStatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends ConsumerState<LeaveApplicationPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(hostelProvider.notifier).getHostelLeaveStatus(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(hostelProvider.notifier).getHostelLeaveStatusHive(
              '',
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
      ref.read(hostelProvider.notifier).getHostelLeaveStatusHive(
            '',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    final providerRead = ref.read(hostelProvider.notifier);

    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      //  else if (next is HostelStateSuccessful) {
      //   /// Handle route to next page.

      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
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
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const HostelPage(),
                    ),
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
                'LEAVE APPLICATION',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              // actions: [
              //   Row(
              //     children: [
              //       IconButton(
              //         onPressed: () {
              //
              //         },
              //         icon: const Icon(
              //           Icons.menu,
              //           size: 35,
              //           color: AppColors.whiteColor,
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ref
                              .read(hostelProvider.notifier)
                              .getHostelLeaveStatus(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(hostelProvider.notifier)
                              .getHostelLeaveStatusHive(
                                '',
                              );
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.menu,
                          size: 35,
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
        child: provider is HostelStateLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child:
                      CircularProgressIndicators.primaryColorProgressIndication,
                ),
              )
            : provider.hostelLeaveData.isEmpty &&
                    provider is! HostelStateLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'FromDate',
                                    style: TextStyles.fontStyle2,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        color: AppColors.grey2,
                                      ),
                                    ),
                                    height: 40,
                                    child: TextField(
                                      onChanged: (value) =>
                                          providerRead.setValue(),
                                      onTap: () async {
                                        final pickedDate = await showDatePicker(
                                          context: context,

                                          // initialDate: DateTime(2005, 9, 14),
                                          firstDate: DateTime(1923),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          setState(() {
                                            provider.fromDate.text =
                                                DateFormat('MM-dd-yyyy')
                                                    .format(pickedDate);
                                          });
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      style: TextStyles.fontStyle2,
                                      controller: provider.fromDate,
                                      decoration: InputDecoration(
                                        hintText: 'Select FromDate',
                                        hintStyle: TextStyles
                                            .smallLightAshColorFontStyle,
                                        filled: true,
                                        fillColor: AppColors.whiteColor,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        enabledBorder:
                                            BorderBoxButtonDecorations
                                                .loginTextFieldStyle,
                                        focusedBorder:
                                            BorderBoxButtonDecorations
                                                .loginTextFieldStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'ToDate',
                                    style: TextStyles.fontStyle2,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(7),
                                      border: Border.all(
                                        color: AppColors.grey2,
                                      ),
                                    ),
                                    height: 40,
                                    child: TextField(
                                      onChanged: (value) =>
                                          providerRead.setValue(),
                                      onTap: () async {
                                        final pickedDate = await showDatePicker(
                                          context: context,

                                          // initialDate: DateTime(2005, 9, 14),
                                          firstDate: DateTime(1923),
                                          lastDate: DateTime.now(),
                                        );
                                        if (pickedDate != null) {
                                          setState(() {
                                            provider.toDate.text =
                                                DateFormat('MM-dd-yyyy')
                                                    .format(pickedDate);
                                          });
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      style: TextStyles.fontStyle2,
                                      controller: provider.toDate,
                                      decoration: InputDecoration(
                                        hintText: 'Select ToDate',
                                        hintStyle: TextStyles
                                            .smallLightAshColorFontStyle,
                                        filled: true,
                                        fillColor: AppColors.whiteColor,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        enabledBorder:
                                            BorderBoxButtonDecorations
                                                .loginTextFieldStyle,
                                        focusedBorder:
                                            BorderBoxButtonDecorations
                                                .loginTextFieldStyle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Reason for Leave',
                              style: TextStyles.fontStyle2,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              child: TextField(
                                controller: provider.leaveReason,
                                maxLines: 4,
                                keyboardType: TextInputType.number,
                                style: TextStyles.fontStyle2,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.whiteColor,
                                  contentPadding: const EdgeInsets.all(10),
                                  enabledBorder: BorderBoxButtonDecorations
                                      .loginTextFieldStyle,
                                  focusedBorder: BorderBoxButtonDecorations
                                      .loginTextFieldStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonDesign.buttonDesign(
                                'Submit',
                                AppColors.primaryColor,
                                context,
                                ref,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: provider.hostelLeaveData.length,
                    controller: _listController,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return cardDesign(index);
                    },
                  ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(hostelProvider);
    return Padding(
      padding: const EdgeInsets.all(20),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: const Text(
                      'Reason',
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
                      '''${provider.hostelLeaveData[index].reason}''' == ''
                          ? '-'
                          : '''${provider.hostelLeaveData[index].reason}''',
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
                      'Leave From date',
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
                      '''${provider.hostelLeaveData[index].leavefromdate}''' ==
                              ''
                          ? '-'
                          : '''${provider.hostelLeaveData[index].leavefromdate}''',
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
                      'Leave To Date',
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
                      '''${provider.hostelLeaveData[index].leavetodate}''' == ''
                          ? '-'
                          : '''${provider.hostelLeaveData[index].leavetodate}''',
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
                      'Status',
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
                      '''${provider.hostelLeaveData[index].status}''' == ''
                          ? '-'
                          : '''${provider.hostelLeaveData[index].status}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
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
