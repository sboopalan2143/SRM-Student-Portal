import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/transport/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class TransportTransactionPage extends ConsumerStatefulWidget {
  const TransportTransactionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransportTransactionPageState();
}

class _TransportTransactionPageState
    extends ConsumerState<TransportTransactionPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                itemCount: 20,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width / 2 - 125,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tran. ID',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Bus Route',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Price',
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
                width: width / 1.6 - 80,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SRM0190',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '21 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '2B - Thiruvanmiyur',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Rs. 500.00',
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
}
