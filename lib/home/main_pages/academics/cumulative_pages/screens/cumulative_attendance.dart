import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';
import 'package:sample/home/main_pages/academics/screens/academics.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class CumulativeAttendancePage extends ConsumerStatefulWidget {
  const CumulativeAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CumulativeAttendancePageState();
}

class _CumulativeAttendancePageState
    extends ConsumerState<CumulativeAttendancePage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(cummulativeAttendanceProvider.notifier)
          .getCummulativeAttendanceDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(cummulativeAttendanceProvider);
    ref.listen(cummulativeAttendanceProvider, (previous, next) {
      if (next is CummulativeAttendanceStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is CummulativeAttendanceStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                RouteDesign(
                  route: const AcademicsPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text(
            'CUMMULATIVE ATTENDANCE',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 35,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          //   child: SizedBox(
          //     height: 40,
          //     child: TextField(
          //       // controller: _searchIndividual,
          //       // onChanged: (value) => readProvider.getOrderHistoryList(
          //       //   1,
          //       //   _searchIndividual.text,
          //       // ),
          //       keyboardType: TextInputType.text,
          //       style: TextStyles.fontStyle14,
          //       decoration: InputDecoration(
          //         hintText: 'Search...',
          //         hintStyle: TextStyles.smallLightAshColorFontStyle,
          //         filled: true,
          //         fillColor: AppColors.whiteColor,
          //         contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          //         enabledBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(7),
          //           borderSide: const BorderSide(color: AppColors.grey2),
          //         ),
          //         focusedBorder: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(7),
          //           borderSide: const BorderSide(color: AppColors.grey2),
          //         ),
          //         prefixIcon: const Icon(
          //           Icons.search,
          //           color: AppColors.grey2,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          if (provider is CummulativeAttendanceStateLoading)
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child:
                    CircularProgressIndicators.primaryColorProgressIndication,
              ),
            )
          else if (provider.cummulativeAttendanceData.isEmpty &&
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
          if (provider.cummulativeAttendanceData.isNotEmpty)
            const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListView.builder(
              itemCount: provider.cummulativeAttendanceData.length,
              controller: _listController,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return cardDesign(index);
              },
            ),
          ),
        ],
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(cummulativeAttendanceProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        // elevation: 0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              SizedBox(
                width: width / 2 - 80,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Month/Year',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Present',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Absent',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'OD Present',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'OD Absent',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Medical',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '''${provider.cummulativeAttendanceData[index].attendancemonthyear}''',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeAttendanceData[index].present}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeAttendanceData[index].absent}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeAttendanceData[index].odpresent}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeAttendanceData[index].odabsent}',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '${provider.cummulativeAttendanceData[index].medical}',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
            ],
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
