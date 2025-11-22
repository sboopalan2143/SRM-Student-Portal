import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/grievances/riverpod/grievance_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07GrievanceFullDetailPage extends ConsumerStatefulWidget {
  const Theme07GrievanceFullDetailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07GrievanceFullDetailPageState();
}

class _Theme07GrievanceFullDetailPageState extends ConsumerState<Theme07GrievanceFullDetailPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          elevation: 0,
          title: Text(
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
                      await ref.read(grievanceProvider.notifier).getStudentWiseGrievanceDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref.read(grievanceProvider.notifier).getHiveGrievanceDetails('');
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
              // SizedBox(
              //   width: 200,
              //   child: ButtonDesign.buttonDesign(
              //     'Grievance Entry',
              //     AppColors.whiteColor,
              //     context,
              //     ref.read(mainProvider.notifier),
              //     ref,
              //   ),
              // ),
              // const SizedBox(height: 10),
              if (provider is CummulativeAttendanceStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators.primaryColorProgressIndication,
                  ),
                )
              else if (provider.studentwisegrievanceData.isEmpty && provider is! CummulativeAttendanceStateLoading)
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
              if (provider.studentwisegrievanceData.isNotEmpty) const SizedBox(height: 5),
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
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(grievanceProvider);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    child: Text(
                      'Grievance ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievanceid}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].grievanceid}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.theme06primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancecategory}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].grievancecategory}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancetime}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].grievancetime}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Type',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancetype}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].grievancetype}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'subject',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].subject}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].subject}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].status}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].status}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.studentwisegrievanceData[index].grievancedesc}' == ''
                          ? '-'
                          : '${provider.studentwisegrievanceData[index].grievancedesc}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
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
        Expanded(
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
