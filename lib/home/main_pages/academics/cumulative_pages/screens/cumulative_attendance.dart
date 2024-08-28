import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/academics/cumulative_pages/riverpod/cumulative_attendance_state.dart';

class CumulativeAttendancePage extends ConsumerStatefulWidget {
  const CumulativeAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CumulativeAttendancePageState();
}

class _CumulativeAttendancePageState
    extends ConsumerState<CumulativeAttendancePage> {
  final ScrollController _listController = ScrollController();
  List<String> name = ['Select Year/Sem', 'one', 'two', 'three'];
  String selectedValue = 'Select Year/Sem';

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(cummulativeAttendanceProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
          child: SizedBox(
            height: 40,
            child: TextField(
              // controller: _searchIndividual,
              // onChanged: (value) => readProvider.getOrderHistoryList(
              //   1,
              //   _searchIndividual.text,
              // ),
              keyboardType: TextInputType.text,
              style: TextStyles.fontStyle14,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyles.smallLightAshColorFontStyle,
                filled: true,
                fillColor: AppColors.whiteColor,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: AppColors.grey2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: AppColors.grey2),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.grey2,
                ),
              ),
            ),
          ),
        ),
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
                width: width / 2 - 100,
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
                      '${provider.cummulativeAttendanceData[index].attendancemonthyear}',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
