import 'dart:async';
import 'dart:developer';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/grievances/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07GrievanceEntryPage extends ConsumerStatefulWidget {
  const Theme07GrievanceEntryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07GrievanceEntryPageState();
}

class _Theme07GrievanceEntryPageState extends ConsumerState<Theme07GrievanceEntryPage> {
  String? selectedGrievanceCategory;

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(grievanceProvider.notifier).getHiveGrievanceCategoryDetails('');
      ref.read(grievanceProvider.notifier).getHiveGrievanceSubTypeDetails('');
      ref.read(grievanceProvider.notifier).getHiveGrievanceTypeDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final provider = ref.watch(grievanceProvider);
    final readProvider = ref.read(grievanceProvider.notifier);
    ref.listen(grievanceProvider, (previous, next) {
      if (next is GrievanceStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is GrievanceStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
        // Navigator.push(
        //   context,
        //   RouteDesign(
        //     route: const HomePage2(),
        //   ),
        // );
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.whiteColor,
          ),
        ),
        title: Text(
          'GRIEVANCES ENTRY',
          style: TextStyles.fontStyle4,
          overflow: TextOverflow.clip,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      await ref.read(grievanceProvider.notifier).getStudentWiseGrievanceDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref.read(grievanceProvider.notifier).getHiveGrievanceDetails('');
                    });
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grievances Category',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80),
                      ),
                    ),
                    height: 40,
                    child: DropdownSearch<GrievanceCategoryHiveData>(
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
              if (provider.selectedgrievanceCaregoryDataList.grievancekcategory == 'Harassment')
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category Sub Type',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80),
                          ),
                        ),
                        height: 40,
                        child: DropdownSearch<GrievanceSubTypeHiveData>(
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
                ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Grievances Type',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80),
                      ),
                    ),
                    height: 40,
                    child: DropdownSearch<GrievanceTypeHiveData>(
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
                        log('Value >>>> ${value?.grievancetypeid}');
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
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: provider.subject,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                      cursorColor: Theme.of(context).colorScheme.inverseSurface,
                      decoration: InputDecoration(
                        hintText: 'Subject',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80),
                          fontWeight: FontWeight.bold,
                        ),
                        filled: true,
                        fillColor: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject Description',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: provider.description,
                    maxLines: 3,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    cursorColor: Theme.of(context).colorScheme.inverseSurface,
                    decoration: InputDecoration(
                      hintText: 'Subject Description',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80),
                        fontWeight: FontWeight.bold,
                      ),
                      filled: true,
                      fillColor: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inverseSurface.withAlpha(80),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
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
                      ref,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // endDrawer: const DrawerDesign(),
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
