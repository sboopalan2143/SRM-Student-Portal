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
import 'package:sample/home/widgets/drawer_design.dart';

class Theme02GrievanceReportPage extends ConsumerStatefulWidget {
  const Theme02GrievanceReportPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02GrievanceReportPageState();
}

class _Theme02GrievanceReportPageState
    extends ConsumerState<Theme02GrievanceReportPage> {
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(grievanceProvider.notifier).getStudentWiseGrievanceDetails(
            ref.read(encryptionProvider.notifier),
          );
      await ref.read(grievanceProvider.notifier).getHiveGrievanceDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(grievanceProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme02primaryColor,
                  AppColors.theme02secondaryColor1,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
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
          title: const Text(
            'GRIEVANCES',
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
                  AppColors.whiteColor,
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
                    const Center(
                      child: Text(
                        'No List Added Yet!',
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
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(grievanceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.theme02primaryColor,
              AppColors.theme02secondaryColor1,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoRowModern(
                icon: Icons.confirmation_number,
                label: "Grievance ID",
                value:
                    provider.studentwisegrievanceData[index].grievanceid ?? '-',
                highlight: true,
              ),
              infoRowModern(
                icon: Icons.category,
                label: "Category",
                value: provider
                        .studentwisegrievanceData[index].grievancecategory ??
                    '-',
              ),
              infoRowModern(
                icon: Icons.description,
                label: "Description",
                value: provider.studentwisegrievanceData[index].grievancedesc ??
                    '-',
              ),
              infoRowModern(
                icon: Icons.access_time,
                label: "Time",
                value: provider.studentwisegrievanceData[index].grievancetime ??
                    '-',
              ),
              infoRowModern(
                icon: Icons.type_specimen,
                label: "Type",
                value: provider.studentwisegrievanceData[index].grievancetype ??
                    '-',
              ),
              infoRowModern(
                icon: Icons.subject,
                label: "Subject",
                value: provider.studentwisegrievanceData[index].subject ?? '-',
              ),
              infoRowModern(
                icon: Icons.info,
                label: "Status",
                value: provider.studentwisegrievanceData[index].status ?? '-',
                highlight: true,
              ),
              infoRowModern(
                icon: Icons.check_circle,
                label: "Active Status",
                value: provider.studentwisegrievanceData[index].activestatus ??
                    '-',
                highlight: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRowModern({
    required IconData icon,
    required String label,
    required String value,
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.theme02buttonColor2,
            size: 22,
          ),
          const SizedBox(width: 10),
          Text(
            "$label : ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                color: highlight ? AppColors.theme02buttonColor2 : Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //   final provider = ref.watch(grievanceProvider);

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
  //     child: Material(
  //       elevation: 5,
  //       shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
  //       borderRadius: BorderRadius.circular(20),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [
  //               AppColors.theme01secondaryColor1,
  //               AppColors.theme01secondaryColor2,
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(20),
  //           child: ExpansionTile(
  //             title: Row(
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 100,
  //                   child: Text(
  //                     'Grievance id :',
  //                     style: TextStyles.buttonStyle01theme2,
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: Text(
  //                     '${provider.studentwisegrievanceData[index].grievanceid}' ==
  //                             ''
  //                         ? '-'
  //                         : '''${provider.studentwisegrievanceData[index].grievanceid}''',
  //                     style: TextStyles.fontStyle2,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             collapsedIconColor: AppColors.theme01primaryColor,
  //             iconColor: AppColors.theme01primaryColor,
  //             children: [
  //               Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
  //               _buildRow(
  //                 'Grievance category :',
  //                 '${provider.studentwisegrievanceData[index].grievancecategory}' ==
  //                         ''
  //                     ? '-'
  //                     : '''${provider.studentwisegrievanceData[index].grievancecategory}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Grievance desc',
  //                 '${provider.studentwisegrievanceData[index].grievancedesc}' ==
  //                         ''
  //                     ? '-'
  //                     : '''${provider.studentwisegrievanceData[index].grievancedesc}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Grievance time',
  //                 '${provider.studentwisegrievanceData[index].grievancetime}' ==
  //                         ''
  //                     ? '-'
  //                     : '''${provider.studentwisegrievanceData[index].grievancetime}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Grievance type :',
  //                 '${provider.studentwisegrievanceData[index].grievancetype}' ==
  //                         ''
  //                     ? '-'
  //                     : '''${provider.studentwisegrievanceData[index].grievancetype}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Subject',
  //                 '${provider.studentwisegrievanceData[index].subject}' == ''
  //                     ? '-'
  //                     : '''${provider.studentwisegrievanceData[index].subject}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Status',
  //                 '${provider.studentwisegrievanceData[index].status}' == ''
  //                     ? '-'
  //                     : '''${provider.studentwisegrievanceData[index].status}''',
  //                 width,
  //               ),
  //               _buildRow(
  //                 'Active status',
  //                 '${provider.studentwisegrievanceData[index].activestatus}' ==
  //                         ''
  //                     ? '-'
  //                     : '''${provider.studentwisegrievanceData[index].activestatus}''',
  //                 width,
  //               ),
  //               const SizedBox(height: 10),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
