import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/dhasboard_overall_attendance_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/hour_wise_atttendance.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/sub_wise_attendance.dart';

class Theme07AttendanceHomePage extends ConsumerStatefulWidget {
  const Theme07AttendanceHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07AttendanceHomePageState();
}

class _Theme07AttendanceHomePageState extends ConsumerState<Theme07AttendanceHomePage> {
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

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ref..watch(hostelProvider)
    ..listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.theme07secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme07primaryColor,
                  AppColors.theme07primaryColor,
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
            'ATTENDANCE',
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
                  color: Colors.grey.withOpacity( 0.1),
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
             Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 120,
                                     width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                                    onPressed: () {
                                      Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme07HourAttendancePage(),
                  ),
                );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                       
                                        SizedBox(
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Hour Attendance',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.06,
                                ),
                                SizedBox(
                                  height: 120,
                                     width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                                    onPressed: () {
                                      Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme07AttendancePage(),
                  ),
                );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                      
                                        SizedBox(
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Sub Wise Attendance',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
       
        ],
      ),
    );
  }
  Widget cardDesignAttendanceHrs() {
    final provider = ref.watch(DhasboardoverallattendanceProvider);

    if (provider.DhasboardOverallattendanceData.isEmpty) {
      return Center(child: CircularProgressIndicators
        .theme07primaryColorProgressIndication,);
    }

    final present = int.tryParse(
            provider.DhasboardOverallattendanceData.first.totalpresenthours ??
                '0',) ??
        0;
    final absent = int.tryParse(
            provider.DhasboardOverallattendanceData.first.absentcnt ?? '0',) ??
        0;
    final mlod = int.tryParse(
            provider.DhasboardOverallattendanceData.first.mlper ?? '0',) ??
        0.0;
    final absentper = double.tryParse(
            provider.DhasboardOverallattendanceData.first.absentper ?? '0',) ??
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
            percent: 1,
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
             const Icon(Icons.group, color: AppColors.primaryColor2,size: 20),
              const SizedBox(width: 10),
              Text(
                'Total: $totalSessions',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
            const  Icon(Icons.how_to_reg,
                  color: Colors.green,size: 20,),
              const SizedBox(width: 10),
              Text(
                'Present: $present',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
            const   Icon(Icons.person_off,
                  color:  Colors.red, size: 20,),
              const SizedBox(width: 10),
              Text(
                'Absent: $absent',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
            const  Icon(Icons.percent,
                  color:AppColors.primaryColor2, size: 20,),
              const SizedBox(width: 10),
              Text(
                'Overall % : ${overallPercentage.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
            const  Icon(Icons.percent,
                  color: Colors.red, size: 20,),
              const SizedBox(width: 10),
              Text(
                'Absent % : ${absentper.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
            const  Icon(Icons.percent,
                  color: Colors.red, size: 20,),
              const SizedBox(width: 10),
              Text(
                'Mlod % : ${mlod.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 12,
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
