import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class FeesPage extends ConsumerStatefulWidget {
  const FeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeesPageState();
}

class _FeesPageState extends ConsumerState<FeesPage> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feesProvider.notifier).getHiveFeesDetails('');

      ref.read(feesProvider.notifier).getHiveFinanceDetails('');
    });
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
                      route: const HomePage2(),
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 45,
                  width: width - 40,
                  decoration: BoxDecoration(
                    color: AppColors.grey1,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: AppColors.grey1,
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(feesProvider);
    return Padding(
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: const Text(
                      'Due name',
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
                      '${provider.feesDetailsHiveData[index].duename}' == ''
                          ? '-'
                          : '${provider.feesDetailsHiveData[index].duename}',
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
                      'Amt collected',
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
                      '${provider.feesDetailsHiveData[index].amtcollected}' ==
                              ''
                          ? '-'
                          : '${provider.feesDetailsHiveData[index].amtcollected}',
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
                      'Current due',
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
                      '${provider.feesDetailsHiveData[index].currentdue}' == ''
                          ? '-'
                          : '${provider.feesDetailsHiveData[index].currentdue}',
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
                      'Due amount',
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
                      '${provider.feesDetailsHiveData[index].dueamount}' == ''
                          ? '-'
                          : '${provider.feesDetailsHiveData[index].dueamount}',
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
                      'Due date',
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
                      '${provider.feesDetailsHiveData[index].duedate}' == ''
                          ? '-'
                          : '${provider.feesDetailsHiveData[index].duedate}',
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
                      'Due description',
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
                      '${provider.feesDetailsHiveData[index].duedescription}' ==
                              ''
                          ? '-'
                          : '${provider.feesDetailsHiveData[index].duedescription}',
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

  Widget cardDesignTrans(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);
    return Padding(
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Receipt No',
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
                      '${provider.financeHiveData[index].receiptnum}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].receiptnum}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Due Date',
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
                      '${provider.financeHiveData[index].duedate}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].duedate}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Mode of Transaction',
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
                      '${provider.financeHiveData[index].modeoftransaction}' ==
                              ''
                          ? '-'
                          : '${provider.financeHiveData[index].modeoftransaction}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Due Amount',
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
                      '${provider.financeHiveData[index].dueamount}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].dueamount}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Term',
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
                      '${provider.financeHiveData[index].term}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].term}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Amount Collected',
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
                      '${provider.financeHiveData[index].amountcollected}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].amountcollected}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Received Date',
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
                      '${provider.financeHiveData[index].receiptdate}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].receiptdate}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
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
              ? AppColors.primaryColor
              : AppColors.grey1,
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
