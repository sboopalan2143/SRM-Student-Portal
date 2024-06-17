import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/grievances/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class GrievanceReportPage extends ConsumerStatefulWidget {
  const GrievanceReportPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GrievanceReportPageState();
}

class _GrievanceReportPageState extends ConsumerState<GrievanceReportPage> {
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
                  'Grievance Entry',
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
                      'Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Type',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Description',
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
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 1.6 - 80,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '25 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Management',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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
