import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/theme_3/fees/fees_home_theme3.dart';

class FeesPageTheme3 extends ConsumerStatefulWidget {
  const FeesPageTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeesPageTheme3State();
}

class _FeesPageTheme3State extends ConsumerState<FeesPageTheme3> {
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
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColorTheme3,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: const Icon(
                  Icons.menu,
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
                          await ref
                              .read(feesProvider.notifier)
                              .getFeesDetailsApi(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(feesProvider.notifier)
                              .getHiveFeesDetails('');
                          await ref
                              .read(feesProvider.notifier)
                              .getFinanceDetailsApi(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(feesProvider.notifier)
                              .getHiveFinanceDetails('');
                          await Navigator.push(
                            context,
                            RouteDesign(
                              route: const FeesHomeTheme3(),
                            ),
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
        color: AppColors.primaryColorTheme3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: width - 40,
                  decoration: BoxDecoration(
                    color: AppColors.grey4,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: AppColors.grey4,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
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
                          'No List Added Yet!',
                          style: TextStyles.fontStyle6,
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
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.money,
                color: AppColors.primaryColorTheme3,
                size: 25,
              ),
              const SizedBox(width: 5),
              SizedBox(
                // width: width / 2.5 + 25,
                child: Text(
                  '${provider.feesDetailsHiveData[index].duename}' == ''
                      ? '-'
                      : '${provider.feesDetailsHiveData[index].duename}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                child: Text(
                  '${provider.feesDetailsHiveData[index].duedescription}' == ''
                      ? '-'
                      : '${provider.feesDetailsHiveData[index].duedescription}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColorTheme3,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 15),
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.money,
                    color: AppColors.whiteColor,
                    size: 25,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    '${provider.feesDetailsHiveData[index].dueamount}' == ''
                        ? '-'
                        : '${provider.feesDetailsHiveData[index].dueamount}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DUE DATE',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '${provider.feesDetailsHiveData[index].duedate}' == ''
                        ? ' -'
                        : ' ${provider.feesDetailsHiveData[index].duedate}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'COLLECTED',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '${provider.feesDetailsHiveData[index].amtcollected}' == ''
                        ? '-'
                        : '${provider.feesDetailsHiveData[index].amtcollected}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.greenColorTheme3,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DUE',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '${provider.feesDetailsHiveData[index].currentdue}' == ''
                        ? '-'
                        : '${provider.feesDetailsHiveData[index].currentdue}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(color: AppColors.grey4, height: 1),
        ],
      ),
    );
  }

  Widget cardDesignTrans(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.money,
                    color: AppColors.primaryColorTheme3,
                    size: 25,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 3 + 25,
                    child: Text(
                      '${provider.financeHiveData[index].duename}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].duename}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: width / 4,
                child: Text(
                  '${provider.financeHiveData[index].dueamount}' == ''
                      ? '-'
                      : '${provider.financeHiveData[index].dueamount}',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryColorTheme3,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.money,
                    color: AppColors.whiteColor,
                    size: 25,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${provider.financeHiveData[index].receiptnum}' == ''
                        ? '-'
                        : '${provider.financeHiveData[index].receiptnum}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Text(
                '${provider.financeHiveData[index].receiptdate}' == ''
                    ? ' -'
                    : ' ${provider.financeHiveData[index].receiptdate}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.grey4,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.money,
                    color: AppColors.whiteColor,
                    size: 25,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'DUE',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${provider.financeHiveData[index].duedate}' == ''
                        ? '-'
                        : '${provider.financeHiveData[index].duedate}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.redColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Text(
                '${provider.financeHiveData[index].term}' == ''
                    ? ' -'
                    : ' ${provider.financeHiveData[index].term}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.grey1,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'COLLECTED',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '${provider.financeHiveData[index].amountcollected}' == ''
                        ? '-'
                        : '${provider.financeHiveData[index].amountcollected}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.greenColorTheme3,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MODE',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '${provider.financeHiveData[index].modeoftransaction}' == ''
                        ? '-'
                        : '${provider.financeHiveData[index].modeoftransaction}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(color: AppColors.grey1, height: 1),
        ],
      ),
    );
  }

  Widget navContainerDesign({
    required String text,
  }) {
    final provider = ref.watch(feesProvider);
    return SizedBox(
      height: 45,
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
              ? AppColors.primaryColorTheme3
              : AppColors.grey4,
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
                  style: TextStyles.fontStyle3,
                ),
              ),
      ),
    );
  }
}
