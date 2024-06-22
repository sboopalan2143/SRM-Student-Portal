import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class FeesPage extends ConsumerStatefulWidget {
  const FeesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeesPageState();
}

class _FeesPageState extends ConsumerState<FeesPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(feesProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: height * 0.02),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
                color: AppColors.whiteColor,
                child:  Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Fees Due for upcoming sem',
                        textAlign: TextAlign.center,
                        style: TextStyles.fontStyle8,
                      ),
                      Text(
                        'Rs. 5,000.00',
                        textAlign: TextAlign.center,
                        style: TextStyles.fontStyle9,
                      ),
                      const Text(
                        'Due Date: 08th June, 2024',
                        textAlign: TextAlign.center,
                        style: TextStyles.fontStyle8,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
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
              const Text(
                '2023 - 2024    Total: Rs. 15,000.00',
                textAlign: TextAlign.center,
                style: TextStyles.fontStyle7,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            itemCount: 5,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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
          child: Row(
            children: [
              SizedBox(
                width: width / 2 - 125,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice ID',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Fees',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Amount',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 60,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SRM021',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '25 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Semester Fees',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Rs. 5,000.00',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesignTrans(int index) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      elevation: 0,
      // style: BorderBoxButtonDecorations.homePageButtonStyle,
      // onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: width / 2 - 125,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Invoice ID',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Date',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Trans.ID',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Amount',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ':',
                  style: TextStyles.fontStyle10,
                ),
                Text(
                  ':',
                  style: TextStyles.fontStyle10,
                ),
                Text(
                  ':',
                  style: TextStyles.fontStyle10,
                ),
                Text(
                  ':',
                  style: TextStyles.fontStyle10,
                ),
              ],
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: width / 2 - 60,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SRM021',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    '25 May, 2024',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Semester Fees',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Rs. 5,000.00',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
            )
          ],
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
          )),
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
