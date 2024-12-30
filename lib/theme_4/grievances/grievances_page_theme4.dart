import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_category_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_subtype_hive_model.dart';
import 'package:sample/home/main_pages/grievances/model.dart/grievance_type_hive_model.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

class GrievanceReportPageTheme4 extends ConsumerStatefulWidget {
  const GrievanceReportPageTheme4({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GrievanceReportPageTheme4State();
}

class _GrievanceReportPageTheme4State
    extends ConsumerState<GrievanceReportPageTheme4> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKeyEntry =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(grievanceProvider.notifier)
            .getStudentWiseGrievanceDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(grievanceProvider.notifier).getHiveGrievanceDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  Future<void> _handleRefreshEntry() async {
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
      ref.read(grievanceProvider.notifier).getHiveGrievanceDetails('');
      ref.read(grievanceProvider.notifier).getHiveGrievanceCategoryDetails('');
      ref.read(grievanceProvider.notifier).getHiveGrievanceSubTypeDetails('');
      ref.read(grievanceProvider.notifier).getHiveGrievanceTypeDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.secondaryColorTheme3,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(150),
          child: Stack(
            children: [
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return AppColors.primaryColorTheme4.createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: SvgPicture.asset(
                  'assets/images/wave.svg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                  color: AppColors.whiteColor,
                  colorBlendMode: BlendMode.srcOut,
                ),
              ),
              ColoredBox(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              RouteDesign(
                                route: const MainScreenPage4(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () async {
                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getStudentWiseGrievanceDetails(
                                    ref.read(encryptionProvider.notifier),
                                  );
                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getHiveGrievanceDetails('');
                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getGrievanceCategoryDetails(
                                    ref.read(encryptionProvider.notifier),
                                  );
                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getHiveGrievanceCategoryDetails('');

                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getGrievanceSubTypeDetails(
                                    ref.read(encryptionProvider.notifier),
                                  );
                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getHiveGrievanceSubTypeDetails('');

                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getGrievanceTypeDetails(
                                    ref.read(encryptionProvider.notifier),
                                  );
                              await ref
                                  .read(grievanceProvider.notifier)
                                  .getHiveGrievanceTypeDetails('');

                              await Navigator.push(
                                context,
                                RouteDesign(
                                  route: const GrievanceReportPageTheme4(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.refresh,
                              color: AppColors.whiteColor,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    const TabBar(
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.all(7),
                      indicatorColor: Colors.white,
                      tabs: [
                        Tab(
                          child: Text(
                            'Grievances',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Grievances Entry',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ColoredBox(
              color: AppColors.secondaryColorTheme3,
              child: grievances(),
            ),
            ColoredBox(
              color: AppColors.secondaryColorTheme3,
              child: grievancesEntry(),
            ),
          ],
        ),
      ),
    );
  }

  Widget grievances() {
    final provider = ref.watch(grievanceProvider);
    return LiquidPullToRefresh(
      key: _refreshIndicatorKey,
      onRefresh: _handleRefresh,
      color: AppColors.theme4color1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (provider is CummulativeAttendanceStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.studentwisegrievanceData.isEmpty &&
                  provider is! CummulativeAttendanceStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle,
                      ),
                    ),
                  ],
                ),
              if (provider.studentwisegrievanceData.isNotEmpty)
                const SizedBox(height: 5),
              ListView.builder(
                itemCount: provider.studentwisegrievanceData.length,
                controller: _listController,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cardDesign(index);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget grievancesEntry() {
    final provider = ref.watch(grievanceProvider);
    final readProvider = ref.read(grievanceProvider.notifier);
    return LiquidPullToRefresh(
      key: _refreshIndicatorKeyEntry,
      onRefresh: _handleRefreshEntry,
      color: AppColors.theme4color1,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            children: [
              // const SizedBox(height: 20),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Subject Description',
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
                        hintText: 'Subject Description',
                        hintStyle: TextStyles.smallLightAshColorFontStyle,
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        elevation: 0,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: AppColors.theme4color3,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {
                        final provider = ref.watch(grievanceProvider);
                        if (provider.subject.text == '') {
                          Alerts.errorAlert(
                            message: 'subject cannot be empty',
                            context: context,
                          );
                        } else if (provider.description.text == '') {
                          Alerts.errorAlert(
                            message: 'Description cannot be empty',
                            context: context,
                          );
                        } else if (provider.selectedgrievanceCaregoryDataList
                                .grievancekcategoryid ==
                            '') {
                          Alerts.errorAlert(
                            message: 'Grievance Category is empty',
                            context: context,
                          );
                        } else if (provider.selectedgrievanceSubTypeDataList
                                .grievancesubcategoryid ==
                            '') {
                          Alerts.errorAlert(
                            message: 'Grievance SubType is empty',
                            context: context,
                          );
                        } else if (provider.selectedgrievanceTypeDataList
                                .grievancetypeid ==
                            '') {
                          Alerts.errorAlert(
                            message: 'Grievance Type is empty',
                            context: context,
                          );
                        } else {
                          await ref
                              .read(grievanceProvider.notifier)
                              .saveGrievanceDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyles.fontStyletheme2,
                      ),
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

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(grievanceProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width / 3 + 25,
                        child: Text(
                          '${provider.studentwisegrievanceData[index].subject}' ==
                                  ''
                              ? '-'
                              : '${provider.studentwisegrievanceData[index].subject}',
                          style: const TextStyle(
                            fontSize: 22,
                            color: AppColors.theme4color2,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width / 4,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].status}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].status}',
                      style: TextStyle(
                        fontSize: 18,
                        color: provider.studentwisegrievanceData[index]
                                    .activestatus ==
                                '0'
                            ? Colors.orangeAccent
                            : AppColors.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${provider.studentwisegrievanceData[index].grievancecategory}' ==
                                ''
                            ? '-'
                            : '${provider.studentwisegrievanceData[index].grievancecategory}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.grey4,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Text(
                    '${provider.studentwisegrievanceData[index].grievancetype}' ==
                            ''
                        ? ' -'
                        : ' ${provider.studentwisegrievanceData[index].grievancetype}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${provider.studentwisegrievanceData[index].grievanceid}' ==
                                ''
                            ? '-'
                            : '${provider.studentwisegrievanceData[index].grievanceid}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.grey4,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  Text(
                    '${provider.studentwisegrievanceData[index].grievancetime}' ==
                            ''
                        ? '-'
                        : '${provider.studentwisegrievanceData[index].grievancetime}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    width: width * 40,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancedesc}' ==
                              ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].grievancedesc}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.grey4,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sub Category Description',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '${provider.studentwisegrievanceData[index].grievancesubcategorydesc}' ==
                            ''
                        ? '-'
                        : '${provider.studentwisegrievanceData[index].grievancesubcategorydesc}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Reply',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.grey1,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  Text(
                    '${provider.studentwisegrievanceData[index].replytext}' ==
                            ''
                        ? '-'
                        : '${provider.studentwisegrievanceData[index].replytext}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: AppColors.grey4,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // Padding(
    //   padding: const EdgeInsets.only(bottom: 8),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: const BorderRadius.all(Radius.circular(20)),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.2),
    //           // spreadRadius: 2,
    //           blurRadius: 7,
    //           offset: const Offset(0, 3),
    //         ),
    //       ],
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: Column(
    //         children: [
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'Grievance id',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].grievanceid}' ==
    //                           ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].grievanceid}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'Grievance category',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].grievancecategory}' ==
    //                           ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].grievancecategory}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'Grievance desc',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].grievancedesc}' ==
    //                           ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].grievancedesc}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'Grievance time',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].grievancetime}' ==
    //                           ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].grievancetime}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'Grievance type',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].grievancetype}' ==
    //                           ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].grievancetype}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'subject',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].subject}' ==
    //                           ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].subject}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'Status',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].status}' == ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].status}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(
    //                 width: width / 2 - 80,
    //                 child: const Text(
    //                   'Active status',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //               const Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               const SizedBox(width: 5),
    //               SizedBox(
    //                 width: width / 2 - 60,
    //                 child: Text(
    //                   '${provider.studentwisegrievanceData[index].activestatus}' ==
    //                           ''
    //                       ? '-'
    //                       : '''${provider.studentwisegrievanceData[index].activestatus}''',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
