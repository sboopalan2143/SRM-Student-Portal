import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/circular_progress_indicators.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/loading_wrapper.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07HourAttendancePage extends ConsumerStatefulWidget {
  const Theme07HourAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07HourAttendancePageState();
}

class _Theme07HourAttendancePageState extends ConsumerState<Theme07HourAttendancePage> {
  final ScrollController _listController = ScrollController();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hourwiseProvider.notifier).getHiveHourwise('');
    });
  }

  Map<String, List<dynamic>> groupByMonthAndYear(List<dynamic> data) {
    final Map<String, List<dynamic>> groupedData = {};
    for (var item in data) {
      final date = '${item.attendancedate!.split('#')[0]}';
      final String year = date.split('-')[1]; // Extract year
      final String month = date.split('-')[2]; // Extract month
      final String key = '$year-$month'; // Combine year and month
      if (!groupedData.containsKey(key)) {
        groupedData[key] = [];
      }
      groupedData[key]!.add(item);
    }
    return groupedData;
  }

//   // Function to group attendance data by month
//   Map<String, List<dynamic>> groupByMonth(List<dynamic> data) {
//     final Map<String, List<dynamic>> groupedData = {};
//     for (var item in data) {
//       final date = '${item.attendancedate!.split('#')[0]}';
//       final String month = date.split('-')[1]; // Extract month from date
//       if (!groupedData.containsKey(month)) {
//         groupedData[month] = [];
//       }
//       groupedData[month]!.add(item);
//     }
//     return groupedData;
//   }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(hourwiseProvider);
    ref.listen(hourwiseProvider, (previous, next) {
      if (next is HourwiseError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
    });

    // Group data by month
    final groupedData = groupByMonthAndYear(provider.listHourWiseHiveData);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          title: Text(
            'HOURWISE ATTENDANCE',
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
                      await ref.read(hourwiseProvider.notifier).gethourwiseDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref.read(hourwiseProvider.notifier).getHiveHourwise('');
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (provider is HourwiseStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              )
            else if (provider.listHourWiseHiveData.isEmpty && provider is! HourwiseStateLoading)
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
            if (provider.listHourWiseHiveData.isNotEmpty) const SizedBox(height: 5),
            // Display month-wise data
            ...groupedData.entries.map((entry) {
              String month = entry.key;
              List<dynamic> monthData = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary, // Change the color as needed
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        'Month: $month',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white, // Adjust for better contrast
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * .24,
                        child: Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: width * .1,
                        child: Text(
                          '1',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .1,
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .1,
                        child: Text(
                          '3',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .1,
                        child: Text(
                          '5',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .1,
                        child: Text(
                          '6',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * .1,
                        child: Text(
                          '7',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: monthData.length,
                    controller: _listController,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: LoadingWrapper(
                        isLoading: provider is HourwiseStateLoading,
                        child: Container(
                          decoration: BoxDecoration(
                            color: pro.Provider.of<ThemeProvider>(context).isDarkMode
                                ? Colors.grey.shade900
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * .24,
                                  child: Text(
                                    '${monthData[index].attendancedate!.split('#')[0]}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).colorScheme.inverseSurface,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * .1,
                                      child: Text(
                                        '${monthData[index].h1}' == 'null' ? '-' : '${monthData[index].h1}',
                                        style: TextStyle(
                                          fontSize:
                                              (monthData[index].h1 == 'ML' || monthData[index].h1 == 'OD') ? 12 : 14,
                                          color: monthData[index].h1 == 'A'
                                              ? Colors.red
                                              : monthData[index].h1 == 'P'
                                                  ? Colors.green
                                                  : Colors.blueGrey,
                                          fontWeight: (monthData[index].h1 == 'ML' || monthData[index].h1 == 'OD')
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .1,
                                      child: Text(
                                        '${monthData[index].h2}' == 'null' ? '-' : '${monthData[index].h2}',
                                        style: TextStyle(
                                          fontSize:
                                              (monthData[index].h2 == 'ML' || monthData[index].h2 == 'OD') ? 12 : 14,
                                          color: monthData[index].h2 == 'A'
                                              ? Colors.red
                                              : monthData[index].h2 == 'P'
                                                  ? Colors.green
                                                  : Colors.blueGrey,
                                          fontWeight: (monthData[index].h2 == 'ML' || monthData[index].h2 == 'OD')
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .1,
                                      child: Text(
                                        '${monthData[index].h3}' == 'null' ? '-' : '${monthData[index].h3}',
                                        style: TextStyle(
                                          fontSize:
                                              (monthData[index].h3 == 'ML' || monthData[index].h3 == 'OD') ? 12 : 14,
                                          color: monthData[index].h3 == 'A'
                                              ? Colors.red
                                              : monthData[index].h3 == 'P'
                                                  ? Colors.green
                                                  : Colors.blueGrey,
                                          fontWeight: (monthData[index].h3 == 'ML' || monthData[index].h3 == 'OD')
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .1,
                                      child: Text(
                                        '${monthData[index].h5}' == 'null' ? '-' : '${monthData[index].h5}',
                                        style: TextStyle(
                                          fontSize:
                                              (monthData[index].h5 == 'ML' || monthData[index].h5 == 'OD') ? 12 : 14,
                                          color: monthData[index].h5 == 'A'
                                              ? Colors.red
                                              : monthData[index].h5 == 'P'
                                                  ? Colors.green
                                                  : Colors.blueGrey,
                                          fontWeight: (monthData[index].h5 == 'ML' || monthData[index].h5 == 'OD')
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .1,
                                      child: Text(
                                        '${monthData[index].h6}' == 'null' ? '-' : '${monthData[index].h6}',
                                        style: TextStyle(
                                          fontSize:
                                              (monthData[index].h6 == 'ML' || monthData[index].h6 == 'OD') ? 12 : 14,
                                          color: monthData[index].h6 == 'A'
                                              ? Colors.red
                                              : monthData[index].h6 == 'P'
                                                  ? Colors.green
                                                  : Colors.blueGrey,
                                          fontWeight: (monthData[index].h6 == 'ML' || monthData[index].h6 == 'OD')
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .1,
                                      child: Text(
                                        '${monthData[index].h7}' == 'null' ? '-' : '${monthData[index].h7}',
                                        style: TextStyle(
                                          fontSize:
                                              (monthData[index].h7 == 'ML' || monthData[index].h7 == 'OD') ? 12 : 14,
                                          color: monthData[index].h7 == 'A'
                                              ? Colors.red
                                              : monthData[index].h7 == 'P'
                                                  ? Colors.green
                                                  : Colors.blueGrey,
                                          fontWeight: (monthData[index].h7 == 'ML' || monthData[index].h7 == 'OD')
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          ],
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
