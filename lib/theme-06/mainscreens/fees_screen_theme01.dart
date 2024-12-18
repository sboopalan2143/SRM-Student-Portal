import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme06FeesPage extends ConsumerStatefulWidget {
  const Theme06FeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06FeesPageState();
}

class _Theme06FeesPageState extends ConsumerState<Theme06FeesPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
            .getFeesDetailsApi(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getHiveFeesDetails('');
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
            .getFeesDetailsApi(ref.read(encryptionProvider.notifier));
        await ref.read(feesProvider.notifier).getHiveFeesDetails('');
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
      key: scaffoldKey,
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
            'FEES',
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
                      await ref.read(feesProvider.notifier).getFeesDetailsApi(
                          ref.read(encryptionProvider.notifier));
                      await ref
                          .read(feesProvider.notifier)
                          .getHiveFeesDetails('');
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
                    color: AppColors.whiteColor,
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
                          .primaryColorProgressIndication,
                    ),
                  )
                else if (provider.financeHiveData.isEmpty &&
                    provider is! FeesStateLoading)
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      const Center(
                        child: Text(
                          'No List Added',
                          style: TextStyles.fontStyle,
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
                          ? provider.feesDetailsHiveData.length
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
                    child: const Text(
                      'Due name :',
                      style: TextStyles.fontStyle13,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.feesDetailsHiveData[index].duename}' == ''
                          ? '-'
                          : '${provider.feesDetailsHiveData[index].duename}',
                      style: TextStyles.fontStyle13,
                    ),
                  ),
                ],
              ),
              collapsedIconColor: AppColors.theme02buttonColor2,
              iconColor: AppColors.theme02buttonColor2,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Amt collected :',
                  '${provider.feesDetailsHiveData[index].amtcollected}' == ''
                      ? '-'
                      : '${provider.feesDetailsHiveData[index].amtcollected}',
                  width,
                ),
                _buildRow(
                  'Current due',
                  '${provider.feesDetailsHiveData[index].currentdue}' == ''
                      ? '-'
                      : '${provider.feesDetailsHiveData[index].currentdue}',
                  width,
                ),
                _buildRow(
                  'Due amount',
                  '${provider.feesDetailsHiveData[index].dueamount}' == ''
                      ? '-'
                      : '${provider.feesDetailsHiveData[index].dueamount}',
                  width,
                ),
                _buildRow(
                  'Due date :',
                  '${provider.feesDetailsHiveData[index].duedate}' == ''
                      ? '-'
                      : '${provider.feesDetailsHiveData[index].duedate}',
                  width,
                ),
                _buildRow(
                  'Due description',
                  '${provider.feesDetailsHiveData[index].duedescription}' == ''
                      ? '-'
                      : '${provider.feesDetailsHiveData[index].duedescription}',
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
                    child: const Text(
                      'Receipt no :',
                      style: TextStyles.fontStyle13,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.financeHiveData[index].receiptnum}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].receiptnum}',
                      style: TextStyles.fontStyle13,
                    ),
                  ),
                ],
              ),
              collapsedIconColor: AppColors.theme02buttonColor2,
              iconColor: AppColors.theme02buttonColor2,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Due date :',
                  '${provider.financeHiveData[index].duedate}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].duedate}',
                  width,
                ),
                _buildRow(
                  'Mode of transaction',
                  '${provider.financeHiveData[index].modeoftransaction}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].modeoftransaction}',
                  width,
                ),
                _buildRow(
                  'Due amount',
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
                  'Amount collected',
                  '${provider.financeHiveData[index].amountcollected}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].amountcollected}',
                  width,
                ),
                _buildRow(
                  'Receipt date',
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
              ? AppColors.theme02secondaryColor1
              : AppColors.whiteColor,
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
