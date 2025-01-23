import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/calendar/riverpod/calendar_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01CalendarPage extends ConsumerStatefulWidget {
  const Theme01CalendarPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01CalendarPageState();
}

class _Theme01CalendarPageState extends ConsumerState<Theme01CalendarPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(calendarProvider.notifier)
            .getCalendarDetails(ref.read(encryptionProvider.notifier));
        await ref.read(calendarProvider.notifier).getHiveCalendar('');
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
            .read(calendarProvider.notifier)
            .getCalendarDetails(ref.read(encryptionProvider.notifier));
        await ref.read(calendarProvider.notifier).getHiveCalendar('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(calendarProvider);
    ref.listen(examDetailsProvider, (previous, next) {
      if (next is ExamDetailsError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is ExamDetailsStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.theme01primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'CALENDAR DETAILS',
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
                              .read(calendarProvider.notifier)
                              .getCalendarDetails(
                                  ref.read(encryptionProvider.notifier));
                          await ref
                              .read(calendarProvider.notifier)
                              .getHiveCalendar('');
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
        onRefresh: _handleRefresh,
        color: AppColors.theme01primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (provider is CalendarStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .theme01primaryColorProgressIndication,
                  ),
                )
              else if (provider.calendarHiveData.isEmpty &&
                  provider is! CalendarStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    // const Center(
                    //   child: Text(
                    //     'No List Added',
                    //     style: TextStyles.fontStyle1,
                    //   ),
                    // ),
                  ],
                ),
              if (provider.calendarHiveData.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ListView.builder(
                    itemCount: provider.calendarHiveData.length,
                    controller: _listController,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return cardDesign(index);
                    },
                  ),
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
    final provider = ref.watch(calendarProvider);

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
                      'Date :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.calendarHiveData[index].date}',
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
                  'Day :',
                  '${provider.calendarHiveData[index].day}',
                  width,
                ),
                _buildRow(
                  'Day Order',
                  '${provider.calendarHiveData[index].dayorder}',
                  width,
                ),
                _buildRow(
                  'Day Status',
                  '${provider.calendarHiveData[index].daystatus}',
                  width,
                ),
                _buildRow(
                  'Holiday Status :',
                  '${provider.calendarHiveData[index].holidaystatus}',
                  width,
                ),
                _buildRow(
                  'Remarks',
                  '${provider.calendarHiveData[index].remarks}',
                  width,
                ),
                _buildRow(
                  'Semester',
                  '${provider.calendarHiveData[index].semester}',
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
