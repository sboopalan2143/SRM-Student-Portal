import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

import '../../../../designs/_designs.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    final name = <String>['Select Date', 'one', 'two', 'three'];
    var selectedValue = 'Select Date';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Hostel',
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
            ],
          ),
          const SizedBox(height: 20),
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
                                horizontal: 20, vertical: 5),
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
                                horizontal: 20, vertical: 5),
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
                'Home',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Department',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Year & Sem',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mobile Number',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
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
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
                width: 30,
                child: Checkbox(
                  side: const BorderSide(color: AppColors.grey, width: 2),
                  checkColor: AppColors.whiteColor,
                  value: false,
                  onChanged: (bool? value) {},
                ),
              ),
              const SizedBox(width: 5),
              const Text(
                'I Agree and Continue to ',
                style: TextStyles.fontStyle10,
              ),
              const Text(
                ' Terms and Conditions',
                style: TextStyles.fontStyle14,
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
