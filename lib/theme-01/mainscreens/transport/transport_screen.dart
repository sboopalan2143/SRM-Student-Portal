// ignore_for_file: lines_longer_than_80_chars

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/main_pages/transport/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01TransportTransactionPage extends ConsumerStatefulWidget {
  const Theme01TransportTransactionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01TransportTransactionPageState();
}

class _Theme01TransportTransactionPageState
    extends ConsumerState<Theme01TransportTransactionPage> {
  final ScrollController _listController = ScrollController();

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transportProvider.notifier).getTransportStatusHiveDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transportProvider);
    return Scaffold(
      backgroundColor: AppColors.theme01primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'TRANSPORT',
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
        color: AppColors.primaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: ButtonDesign.buttonDesign(
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
                            .theme01primaryColorProgressIndication,
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
                            'No List Added',
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(transportProvider);

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
                      'Office id :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.transportStatusData[index].officeid}' == ''
                          ? '-'
                          : ''
                              '${provider.transportStatusData[index].officeid}'
                              '',
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
                  'Academic year id :',
                  '${provider.transportStatusData[index].academicyearid}' == ''
                      ? '-'
                      : ''
                          '${provider.transportStatusData[index].academicyearid}'
                          '',
                  width,
                ),
                _buildRow(
                  'Application fee',
                  '${provider.transportStatusData[index].applicationfee}' == ''
                      ? '-'
                      : ''
                          '${provider.transportStatusData[index].applicationfee}'
                          '',
                  width,
                ),
                _buildRow(
                  'Regcon fig',
                  '${provider.transportStatusData[index].regconfig}' == ''
                      ? '-'
                      : ''
                          '${provider.transportStatusData[index].regconfig}'
                          '',
                  width,
                ),
                _buildRow(
                  'Transport status :',
                  '${provider.transportStatusData[index].transportstatus}' == ''
                      ? '-'
                      : ''
                          '${provider.transportStatusData[index].transportstatus}'
                          '',
                  width,
                ),
                _buildRow(
                  'Status',
                  '${provider.transportStatusData[index].status}' == ''
                      ? '-'
                      : ''
                          '${provider.transportStatusData[index].status}'
                          '',
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
}
