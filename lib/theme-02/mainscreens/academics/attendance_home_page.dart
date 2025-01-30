import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/dhasboard_overall_attendance_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendance_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-02/mainscreens/academics/attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/cumulative_attendance.dart';
import 'package:sample/theme-02/mainscreens/academics/hour_attendance.dart';

class AttendanceHomePage extends ConsumerStatefulWidget {
  const AttendanceHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AttendanceHomePageState();
}

class _AttendanceHomePageState extends ConsumerState<AttendanceHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref
          .read(DhasboardoverallattendanceProvider.notifier)
          .getDhasboardOverallAttendanceDetails(
              ref.read(encryptionProvider.notifier));
      await ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      await ref.read(hostelProvider.notifier).getRoomTypeHiveData('');

      final profile = await Hive.openBox<ProfileHiveData>('profile');
      if (profile.isEmpty) {
        await ref.read(profileProvider.notifier).getProfileApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(profileProvider.notifier).getProfileHive('');
      }
      await profile.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    log('Regconfig  : ${provider.hostelRegisterDetails!.regconfig}');
    log('status  : ${provider.hostelRegisterDetails!.status}');
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

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
            'Attendance',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                cardDesignAttendanceHrs(),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme02HourAttendancePage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.80, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 4,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          // const SizedBox(width: 15),
                          SvgPicture.asset(
                            'assets/images/hourattendancetheme3.svg',
                            color: AppColors.whiteColor,
                            height: MediaQuery.of(context).size.height / 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Hour Attendance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme02AttendancePage(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.80, // Responsive width
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 4,
                ),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.theme02primaryColor,
                      AppColors.theme02secondaryColor1,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 6),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/attendancetheme3.svg',
                            color: AppColors.whiteColor,
                            height: MediaQuery.of(context).size.height / 28,
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Sub Wise Attendance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 20,
          // ),
          // Center(
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         RouteDesign(
          //           route: const Theme02CumulativeAttendancePage(),
          //         ),
          //       );
          //     },
          //     child: Container(
          //       width: MediaQuery.of(context).size.width *
          //           0.80, // Responsive width
          //       padding: const EdgeInsets.symmetric(
          //         vertical: 16,
          //         horizontal: 4,
          //       ),
          //
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(24),
          //         gradient: LinearGradient(
          //           colors: [
          //             AppColors.theme02primaryColor,
          //             AppColors.theme02secondaryColor1,
          //           ],
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //         ),
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Colors.black26,
          //             offset: Offset(0, 6),
          //             blurRadius: 12,
          //           ),
          //         ],
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           const SizedBox(width: 12),
          //           Row(
          //             children: [
          //               SvgPicture.asset(
          //                 'assets/images/cumulativeattendancetheme3.svg',
          //                 color: AppColors.whiteColor,
          //                 height: MediaQuery.of(context).size.height / 28,
          //               ),
          //               const SizedBox(width: 12),
          //               const Text(
          //                 'Cumulative Attendance',
          //                 style: TextStyle(
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.bold,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           const Row(
          //             children: [
          //               SizedBox(width: 8),
          //               Icon(
          //                 Icons.arrow_forward_ios,
          //                 size: 20,
          //                 color: Colors.white,
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget cardDesignAttendanceHrs() {
  //   final provider = ref.watch(overallattendanceProvider);
  //   // final provider = ref.watch(DhasboardoverallattendanceProvider);
  //
  //   final totalPresent = provider.OverallattendanceData.fold<int>(
  //     0,
  //     (sum, item) => sum + (int.tryParse(item.present ?? '0') ?? 0),
  //   );
  //
  //   final totalAbsent = provider.OverallattendanceData.fold<int>(
  //     0,
  //     (sum, item) => sum + (int.tryParse(item.absent ?? '0') ?? 0),
  //   );
  //
  //   final totalML = provider.OverallattendanceData.fold<int>(
  //     0,
  //     (sum, item) => sum + (int.tryParse(item.ml ?? '0') ?? 0),
  //   );
  //
  //   final totalMLOD = provider.OverallattendanceData.fold<int>(
  //     0,
  //     (sum, item) => sum + (int.tryParse(item.mLODper ?? '0') ?? 0),
  //   );
  //
  //   // Calculate total sessions
  //   final totalSessions = totalPresent + totalAbsent;
  //
  //   // Calculate overall percentage (weighted average)
  //   final overallPercentage =
  //       totalSessions > 0 ? (totalPresent / totalSessions * 100) : 0.0;
  //
  //   // Calculate present percentage
  //   final presentPercentage =
  //       totalSessions > 0 ? (totalPresent / totalSessions) : 0.0;
  //
  //   // Calculate absent percentage
  //   final absentPercentage =
  //       totalSessions > 0 ? (totalAbsent / totalSessions) : 0.0;
  //
  //   log('Present % >>> $presentPercentage');
  //   log('Overall % >>> $overallPercentage');
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Column(
  //       children: [
  //         const Text(
  //           'Attendance Hours',
  //           style: TextStyle(
  //             fontSize: 18,
  //             fontWeight: FontWeight.bold,
  //             color: AppColors.blackColor,
  //           ),
  //         ),
  //         const SizedBox(height: 20),
  //         CircularPercentIndicator(
  //           radius: 60,
  //           lineWidth: 10,
  //           percent: 1.0,
  //           center: Stack(
  //             children: [
  //               // Present Circle (Green)
  //               CircularPercentIndicator(
  //                 radius: 60,
  //                 lineWidth: 10,
  //                 percent: presentPercentage,
  //                 progressColor: Colors.green,
  //                 backgroundColor: Colors.transparent,
  //                 circularStrokeCap: CircularStrokeCap.round,
  //               ),
  //               // Absent Circle (Red)
  //               CircularPercentIndicator(
  //                 radius: 60,
  //                 lineWidth: 10,
  //                 percent: absentPercentage,
  //                 progressColor: Colors.red,
  //                 backgroundColor: Colors.transparent,
  //                 circularStrokeCap: CircularStrokeCap.round,
  //               ),
  //             ],
  //           ),
  //           backgroundColor: Colors.black26,
  //           circularStrokeCap: CircularStrokeCap.round,
  //         ),
  //         const SizedBox(height: 20),
  //         Row(
  //           children: [
  //             Icon(Icons.group, color: AppColors.theme02buttonColor2, size: 20),
  //             const SizedBox(width: 10),
  //             Text(
  //               'Total: ${totalPresent + totalAbsent}',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.primaryColor2,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 5),
  //         Row(
  //           children: [
  //             Icon(Icons.how_to_reg,
  //                 color: AppColors.theme02buttonColor2, size: 20),
  //             const SizedBox(width: 10),
  //             Text(
  //               'Present: $totalPresent',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.green,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 5),
  //         Row(
  //           children: [
  //             Icon(Icons.person_off,
  //                 color: AppColors.theme02buttonColor2, size: 20),
  //             const SizedBox(width: 10),
  //             Text(
  //               'Absent: $totalAbsent',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.red,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 5),
  //         Row(
  //           children: [
  //             Icon(Icons.percent,
  //                 color: AppColors.theme02buttonColor2, size: 20),
  //             const SizedBox(width: 10),
  //             Text(
  //               'Overall % : ${overallPercentage.toStringAsFixed(2)}%',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.primaryColor2,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 5),
  //         Row(
  //           children: [
  //             Icon(Icons.percent,
  //                 color: AppColors.theme02buttonColor2, size: 20),
  //             const SizedBox(width: 10),
  //             Text(
  //               'Present % : ${(overallPercentage * 100).toStringAsFixed(2)}%',
  //               style: const TextStyle(
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.bold,
  //                 color: AppColors.primaryColor2,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget cardDesignAttendanceHrs() {
    final provider = ref.watch(DhasboardoverallattendanceProvider);

    if (provider.DhasboardOverallattendanceData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    final present = int.tryParse(
            provider.DhasboardOverallattendanceData.first.totalpresenthours ??
                '0') ??
        0;
    final absent = int.tryParse(
            provider.DhasboardOverallattendanceData.first.absentcnt ?? '0') ??
        0;
    final ml = int.tryParse(
            provider.DhasboardOverallattendanceData.first.mlcnt ?? '0') ??
        0;
    final mlod = int.tryParse(
            provider.DhasboardOverallattendanceData.first.mlper ?? '0') ??
        0.0;
    final absentper = double.tryParse(
            provider.DhasboardOverallattendanceData.first.absentper ?? '0') ??
        0.0;

    final totalSessions = present + absent;
    final overallPercentage =
        totalSessions > 0 ? (present / totalSessions * 100) : 0.0;
    final presentPercentage =
        totalSessions > 0 ? (present / totalSessions) : 0.0;
    final absentPercentage = totalSessions > 0 ? (absent / totalSessions) : 0.0;

    log('Present % >>> $presentPercentage');
    log('Overall % >>> $overallPercentage');
    log('Absent % >>> $absentper');

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Attendance Hours',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 20),
          CircularPercentIndicator(
            radius: 60,
            lineWidth: 10,
            percent: 1.0,
            center: Stack(
              children: [
                CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 10,
                  percent: presentPercentage,
                  progressColor: Colors.green,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                CircularPercentIndicator(
                  radius: 60,
                  lineWidth: 10,
                  percent: absentPercentage,
                  progressColor: Colors.red,
                  backgroundColor: Colors.transparent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
            backgroundColor: Colors.black26,
            circularStrokeCap: CircularStrokeCap.round,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.group, color: AppColors.theme02buttonColor2, size: 20),
              const SizedBox(width: 10),
              Text(
                'Total: $totalSessions',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.how_to_reg,
                  color: AppColors.theme02buttonColor2, size: 20),
              const SizedBox(width: 10),
              Text(
                'Present: $present',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.person_off,
                  color: AppColors.theme02buttonColor2, size: 20),
              const SizedBox(width: 10),
              Text(
                'Absent: $absent',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.percent,
                  color: AppColors.theme02buttonColor2, size: 20),
              const SizedBox(width: 10),
              Text(
                'Overall % : ${overallPercentage.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.percent,
                  color: AppColors.theme02buttonColor2, size: 20),
              const SizedBox(width: 10),
              Text(
                'Absent % : ${absentper.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.percent,
                  color: AppColors.theme02buttonColor2, size: 20),
              const SizedBox(width: 10),
              Text(
                'Mlod % : ${mlod.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
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
