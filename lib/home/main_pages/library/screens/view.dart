import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';

class ViewLibraryPage extends ConsumerStatefulWidget {
  const ViewLibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewLibraryPageState();
}

class _ViewLibraryPageState extends ConsumerState<ViewLibraryPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Member Type',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Member code',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Policy Name',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Status',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
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
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Students',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    '1023456',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Students CSE UG',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    'Active',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
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
                      'Acc.no',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Issue Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Book',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Due Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Return',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Status',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Fine',
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
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 1.6 - 20,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SRM0200',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '1020200',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '25 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Data Structures',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '25 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Not returned',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Books in hand',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '0',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      ' Rs. 50.00',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
