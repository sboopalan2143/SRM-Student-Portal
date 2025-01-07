import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01FeesPage extends ConsumerStatefulWidget {
  const Theme01FeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01FeesPageState();
}

class _Theme01FeesPageState extends ConsumerState<Theme01FeesPage> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(feesProvider.notifier)
            .getFeedDueDetails(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getFeedDueDetails(ref.read(encryptionProvider.notifier));
        await ref
            .read(feesProvider.notifier)
            .getFinanceDetailsApi(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getHiveFinanceDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(feesProvider.notifier)
            .getFeedDueDetails(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getFeedDueDetails(ref.read(encryptionProvider.notifier));
        await ref
            .read(feesProvider.notifier)
            .getFinanceDetailsApi(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getHiveFinanceDetails('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);
    ref.listen(feesProvider, (previous, next) {
      // if (next is FeesError) {
      //   _showToast(context, next.errorMessage, AppColors.redColor);
      // }
      // else if (next is FeesStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
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
                'FEES',
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
                              .read(feesProvider.notifier)
                              .getFeedDueDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(feesProvider.notifier)
                              .getFeedDueDetails(ref.read(encryptionProvider.notifier));
                          await ref
                              .read(feesProvider.notifier)
                              .getFinanceDetailsApi(
                                ref.read(
                                  encryptionProvider.notifier,
                                ),
                              );
                          await ref
                              .read(feesProvider.notifier)
                              .getHiveFinanceDetails('');
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: width - 40,
                  decoration: BoxDecoration(
                    color: AppColors.theme01secondaryColor4,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: AppColors.theme01secondaryColor4,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: navContainerDesign(
                            text: 'Paid Details',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: navContainerDesign(
                            text: 'Online Trans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                //       const Text(
                //         '2023 - 2024    Total: Rs. 15,000.00',
                //         textAlign: TextAlign.center,
                //         style: TextStyles.fontStyle7,
                //       ),
                //     ],
                //   ),
                // ),
                if (provider is FeesStateLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircularProgressIndicators
                          .theme01primaryColorProgressIndication,
                    ),
                  )
                else if (provider.financeHiveData.isEmpty &&
                    provider is! FeesStateLoading)
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      const Center(
                        child: Text(
                          'No List Added ',
                          style: TextStyles.fontStyle1,
                        ),
                      ),
                    ],
                  ),
                if (provider.financeHiveData.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: ListView.builder(
                      itemCount: provider.navFeesString == 'Paid Details'
                          ? provider.feesDetailsData.length
                          : provider.financeHiveData.length,
                      controller: _listController,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return provider.navFeesString == 'Paid Details'
                            ? cardDesign(index)
                            : cardDesignTrans(index);
                      },
                    ),
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
    final provider = ref.watch(feesProvider);

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
                      'Due Name :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.feesDetailsData[index].duename}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].duename}',
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
                  'Amt Collected :',
                  '${provider.feesDetailsData[index].amtcollected}' == ''
                      ? '-'
                      : '${provider.feesDetailsData[index].amtcollected}',
                  width,
                ),
                _buildRow(
                  'Current Due',
                  '${provider.feesDetailsData[index].currentdue}' == ''
                      ? '-'
                      : '${provider.feesDetailsData[index].currentdue}',
                  width,
                ),
                _buildRow(
                  'Due Amount',
                  '${provider.feesDetailsData[index].dueamount}' == ''
                      ? '-'
                      : '${provider.feesDetailsData[index].dueamount}',
                  width,
                ),
                _buildRow(
                  'Due Date :',
                  '${provider.feesDetailsData[index].duedate}' == ''
                      ? '-'
                      : '${provider.feesDetailsData[index].duedate}',
                  width,
                ),
                _buildRow(
                  'Due Description',
                  '${provider.feesDetailsData[index].duedescription}' == ''
                      ? '-'
                      : '${provider.feesDetailsData[index].duedescription}',
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

  Widget cardDesignTrans(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);

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
                      'Rec no :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.financeHiveData[index].receiptnum}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].receiptnum}',
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
                  'Due Date :',
                  '${provider.financeHiveData[index].duedate}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].duedate}',
                  width,
                ),
                _buildRow(
                  'Mode Of Transaction',
                  '${provider.financeHiveData[index].modeoftransaction}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].modeoftransaction}',
                  width,
                ),
                _buildRow(
                  'Due Amount',
                  '${provider.financeHiveData[index].dueamount}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].dueamount}',
                  width,
                ),
                _buildRow(
                  'Term :',
                  '${provider.financeHiveData[index].term}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].term}',
                  width,
                ),
                _buildRow(
                  'Amount Collected',
                  '${provider.financeHiveData[index].amountcollected}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].amountcollected}',
                  width,
                ),
                _buildRow(
                  'Receipt Date',
                  '${provider.financeHiveData[index].receiptdate}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].receiptdate}',
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

  Widget navContainerDesign({
    required String text,
  }) {
    final provider = ref.watch(feesProvider);
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // side: BorderSide(
          //   color: AppColors.whiteColor,
          // ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: text == provider.navFeesString
              ? AppColors.theme01primaryColor
              : AppColors.theme01secondaryColor4,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          ref.read(feesProvider.notifier).setFeesNavString(text);
        },
        child: text == provider.navFeesString
            ? FittedBox(
                child: Text(
                  text,
                  style: TextStyles.fontStyle3,
                ),
              )
            : FittedBox(
                child: Text(
                  text,
                  style: TextStyles.smallerLightAshColorFontStyle,
                ),
              ),
      ),
    );
  }
}
