import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/grievances/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class GrievanceEntryPage extends ConsumerStatefulWidget {
  const GrievanceEntryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GrievanceEntryPageState();
}

class _GrievanceEntryPageState extends ConsumerState<GrievanceEntryPage> {
  String? selectedGrievanceCategory;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(grievanceProvider);
    final readProvider = ref.read(grievanceProvider.notifier);
    ref.listen(grievanceProvider, (previous, next) {
      if (next is GrievanceStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is GrievanceStateError) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student ID',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.studentId,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Enter Student ID',
                    hintStyle: TextStyles.smallLightAshColorFontStyle,
                    filled: true,
                    fillColor: AppColors.secondaryColor,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student Name',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.studentname,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Student Name',
                    hintStyle: TextStyles.smallLightAshColorFontStyle,
                    filled: true,
                    fillColor: AppColors.secondaryColor,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Subject',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.subject,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Subject',
                    hintStyle: TextStyles.smallLightAshColorFontStyle,
                    filled: true,
                    fillColor: AppColors.secondaryColor,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Grievances Category',
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
                child: DropdownSearch<GrievanceCategoryData>(
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      // border: BorderRadius.circular(10),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                    ),
                  ),
                  itemAsString: (item) => item.grievancekcategory!,
                  items: provider.grievanceCaregoryData,
                  popupProps: const PopupProps.menu(
                    constraints: BoxConstraints(maxHeight: 250),
                  ),
                  selectedItem: provider.selectedgrievanceCaregoryDataList,
                  onChanged: (value) {
                    readProvider.setValue(
                      value!,
                    );
                  },
                  dropdownBuilder: (BuildContext context, grievences) {
                    return Text(
                      '''  ${grievences?.grievancekcategory}''',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
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
                'Grievances Sub Type',
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
                child: DropdownSearch<GrievanceSubTypeData>(
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      // border: BorderRadius.circular(10),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                    ),
                  ),
                  itemAsString: (item) => item.grievancesubcategorydesc!,
                  items: provider.grievanceSubType,
                  popupProps: const PopupProps.menu(
                    constraints: BoxConstraints(maxHeight: 250),
                  ),
                  selectedItem: provider.selectedgrievanceSubTypeDataList,
                  onChanged: (value) {
                    readProvider.setsubtype(
                      value!,
                    );
                  },
                  dropdownBuilder: (BuildContext context, grievencesSubtype) {
                    return Text(
                      '''  ${grievencesSubtype?.grievancesubcategorydesc}''',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
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
                'Grievances Type',
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
                child: DropdownSearch<GrievanceData>(
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      // border: BorderRadius.circular(10),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                    ),
                  ),
                  itemAsString: (item) => item.grievancetype!,
                  items: provider.grievanceType,
                  popupProps: const PopupProps.menu(
                    constraints: BoxConstraints(maxHeight: 250),
                  ),
                  selectedItem: provider.selectedgrievanceTypeDataList,
                  onChanged: (value) {
                    readProvider.settype(
                      value!,
                    );
                  },
                  dropdownBuilder: (BuildContext context, grievencestype) {
                    return Text(
                      '''  ${grievencestype?.grievancetype}''',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    );
                  },
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
                'Description',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.description,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyles.smallLightAshColorFontStyle,
                    filled: true,
                    fillColor: AppColors.secondaryColor,
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
            children: [
              Expanded(
                child: ButtonDesign.buttonDesign(
                  'Submit',
                  AppColors.primaryColor,
                  context,
                  ref.read(mainProvider.notifier),
                  ref,
                ),
              ),
            ],
          ),
        ],
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
