import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/circular_progress_indicators.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/attendance_pages/riverpod/attendance_state.dart';
import 'package:sample/home/main_pages/academics/overall_attendance_page/riverpod/overall_attendance_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07AttendancePage extends ConsumerStatefulWidget {
  const Theme07AttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07AttendancePageState();
}

class _Theme07AttendancePageState extends ConsumerState<Theme07AttendancePage> {
  final ScrollController _listController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(overallattendanceProvider.notifier).getSubjectWiseOverallAttendanceDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final provider = ref.watch(attendanceProvider);
    final provider = ref.watch(overallattendanceProvider);

    ref.listen(attendanceProvider, (previous, next) {
      if (next is AttendanceStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
    });

    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final cardColor = themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100;

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
          'ATTENDANCE',
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
                    await ref.read(attendanceProvider.notifier).getAttendanceDetails(
                          ref.read(
                            encryptionProvider.notifier,
                          ),
                        );
                    await ref.read(attendanceProvider.notifier).getHiveAttendanceDetails('');
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
        child: Column(
          children: [
            if (provider is OverallAttendanceStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              )
            else if (provider.OverallattendanceData.isEmpty && provider is! OverallAttendanceStateLoading)
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
            if (provider.OverallattendanceData.isNotEmpty) const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView.builder(
                itemCount: provider.OverallattendanceData.length,
                controller: _listController,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cardDesign2(index, cardColor, themeProvider);
                },
              ),
            ),
          ],
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign1(int index, Color cardColor, ThemeProvider themeProvider) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(overallattendanceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: width * .8,
                child: Text(
                  '${provider.OverallattendanceData[index].subjectdesc.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].subjectdesc}'} ${provider.OverallattendanceData[index].subjectcode.toString().isEmpty ? '( - )' : '( ${provider.OverallattendanceData[index].subjectcode} )'}',
                  style: TextStyles.fontStyle10.copyWith(
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textCard(
                    cardColor: Theme.of(context).colorScheme.surface,
                    text:
                        'Total\n${provider.OverallattendanceData[index].total.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].total}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textCard(
                    cardColor: Theme.of(context).colorScheme.surface,
                    text:
                        'Overall %\n${provider.OverallattendanceData[index].overallpercent.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].overallpercent}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textCard(
                    cardColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 67, 175, 54) : Colors.green,
                    text:
                        'Present\n${provider.OverallattendanceData[index].present.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].present}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textCard(
                    cardColor: themeProvider.isDarkMode ? Colors.teal : const Color.fromARGB(255, 0, 170, 156),
                    text:
                        'ML\n${provider.OverallattendanceData[index].ml.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].ml}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textCard(
                    cardColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 175, 67, 54) : Colors.red,
                    text:
                        'Absent\n${provider.OverallattendanceData[index].absent.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].absent}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textCard(
                    cardColor: themeProvider.isDarkMode ? Colors.blueGrey : const Color.fromARGB(255, 116, 145, 159),
                    text:
                        'ML OD\n${provider.OverallattendanceData[index].mLODper.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].mLODper}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesign2(int index, Color cardColor, ThemeProvider themeProvider) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(overallattendanceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: width * .8,
                child: Text(
                  '${provider.OverallattendanceData[index].subjectdesc.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].subjectdesc}'}\n${provider.OverallattendanceData[index].subjectcode.toString().isEmpty ? '( - )' : '( ${provider.OverallattendanceData[index].subjectcode} )'}',
                  textAlign: TextAlign.center,
                  style: TextStyles.fontStyle10.copyWith(
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textCard(
                    cardColor: Theme.of(context).colorScheme.surface,
                    text:
                        'Total\n${provider.OverallattendanceData[index].total.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].total}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textCard(
                    cardColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 67, 200, 54) : Colors.green,
                    text:
                        'Present\n${provider.OverallattendanceData[index].present.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].present}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textCard(
                    cardColor: themeProvider.isDarkMode ? const Color.fromARGB(255, 200, 67, 54) : Colors.red,
                    text:
                        'Absent\n${provider.OverallattendanceData[index].absent.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].absent}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textCard(
                    cardColor: Theme.of(context).colorScheme.surface,
                    text:
                        'Overall %\n${provider.OverallattendanceData[index].overallpercent.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].overallpercent}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textCard(
                    cardColor: themeProvider.isDarkMode ? Colors.teal : const Color.fromARGB(255, 0, 170, 156),
                    text:
                        'ML\n${provider.OverallattendanceData[index].ml.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].ml}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  textCard(
                    cardColor: themeProvider.isDarkMode ? Colors.blueGrey : const Color.fromARGB(255, 116, 145, 159),
                    text:
                        'ML OD\n${provider.OverallattendanceData[index].mLODper.toString().isEmpty ? '-' : '${provider.OverallattendanceData[index].mLODper}'}',
                    textColor: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textCard({required Color? cardColor, required String text, required Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 90,
        height: 50,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
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
