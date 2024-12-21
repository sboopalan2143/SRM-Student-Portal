import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/grievances/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01GrievanceReportPage extends ConsumerStatefulWidget {
  const Theme01GrievanceReportPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01GrievanceReportPageState();
}

class _Theme01GrievanceReportPageState
    extends ConsumerState<Theme01GrievanceReportPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
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

  @override
  void initState() {
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(grievanceProvider);
    return Scaffold(
      key: scaffoldKey,
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
                'GRIEVANCES',
                style: TextStyles.buttonStyle01theme4,
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
                          await ref
                              .read(grievanceProvider.notifier)
                              .getStudentWiseGrievanceDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(grievanceProvider.notifier)
                              .getHiveGrievanceDetails('');
                        },
                        child: Icon(
                          Icons.refresh,
                          color: AppColors.theme01primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: ButtonDesign.buttonDesign(
                    'Grievance Entry',
                    AppColors.primaryColor,
                    context,
                    ref.read(mainProvider.notifier),
                    ref,
                  ),
                ),
                const SizedBox(height: 10),
                if (provider is GrievanceStateLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircularProgressIndicators
                          .theme01primaryColorProgressIndication,
                    ),
                  )
                else if (provider.studentwisegrievanceData.isEmpty &&
                    provider is! GrievanceStateLoading)
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      const Center(
                        child: Text(
                          'No List Added',
                          style: TextStyles.fontStyle1,
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(grievanceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Material(
        elevation: 5,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.theme01secondaryColor1,
                AppColors.theme01secondaryColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ExpansionTile(
              title: Row(
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: Text(
                      'ID:',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievanceid}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].grievanceid}''',
                      style: TextStyles.fontStyle2,
                    ),
                  ),
                ],
              ),
              collapsedIconColor: AppColors.theme01primaryColor,
              iconColor: AppColors.theme01primaryColor,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Grievance Category :',
                  '${provider.studentwisegrievanceData[index].grievancecategory}' ==
                          ''
                      ? '-'
                      : '''${provider.studentwisegrievanceData[index].grievancecategory}''',
                  width,
                ),
                _buildRow(
                  'Grievance Desc',
                  '${provider.studentwisegrievanceData[index].grievancedesc}' ==
                          ''
                      ? '-'
                      : '''${provider.studentwisegrievanceData[index].grievancedesc}''',
                  width,
                ),
                _buildRow(
                  'Grievance Time',
                  '${provider.studentwisegrievanceData[index].grievancetime}' ==
                          ''
                      ? '-'
                      : '''${provider.studentwisegrievanceData[index].grievancetime}''',
                  width,
                ),
                _buildRow(
                  'Grievance Type :',
                  '${provider.studentwisegrievanceData[index].grievancetype}' ==
                          ''
                      ? '-'
                      : '''${provider.studentwisegrievanceData[index].grievancetype}''',
                  width,
                ),
                _buildRow(
                  'Subject',
                  '${provider.studentwisegrievanceData[index].subject}' == ''
                      ? '-'
                      : '''${provider.studentwisegrievanceData[index].subject}''',
                  width,
                ),
                _buildRow(
                  'Status',
                  '${provider.studentwisegrievanceData[index].status}' == ''
                      ? '-'
                      : '''${provider.studentwisegrievanceData[index].status}''',
                  width,
                ),
                _buildRow(
                  'Active Status',
                  '${provider.studentwisegrievanceData[index].activestatus}' ==
                          ''
                      ? '-'
                      : '''${provider.studentwisegrievanceData[index].activestatus}''',
                  width,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            title,
            style: TextStyles.buttonStyle01theme2,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle2,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle2,
          ),
        ),
      ],
    );
  }
}
