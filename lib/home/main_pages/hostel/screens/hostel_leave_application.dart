import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class LeaveApplicationPage extends ConsumerStatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends ConsumerState<LeaveApplicationPage> {
  @override
  Widget build(BuildContext context) {
    final name = <String>['Select Date', 'one', 'two', 'three'];
    var selectedValue = 'Select Date';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FromDate',
                      style: TextStyles.fontStyle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
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
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ToDate',
                      style: TextStyles.fontStyle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
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
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reason for Leave',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                child: TextField(
                  maxLines: 4,
                  keyboardType: TextInputType.number,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder:
                        BorderBoxButtonDecorations.loginTextFieldStyle,
                    focusedBorder:
                        BorderBoxButtonDecorations.loginTextFieldStyle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ButtonDesign.buttonDesign(
                  'Submit',
                  AppColors.primaryColor,
                  context,
                  ref.read(mainProvider.notifier),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
