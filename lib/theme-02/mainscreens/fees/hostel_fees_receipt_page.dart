import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class Theme02FeesReceiptPage extends ConsumerStatefulWidget {
  const Theme02FeesReceiptPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02FeesReceiptPageState();
}

class _Theme02FeesReceiptPageState
    extends ConsumerState<Theme02FeesReceiptPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(feesProvider.notifier)
            .getFinanceDetailsApi(ref.read(encryptionProvider.notifier));
        await ref
            .read(feesProvider.notifier)
            .getFeedDueDetails(ref.read(encryptionProvider.notifier));
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(feesProvider.notifier)
          .getFeedDueDetails(ref.read(encryptionProvider.notifier));

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
      backgroundColor: AppColors.secondaryColor,
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
            'Fee Receipt',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    // Get unique terms from the data
                    ...provider.financeHiveData
                        .map((data) => data.term)
                        .toSet() // Ensure unique terms
                        .map((term) {
                      return ExpansionTile(
                        title: Text(
                          '$term', // Use the term value
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme06primaryColor,
                          ),
                        ),
                        initiallyExpanded: false,
                        // Start collapsed by default
                        backgroundColor: AppColors.grey3,
                        iconColor: AppColors.whiteColor,
                        textColor: AppColors.whiteColor,
                        children: [
                          // Filter data by the unique term and map to cardDesignTrans
                          ...provider.financeHiveData
                              .where((item) => item.term == term)
                              .map((filteredData) {
                            final index =
                                provider.financeHiveData.indexOf(filteredData);
                            return cardDesignTrans(index);
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //
  //   final provider = ref.watch(feesProvider);
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: const BorderRadius.all(Radius.circular(20)),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: const Offset(0, 3),
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           children: [
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Due name',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.feesDetailsData[index].duename}' == ''
  //                         ? '-'
  //                         : '${provider.feesDetailsData[index].duename}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Amt collected',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.feesDetailsData[index].amtcollected}' == ''
  //                         ? '-'
  //                         : '${provider.feesDetailsData[index].amtcollected}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Current due',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.feesDetailsData[index].currentdue}' == ''
  //                         ? '-'
  //                         : '${provider.feesDetailsData[index].currentdue}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Due amount',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.feesDetailsData[index].dueamount}' == ''
  //                         ? '-'
  //                         : '${provider.feesDetailsData[index].dueamount}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Due date',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.feesDetailsData[index].duedate}' == ''
  //                         ? '-'
  //                         : '${provider.feesDetailsData[index].duedate}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Due description',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.feesDetailsData[index].duedescription}' == ''
  //                         ? '-'
  //                         : '${provider.feesDetailsData[index].duedescription}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget cardDesignTrans(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);
    log('${provider.financeHiveData[index].receiptnum}');
    return Padding(
      padding: const EdgeInsets.all(8),
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
                      'Receipt Date',
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
