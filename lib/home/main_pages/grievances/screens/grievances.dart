import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/main_pages/grievances/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class GrievanceReportPage extends ConsumerStatefulWidget {
  const GrievanceReportPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GrievanceReportPageState();
}

class _GrievanceReportPageState extends ConsumerState<GrievanceReportPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(grievanceProvider.notifier).getHiveGrievanceDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(grievanceProvider);
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColor,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                'GRIEVANCES',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                // Row(
                //   children: [
                //     IconButton(
                //       onPressed: () {
                //
                //       },
                //       icon: const Icon(
                //         Icons.menu,
                //         size: 35,
                //         color: AppColors.whiteColor,
                //       ),
                //     ),
                //   ],
                // ),
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
          ],
        ),
      ),
      body: Padding(
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
                     Center(
                      child: Text(
                        'No List Added Yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(grievanceProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              // spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
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
                    width: width / 2 - 80,
                    child:  Text(
                      'Grievance id',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievanceid}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].grievanceid}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Grievance category',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancecategory}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].grievancecategory}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Grievance desc',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancedesc}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].grievancedesc}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Grievance time',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancetime}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].grievancetime}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child:  Text(
                      'Grievance type',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancetype}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].grievancetype}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'subject',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].subject}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].subject}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Status',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].status}' == ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].status}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child:  Text(
                      'Active status',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                   Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].activestatus}' ==
                              ''
                          ? '-'
                          : '''${provider.studentwisegrievanceData[index].activestatus}''',
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
