import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class TimeTablePage extends ConsumerStatefulWidget {
  const TimeTablePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends ConsumerState<TimeTablePage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width / 2 - 100,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Academic Year',
                                style: TextStyles.fontStyle10,
                              ),
                              Text(
                                'Class',
                                style: TextStyles.fontStyle10,
                              ),
                              Text(
                                'Semester',
                                style: TextStyles.fontStyle10,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
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
                          ],
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 2 - 60,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '2023 - 2024',
                                style: TextStyles.fontStyle10,
                              ),
                              Text(
                                'B.Tech - CSE, B Section',
                                style: TextStyles.fontStyle10,
                              ),
                              Text(
                                '3rd Semester',
                                style: TextStyles.fontStyle10,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              Container(
                height: 45,
                width: width - 20,
                decoration: BoxDecoration(
                  color: AppColors.grey1,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: AppColors.grey1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: navContainerDesign(
                          text: 'Mon',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: navContainerDesign(
                          text: 'Tue',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: navContainerDesign(
                          text: 'Wed',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: navContainerDesign(
                          text: 'Thur',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: navContainerDesign(
                          text: 'Fri',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
            itemCount: 20,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: width / 2 - 70,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '10:00 AM to 11:00 AM',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 20,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'C Programming Language',
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

  Widget navContainerDesign({
    required String text,
  }) {
    final provider = ref.watch(feesProvider);
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // side: BorderSide(
          //   color: AppColors.whiteColor,
          // ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: text == provider.navFeesString
              ? AppColors.primaryColor
              : AppColors.grey1,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          ref.read(feesProvider.notifier).setFeesNavString(text);
        },
        child: text == provider.navFeesString
            ? Text(
                text,
                style: width > 400
                    ? TextStyles.fontStyle11
                    : TextStyles.fontStyle19,
              )
            : Text(
                text,
                style: width > 400
                    ? TextStyles.fontStyle11
                    : TextStyles.fontStyle19,
              ),
      ),
    );
  }
}
