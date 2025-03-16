import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/main_pages/fees_due_home_page.dart/riverpod/fees_dhasboard_Page_state.dart';

class Theme007FeesPage extends ConsumerStatefulWidget {
  const Theme007FeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme007FeesPageState();
}

class _Theme007FeesPageState extends ConsumerState<Theme007FeesPage> {

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(feesProvider.notifier).setFeesNavString('Fee Due');
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
    ref..watch(feesDhasboardProvider)

    ..listen(feesProvider, (previous, next) {
  
    });
    return Scaffold(
      backgroundColor: AppColors.theme07secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme07primaryColor,
                  AppColors.theme07primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'FEE',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
       // Explicitly set actions to an empty list
        ),
      ), body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),

                child: Container(
                  height:  MediaQuery.of(context).size.height / 10,
                  width:  MediaQuery.of(context).size.width / 1.5,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width / 2 - 20,
                        child:
                        feesdhasboardcardDesign(0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),

          Container(
                height: 45,
                width: width - 100,
                decoration: BoxDecoration(
                  color: AppColors.togglebackground,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: AppColors.togglebackground,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                    child: CircularProgressIndicators
                        .theme07primaryColorProgressIndication,
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
                    horizontal:5,
                  ),
                  child: provider.navFeesString == 'Fee Due'
                          ?  Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (provider.financeHiveData.isNotEmpty)
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...provider.feesDetailsData
                                          .map((data) => data.duedescription)
                                          .toSet()
                                          .map((term) {
                                        return Theme(
                            data: Theme.of(context).copyWith(
                              dividerColor: Colors.transparent, 
                            ),
                            child: ExpansionTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                          '$term',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.theme07primaryColor,
                          ),
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.theme07secondaryColor,
                              iconColor: AppColors.theme07primaryColor,
                              textColor: AppColors.theme07primaryColor,
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
                            ],
                          ),
                                  ),
                                )
                          :   Padding(
                                  padding:const  EdgeInsets.all(10),
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
                                          title: Text(
                                            '$term', // Use the term value
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.theme07primaryColor,
                                            ),
                                          ),
                                          // Start collapsed by default
                                          backgroundColor: AppColors.theme07secondaryColor,
                                          iconColor: AppColors.theme07primaryColor,
                                          textColor: AppColors.theme07primaryColor,
                                          children: [
                                            ...provider.financeHiveData
                                                .where((item) => item.term == term)
                                                .map((filteredData) {
                                              final index =
                                                  provider.financeHiveData.indexOf(filteredData);
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
                      'Fee Head',
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
                      '${provider.feesDetailsData[index].duename}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].duename}',
                      style: TextStyles.fontStyle10,
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
                      '${provider.feesDetailsData[index].duedate}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].duedate}',
                      style: TextStyles.fontStyle10,
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
                      '${provider.feesDetailsData[index].dueamount}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].dueamount}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.theme06primaryColor,
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
                      '${provider.feesDetailsData[index].amtcollected}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].amtcollected}',
                      style: TextStyles.fontStyle10,
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
                    child: const Text(
                      'Current Due',
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
                      '${provider.feesDetailsData[index].currentdue}' == ''
                          ? '-'
                          : '${provider.feesDetailsData[index].currentdue}',
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
                      'Fee Head',
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
                      '${provider.financeHiveData[index].duename}' == ''
                          ? '-'
                          : '${provider.financeHiveData[index].duename}',
                      style: TextStyles.fontStyle10,
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
               const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Mode of Payment',
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
               const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 70,
                    child: const Text(
                      'Amount Paid',
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
       const Text(
          'Current Due',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 5,),
        GestureDetector(
          onTap: () {},
          child: Column(

            children: [
              Text(
                '${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}' ==
                    'null'
                    ? '-'
                    : '''Rs. ${feescurrendDataProvider.feesDueDhasboardData[index].currentdue}''',
                style:  TextStyle(
                  color: AppColors.theme07primaryColor,
                  fontSize: 22,
                        fontWeight: FontWeight.bold,
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
              ? AppColors.theme07primaryColor
              : AppColors.togglebackground,
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
