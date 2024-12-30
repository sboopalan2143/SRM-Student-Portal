import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-02/mainscreens/hostel/theme_02_hostel_button_style.dart';

class Theme06HostelPage extends ConsumerStatefulWidget {
  const Theme06HostelPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06HostelPageState();
}

class _Theme06HostelPageState extends ConsumerState<Theme06HostelPage> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  // static int refreshNum = 10;
  // Stream<int> counterStream =
  //     Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(hostelProvider.notifier).getHostelDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(hostelProvider.notifier).getHostelHiveDetails(
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
      ref.read(hostelProvider.notifier).getHostelHiveDetails(
            '',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is HostelStateSuccessful) {
      //   /// Handle route to next page.

      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
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
                  AppColors.theme06primaryColor,
                  AppColors.theme06primaryColor,
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
            'HOSTEL',
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
                    onTap: () async {
                      await ref.read(hostelProvider.notifier).getHostelDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref
                          .read(hostelProvider.notifier)
                          .getHostelHiveDetails(
                            '',
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Theme02ButtonDesign.buttonDesign(
                          'Leave Application',
                          AppColors.primaryColor,
                          context,
                          ref,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Theme02ButtonDesign.buttonDesign(
                          'Registration',
                          AppColors.primaryColor,
                          context,
                          ref,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (provider is HostelStateLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: CircularProgressIndicators
                            .primaryColorProgressIndication,
                      ),
                    )
                  else if (provider.gethostelData.isEmpty &&
                      provider is! HostelStateLoading)
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                        const Center(
                          child: Text(
                            'No List Added Yet!',
                            style: TextStyles.fontStyle6,
                          ),
                        ),
                      ],
                    ),
                  if (provider.gethostelData.isNotEmpty)
                    ListView.builder(
                      itemCount: provider.gethostelData.length,
                      controller: _listController,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return cardDesign(index);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(hostelProvider);

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
                AppColors.theme06primaryColor,
                AppColors.theme06primaryColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
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
                      'Academic year :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.gethostelData[index].academicyear}' == ''
                          ? '-'
                          : '''${provider.gethostelData[index].academicyear}''',
                      style: TextStyles.fontStyle2,
                    ),
                  ),
                ],
              ),
              collapsedIconColor: AppColors.whiteColor,
              iconColor: AppColors.whiteColor,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Alloted date :',
                  '${provider.gethostelData[index].alloteddate}' == ''
                      ? '-'
                      : '''${provider.gethostelData[index].alloteddate}''',
                  width,
                ),
                _buildRow(
                  'Hostel name',
                  '${provider.gethostelData[index].hostelname}' == ''
                      ? '-'
                      : '''${provider.gethostelData[index].hostelname}''',
                  width,
                ),
                _buildRow(
                  'Room name',
                  '${provider.gethostelData[index].roomname}' == ''
                      ? '-'
                      : '${provider.gethostelData[index].roomname}',
                  width,
                ),
                _buildRow(
                  'Room type :',
                  '${provider.gethostelData[index].roomtype}' == ''
                      ? '-'
                      : '${provider.gethostelData[index].roomtype}',
                  width,
                ),
                const SizedBox(height: 10),
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
