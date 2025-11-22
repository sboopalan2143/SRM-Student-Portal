import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/riverpod/fees_dhasboard_Page_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme007FeesPage extends ConsumerStatefulWidget {
  const Theme007FeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme007FeesPageState();
}

class _Theme007FeesPageState extends ConsumerState<Theme007FeesPage> {
  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feesProvider.notifier).setFeesNavString('Fee Due');
      ref.read(feesProvider.notifier).getFeedDueDetails(ref.read(encryptionProvider.notifier));
      ref.read(feesProvider.notifier).getHiveFinanceDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final provider = ref.watch(feesProvider);
    ref
      ..watch(feesDhasboardProvider)
      ..listen(feesProvider, (previous, next) {});
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'FEE',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(feesProvider.notifier).getFeedDueDetails(ref.read(encryptionProvider.notifier));
              },
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ),
            ),
          ],
          centerTitle: true,
          // Explicitly set actions to an empty list
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 2 - 20,
                        child: feesdhasboardcardDesign(0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                width: width - 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary.withAlpha(200),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: navContainerDesign(
                          text: 'Fee Due',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: navContainerDesign(
                          text: 'Fee Receipt',
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
                    child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                  ),
                ),
              // else if (provider.financeHiveData.isEmpty && provider is! FeesStateLoading)
              //   Column(
              //     children: [
              //       SizedBox(height: MediaQuery.of(context).size.height / 5),
              //       Center(
              //         child: Text(
              //           'No List Added Yet!',
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Theme.of(context).colorScheme.inverseSurface,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // if (provider.financeHiveData.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: provider.navFeesString == 'Fee Due'
                    ? (provider.feesDetailsData.isEmpty && provider is! FeesStateLoading)
                        ? Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height / 5),
                              Center(
                                child: Text(
                                  'No List Added Yet!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ...provider.feesDetailsData.map((data) => data.duedescription).toSet().map((term) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: ExpansionTile(
                                        expansionAnimationStyle: const AnimationStyle(
                                          duration: Duration(milliseconds: 400),
                                          curve: Curves.decelerate,
                                        ),
                                        title: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '$term',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: [
                                          ...provider.feesDetailsData
                                              .where((item) => item.duedescription == term)
                                              .map((filteredData) {
                                            final index = provider.feesDetailsData.indexOf(filteredData);
                                            return cardDesign(index);
                                          }),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          )
                    : (provider.financeHiveData.isEmpty && provider is! FeesStateLoading)
                        ? Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height / 5),
                              Center(
                                child: Text(
                                  'No List Added Yet!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.inverseSurface,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Padding(
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
                                        ...provider.financeHiveData
                                            .map((data) => data.term)
                                            .toSet() // Ensure unique terms
                                            .map((term) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent,
                                            ),
                                            child: ExpansionTile(
                                              expansionAnimationStyle: const AnimationStyle(
                                                duration: Duration(milliseconds: 400),
                                                curve: Curves.decelerate,
                                              ),
                                              title: Text(
                                                '$term', // Use the term value
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).colorScheme.inversePrimary,
                                                ),
                                              ),
                                              children: [
                                                ...provider.financeHiveData
                                                    .where((item) => item.term == term)
                                                    .map((filteredData) {
                                                  final index = provider.financeHiveData.indexOf(filteredData);
                                                  return cardDesignTrans(index);
                                                }),
                                              ],
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(feesProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    child: Text(
                      'Fee Head',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.feesDetailsData[index].duename}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].duename}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Due Date',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.feesDetailsData[index].duedate}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].duedate}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Due Amount',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.feesDetailsData[index].dueamount}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].dueamount}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Amount Collected',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.feesDetailsData[index].amtcollected}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].amtcollected}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Current Due',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.feesDetailsData[index].currentdue}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].currentdue}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
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
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    log('${provider.financeHiveData[index].receiptnum}');
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    child: Text(
                      'Fee Head',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.financeHiveData[index].duename}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].duename}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: Text(
                      'Receipt No',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.financeHiveData[index].receiptnum}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].receiptnum}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     SizedBox(
              //       width: width / 2 - 70,
              //       child: const Text(
              //         'Due Date',
              //         style: TextStyles.fontStyle10,
              //       ),
              //     ),
              //     const Text(
              //       ':',
              //       style: TextStyles.fontStyle10,
              //     ),
              //     const SizedBox(width: 5),
              //     SizedBox(
              //       width: width / 2 - 60,
              //       child: Text(
              //         '${provider.financeHiveData[index].duedate}' == ''
              //             ? '-'
              //             : '${provider.financeHiveData[index].duedate}',
              //         style: TextStyles.fontStyle10,
              //       ),
              //     ),
              //   ],
              // ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: Text(
                      'Receipt Date',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.financeHiveData[index].receiptdate}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].receiptdate}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: Text(
                      'Mode of Payment',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.financeHiveData[index].modeoftransaction}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].modeoftransaction}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: Text(
                      'Amount Paid',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.financeHiveData[index].amountcollected}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].amountcollected}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget feesdhasboardcardDesign(int index) {
    final feescurrendDataProvider = ref.watch(feesDhasboardProvider);
    return Column(
      children: [
        //  const SizedBox(height: 10,),
        Text(
          'Current Due',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inverseSurface,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Text(
                '${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}' == 'null'
                    ? '-'
                    : '''Rs. ${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}''',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            ],
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: text == provider.navFeesString ? Theme.of(context).colorScheme.tertiary : Colors.transparent,
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha(120),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
