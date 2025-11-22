import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme/theme_provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Theme07CalendarPage extends ConsumerStatefulWidget {
  const Theme07CalendarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07CalendarPageState();
}

class _Theme07CalendarPageState extends ConsumerState<Theme07CalendarPage> {
  final ScrollController _listController = ScrollController();
  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  String _selectedPeriod = 'Current Month';
  DateTime? _customStartDate;
  DateTime? _customEndDate;
  final List<String> _periodOptions = ['Current Month', 'Next 3 Months', 'Next 6 Months', 'Custom'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(calendarProvider.notifier).getCalendarDetails(ref.read(encryptionProvider.notifier));
        await ref.read(calendarProvider.notifier).getHiveCalendar('');
      },
    );
  }

  List<dynamic> _filterCalendarData(List<dynamic> calendarData) {
    final now = DateTime.now();
    final dateFormat = DateFormat('dd-MM-yyyy');

    return calendarData.where((item) {
      try {
        final itemDate = dateFormat.parse(item.date as String);

        if (_selectedPeriod == 'Current Month') {
          return itemDate.year == now.year && itemDate.month == now.month;
        } else if (_selectedPeriod == 'Next 3 Months') {
          final startDate = DateTime(now.year, now.month);
          final endDate = DateTime(now.year, now.month + 3, 0);
          return itemDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
              itemDate.isBefore(endDate.add(const Duration(days: 1)));
        } else if (_selectedPeriod == 'Next 6 Months') {
          final startDate = DateTime(now.year, now.month);
          final endDate = DateTime(now.year, now.month + 6, 0);
          return itemDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
              itemDate.isBefore(endDate.add(const Duration(days: 1)));
        } else if (_selectedPeriod == 'Custom' && _customStartDate != null && _customEndDate != null) {
          return itemDate.isAfter(_customStartDate!.subtract(const Duration(days: 1))) &&
              itemDate.isBefore(_customEndDate!.add(const Duration(days: 1)));
        }
        return true;
      } catch (e) {
        return false;
      }
    }).toList();
  }

  Future<void> _showCustomDateRangePicker(BuildContext context) async {
    DateTimeRange? selectedRange;
    final themeProvider = pro.Provider.of<ThemeProvider>(context, listen: false);

    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Custom Calendar Date Selection',
                  style: TextStyles.fontStyle4.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
                const SizedBox(height: 16),
                SfDateRangePicker(
                  backgroundColor: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                  selectionMode: DateRangePickerSelectionMode.range,
                  minDate: DateTime.now().subtract(const Duration(days: 365)),
                  maxDate: DateTime.now().add(const Duration(days: 365)),
                  initialSelectedRange: PickerDateRange(
                    _customStartDate ?? DateTime.now(),
                    _customEndDate ?? DateTime.now(),
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyles.fontStyle4.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  selectionTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  rangeSelectionColor: Colors.blue.withAlpha(200),
                  startRangeSelectionColor: Colors.blue.shade800,
                  endRangeSelectionColor: Colors.blue.shade200,
                  todayHighlightColor: Colors.orange,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is PickerDateRange) {
                      final pickerRange = args.value as PickerDateRange;
                      if (pickerRange.startDate != null) {
                        selectedRange = DateTimeRange(
                          start: pickerRange.startDate!,
                          end: pickerRange.endDate ?? pickerRange.startDate!,
                        );
                      }
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyles.fontStyle10.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (selectedRange != null) {
                          Navigator.pop(context, selectedRange);
                        }
                      },
                      child: Text(
                        'OK',
                        style: TextStyles.fontStyle10.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) {
      if (value != null && value is DateTimeRange) {
        setState(() {
          _customStartDate = value.start;
          _customEndDate = value.end;
          _selectedPeriod = 'Custom';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(calendarProvider);
    final filteredData = _filterCalendarData(provider.calendarHiveData);

    ref.listen(examDetailsProvider, (previous, next) {
      if (next is ExamDetailsError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is ExamDetailsStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

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
              color: Colors.white,
            ),
          ),
          title: Text(
            'CALENDAR DETAILS',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: false,
          actions: [
            // refresh Button
            GestureDetector(
              onTap: () async {
                await ref.read(calendarProvider.notifier).getCalendarDetails(
                      ref.read(encryptionProvider.notifier),
                    );
                await ref.read(calendarProvider.notifier).getHiveCalendar('');
              },
              child: const Icon(
                Icons.refresh,
                color: AppColors.whiteColor,
              ),
            ),

            // PopUp Menu Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PopupMenuButton<String>(
                initialValue: _selectedPeriod,
                onSelected: (String newValue) {
                  if (newValue == 'Custom') {
                    _showCustomDateRangePicker(context);
                  } else {
                    setState(() {
                      _selectedPeriod = newValue;
                    });
                  }
                },
                itemBuilder: (BuildContext context) => _periodOptions
                    .map(
                      (String value) => PopupMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyles.fontStyle4.copyWith(
                            fontSize: 14,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                color: Theme.of(context).colorScheme.inverseSurface.withAlpha(40), // Background color of popup menu
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                offset: const Offset(0, 40),
                child: const Icon(
                  Icons.more_vert_rounded,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (provider is CalendarStateLoading) ...[
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              ),
            ] else if (filteredData.isEmpty && provider is! CalendarStateLoading) ...[
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    'No calendar data available for selected period',
                    style: TextStyles.fontStyle10,
                  ),
                ),
              ),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  itemCount: filteredData.length,
                  controller: _listController,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return cardDesign(index, filteredData);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget cardDesign(int index, List<dynamic> filteredData) {
    final width = MediaQuery.of(context).size.width;
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            decoration: BoxDecoration(
              color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Container(
                    width: width * 0.25,
                    constraints: const BoxConstraints(minHeight: 80),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.inverseSurface.withAlpha(20),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${filteredData[index].dayorder ?? '-'}',
                          style: TextStyles.fontStyle10.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${filteredData[index].date ?? '-'}',
                          style: TextStyles.fontStyle10.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Semester : ${filteredData[index].semester ?? '-'}',
                          style: TextStyles.fontStyle10.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Daystatus : ${filteredData[index].daystatus ?? '-'}',
                          style: TextStyles.fontStyle10.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Remarks : ${filteredData[index].remarks ?? '-'}',
                          style: TextStyles.fontStyle10.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(160),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Weekdayno : ${filteredData[index].weekdayno ?? '-'}',
                          style: TextStyles.fontStyle10.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(160),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
