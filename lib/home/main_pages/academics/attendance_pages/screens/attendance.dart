import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  final ScrollController _listController = ScrollController();
  List<String> name = ['Select Year/Sem', 'one', 'two', 'three'];
  String selectedValue = 'Select Year/Sem';

  @override
  Widget build(BuildContext context) {
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            itemCount: 5,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        // elevation: 0,
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
                width: width / 2 - 100,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Code',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Subject',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Total Hrs.',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Present Hrs.',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Absent Hrs.',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Percentage',
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
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 60,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '533658',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Data Structures',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '20',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '19',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '1',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '90%',
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
