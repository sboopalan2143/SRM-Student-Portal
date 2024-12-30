import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/grievances/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01GrievanceEntryPage extends ConsumerStatefulWidget {
  const Theme01GrievanceEntryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01GrievanceEntryPageState();
}

class _Theme01GrievanceEntryPageState
    extends ConsumerState<Theme01GrievanceEntryPage> {
  String? selectedGrievanceCategory;

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(grievanceProvider.notifier).getGrievanceCategoryDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref
            .read(grievanceProvider.notifier)
            .getHiveGrievanceCategoryDetails('');

        await ref.read(grievanceProvider.notifier).getGrievanceSubTypeDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref
            .read(grievanceProvider.notifier)
            .getHiveGrievanceSubTypeDetails('');

        await ref.read(grievanceProvider.notifier).getGrievanceTypeDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref
            .read(grievanceProvider.notifier)
            .getHiveGrievanceTypeDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

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
      backgroundColor: AppColors.theme01primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'GRIEVANCES ENTRY',
                style: TextStyles.buttonStyle01theme4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primaryColor,
        child: SingleChildScrollView(
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
                      style: TextStyles.theme01primary10smal3,
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
                        selectedItem:
                            provider.selectedgrievanceCaregoryDataList,
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
                    Text(
                      'Grievances Sub Type',
                      style: TextStyles.theme01primary10smal3,
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
                        dropdownBuilder:
                            (BuildContext context, grievencesSubtype) {
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
                    Text(
                      'Grievances Type',
                      style: TextStyles.theme01primary10smal3,
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
                          readProvider.settype(
                            value!,
                          );
                        },
                        dropdownBuilder:
                            (BuildContext context, grievencestype) {
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
                      style: TextStyles.theme01primary10smal3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: provider.subject,
                        style: TextStyles.theme01primary10smal3,
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
                    Text(
                      'Subject Description',
                      style: TextStyles.theme01primary10smal3,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: provider.description,
                        style: TextStyles.theme01primary10smal3,
                        decoration: InputDecoration(
                          hintText: 'Subject Description',
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
      ),
      endDrawer: const DrawerDesign(),
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
