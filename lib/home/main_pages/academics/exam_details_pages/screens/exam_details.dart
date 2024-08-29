import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';

class ExamDetailsPage extends ConsumerStatefulWidget {
  const ExamDetailsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExamDetailsPageState();
}

class _ExamDetailsPageState extends ConsumerState<ExamDetailsPage> {
  final ScrollController _listController = ScrollController();
  List<String> name = ['Select Year/Sem', 'one', 'two', 'three'];
  String selectedValue = 'Select Year/Sem';

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(examDetailsProvider);
    log('exam details---main page ${provider.examDetailsData.length}');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                color: AppColors.grey2,
              ),
            ),
            height: 40,
            child: DropdownSearch<String>(
              // dropdownButtonProps: DropdownButtonProps(
              //   focusNode: widget.focusNodeC,
              // ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
              ),
              itemAsString: (item) => item,
              items: name,
              popupProps: const PopupProps.menu(
                searchFieldProps: TextFieldProps(
                  autofocus: true,
                ),
                constraints: BoxConstraints(maxHeight: 250),
              ),
              selectedItem: selectedValue,
              onChanged: (value) {
                // readProvider.selectCustomer(value!);
                setState(() {
                  selectedValue = value!;
                });
              },
              dropdownBuilder: (BuildContext context, name) {
                return Text(
                  name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.smallLightAshColorFontStyle,
                );
              },
            ),
          ),
        ),
        Center(
          child: Text(
            '2nd Year, 4th Sem',
            style: TextStyles.smallPrimaryColorFontStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            itemCount: provider.examDetailsData.length,
            controller: _listController,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return cardDesign(index);
            },
          ),
        ),
      ],
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(examDetailsProvider);
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
                    child: const Text(
                      'Subject Code',
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
                      '${provider.examDetailsData[index].subjectcode}' == ''
                          ? '-'
                          : '${provider.examDetailsData[index].subjectcode}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
                    child: const Text(
                      'Subject Desc',
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
                      '${provider.examDetailsData[index].subjectdesc}' == ''
                          ? '-'
                          : '${provider.examDetailsData[index].subjectdesc}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
                    child: const Text(
                      'Semester',
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
                      '${provider.examDetailsData[index].semester}' == ''
                          ? '-'
                          : '${provider.examDetailsData[index].semester}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
                    child: const Text(
                      'Internal',
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
                      '${provider.examDetailsData[index].internal}' == ''
                          ? '-'
                          : '${provider.examDetailsData[index].internal}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
                    child: const Text(
                      'External',
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
                      '${provider.examDetailsData[index].external}' == ''
                          ? '-'
                          : '${provider.examDetailsData[index].external}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
                    child: const Text(
                      'Grade',
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
                      '${provider.examDetailsData[index].grade}' == ''
                          ? '-'
                          : '${provider.examDetailsData[index].grade}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 125,
                    child: const Text(
                      'Credit',
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
                      '${provider.examDetailsData[index].credit}' == ''
                          ? '-'
                          : '${provider.examDetailsData[index].credit}',
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
}
