// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme-02/mainscreens/transport/transport_button_design.dart';

class Theme02TransportTransactionPage extends ConsumerStatefulWidget {
  const Theme02TransportTransactionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02TransportTransactionPageState();
}

class _Theme02TransportTransactionPageState
    extends ConsumerState<Theme02TransportTransactionPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  // static int refreshNum = 10;
  // Stream<int> counterStream =
  //     Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(transportProvider.notifier).getTransportStatusDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref
            .read(transportProvider.notifier)
            .getTransportStatusHiveDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(transportProvider.notifier).getTransportStatusDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref
          .read(transportProvider.notifier)
          .getTransportStatusHiveDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transportProvider);
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
            'TRANSPORT',
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
                      await ref
                          .read(transportProvider.notifier)
                          .getTransportStatusDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref
                          .read(transportProvider.notifier)
                          .getTransportStatusHiveDetails('');
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
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TransportButtonDesign.buttonDesign(
                        'Register',
                        AppColors.primaryColor,
                        context,
                        ref.read(mainProvider.notifier),
                        ref,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (provider is TransportStateLoading)
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: CircularProgressIndicators
                              .primaryColorProgressIndication,
                        ),
                      )
                    else if (provider.transportStatusData.isEmpty &&
                        provider is! TransportStateLoading)
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                          const Center(
                            child: Text(
                              'No List Added Yet!',
                              style: TextStyles.fontStyle1,
                            ),
                          ),
                        ],
                      ),
                    if (provider.transportStatusData.isNotEmpty)
                      const SizedBox(height: 5),
                    ListView.builder(
                      itemCount: provider.transportStatusData.length,
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(transportProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Material(
        elevation: 8,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.3),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.theme02primaryColor,
                AppColors.theme02secondaryColor1,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance,
                      color: AppColors.theme02buttonColor2,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Office ID : ',
                      style: TextStyles.fontStyletheme2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      provider.transportStatusData[index].officeid!.isEmpty
                          ? '-'
                          : '${provider.transportStatusData[index].officeid}',
                      style: TextStyles.theme02fontStyle2,
                    ),
                  ],
                ),
                Divider(thickness: 1, color: AppColors.theme01primaryColor),
                _buildRowWithIcon(
                  icon: Icons.calendar_today,
                  label: 'Academic Year ID:',
                  value:
                      '${provider.transportStatusData[index].academicyearid}',
                  width: width,
                ),
                _buildRowWithIcon(
                  icon: Icons.money,
                  label: 'Application Fee:',
                  value:
                      '${provider.transportStatusData[index].applicationfee}',
                  width: width,
                ),
                _buildRowWithIcon(
                  icon: Icons.settings,
                  label: 'Reg Config:',
                  value: '${provider.transportStatusData[index].regconfig}',
                  width: width,
                ),
                _buildRowWithIcon(
                  icon: Icons.directions_bus,
                  label: 'Transport Status:',
                  value:
                      '${provider.transportStatusData[index].transportstatus}',
                  width: width,
                ),
                _buildRowWithIcon(
                  icon: Icons.info,
                  label: 'Status:',
                  value: '${provider.transportStatusData[index].status}',
                  width: width,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRowWithIcon({
    required IconData icon,
    required String label,
    required String value,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: AppColors.theme02buttonColor2, size: 20),
          const SizedBox(width: 10),
          SizedBox(
            width: width / 2 - 100,
            child: Text(
              label,
              style: TextStyles.fontStyle13.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: TextStyles.fontStyle13,
            ),
          ),
        ],
      ),
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;

  //   final provider = ref.watch(transportProvider);

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
  //     child: Material(
  //       elevation: 5,
  //       shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
  //       borderRadius: BorderRadius.circular(20),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               AppColors.theme01secondaryColor1,
  //               AppColors.theme01secondaryColor2,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: ExpansionTile(
  //             title: Row(
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 100,
  //                   child: Text(
  //                     'Office id :',
  //                     style: TextStyles.buttonStyle01theme2,
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     '${provider.transportStatusData[index].officeid}' == ''
  //                         ? '-'
  //                         : ''
  //                             '${provider.transportStatusData[index].officeid}'
  //                             '',
  //                     style: TextStyles.fontStyle2,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             collapsedIconColor: AppColors.theme01primaryColor,
  //             iconColor: AppColors.theme01primaryColor,
  //             children: [
  //               Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
  //               _buildRow(
  //                 'Academic year id :',
  //                 '${provider.transportStatusData[index].academicyearid}' == ''
  //                     ? '-'
  //                     : ''
  //                         '${provider.transportStatusData[index].academicyearid}'
  //                         '',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Application fee',
  //                 '${provider.transportStatusData[index].applicationfee}' == ''
  //                     ? '-'
  //                     : ''
  //                         '${provider.transportStatusData[index].applicationfee}'
  //                         '',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Regcon fig',
  //                 '${provider.transportStatusData[index].regconfig}' == ''
  //                     ? '-'
  //                     : ''
  //                         '${provider.transportStatusData[index].regconfig}'
  //                         '',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Transport status :',
  //                 '${provider.transportStatusData[index].transportstatus}' == ''
  //                     ? '-'
  //                     : ''
  //                         '${provider.transportStatusData[index].transportstatus}'
  //                         '',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Status',
  //                 '${provider.transportStatusData[index].status}' == ''
  //                     ? '-'
  //                     : ''
  //                         '${provider.transportStatusData[index].status}'
  //                         '',
  //                 width,
  //               ),
  //               const SizedBox(height: 10),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
}
