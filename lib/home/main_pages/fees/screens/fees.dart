import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class FeesPage extends ConsumerStatefulWidget {
  const FeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeesPageState();
}

class _FeesPageState extends ConsumerState<FeesPage> {
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(feesProvider.notifier)
          .getFinanceDetails(ref.read(encryptionProvider.notifier));
      ref
          .read(feesProvider.notifier)
          .getFeesPaidDetails(ref.read(encryptionProvider.notifier));
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);
    ref.listen(feesProvider, (previous, next) {
      if (next is FeesError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is FeesStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 40),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       SizedBox(height: height * 0.02),
        //       Card(
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(20),
        //         ),
        //         elevation: 0,
        //         color: AppColors.whiteColor,
        //         child: Padding(
        //           padding: const EdgeInsets.all(25),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               const Text(
        //                 'Fees Due for upcoming sem',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyles.fontStyle8,
        //               ),
        //               Text(
        //                 'Rs. 5,000.00',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyles.fontStyle9,
        //               ),
        //               const Text(
        //                 'Due Date: 08th June, 2024',
        //                 textAlign: TextAlign.center,
        //                 style: TextStyles.fontStyle8,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       SizedBox(
        //         height: height * 0.04,
        //       ),
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
              child: CircularProgressIndicators.primaryColorProgressIndication,
            ),
          )
        else if (provider.financeData.isEmpty && provider is! FeesStateLoading)
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
        if (provider.financeData.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
              itemCount: provider.navFeesString == 'Paid Details'
                  ? provider.feespaidData.length
                  : provider.financeData.length,
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
                      'Member Name',
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
                      '${provider.feespaidData[index].membername}' == ''
                          ? '-'
                          : '${provider.feespaidData[index].membername}',
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
                      'Member Code',
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
                      '${provider.feespaidData[index].membercode}' == ''
                          ? '-'
                          : '${provider.feespaidData[index].membercode}',
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
                      'Member Type',
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
                      '${provider.feespaidData[index].membertype}' == ''
                          ? '-'
                          : '${provider.feespaidData[index].membertype}',
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
                      'Status',
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
                      '${provider.feespaidData[index].status}' == ''
                          ? '-'
                          : '${provider.feespaidData[index].status}',
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
                    width: width / 2 - 125,
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
                      '${provider.financeData[index].receiptnum}' == ''
                          ? '-'
                          : '${provider.financeData[index].receiptnum}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
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
                      '${provider.financeData[index].duedate}' == ''
                          ? '-'
                          : '${provider.financeData[index].duedate}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
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
                      '${provider.financeData[index].modeoftransaction}' == ''
                          ? '-'
                          : '${provider.financeData[index].modeoftransaction}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
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
                      '${provider.financeData[index].dueamount}' == ''
                          ? '-'
                          : '${provider.financeData[index].dueamount}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
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
                      '${provider.financeData[index].term}' == ''
                          ? '-'
                          : '${provider.financeData[index].term}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
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
                      '${provider.financeData[index].amountcollected}' == ''
                          ? '-'
                          : '${provider.financeData[index].amountcollected}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
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
                      '${provider.financeData[index].receiptdate}' == ''
                          ? '-'
                          : '${provider.financeData[index].receiptdate}',
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
          ),),
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
