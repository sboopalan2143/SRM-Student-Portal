import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class HourAttendancePage extends ConsumerStatefulWidget {
  const HourAttendancePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HourAttendancePageState();
}

class _HourAttendancePageState extends ConsumerState<HourAttendancePage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(hourwiseProvider);
    log(
      'front ednd log >> ${provider.listHourWiseData.length}',
    );

    return Column(
      children: [
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 20),
        //   child:
        //   Container(
        //     width: double.infinity,
        //     height: 50,
        //     decoration: const BoxDecoration(
        //       color: AppColors.blueColor,
        //       borderRadius: BorderRadius.all(Radius.circular(31)),
        //     ),
        //     child:
        //      Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 30),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Image.asset(
        //             'assets/images/leftArrow.png',
        //             height: 20,
        //             fit: BoxFit.cover,
        //           ),
        //           const Text('May, 2024', style: TextStyles.alertContentStyle),
        //           Image.asset(
        //             'assets/images/rightArrow.png',
        //             height: 20,
        //             fit: BoxFit.cover,
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(
              //   width: width / 7,
              //   child: const Text(
              //     'Date',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              // const SizedBox(width: 5),
              // SizedBox(
              //   width: width / 11.5,
              //   child: const Text(
              //     '1',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              // const SizedBox(width: 5),
              // SizedBox(
              //   width: width / 11.5,
              //   child: const Text(
              //     '2',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              // const SizedBox(width: 5),
              // SizedBox(
              //   width: width / 11.5,
              //   child: const Text(
              //     '3',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              // const SizedBox(width: 5),
              // SizedBox(
              //   width: width / 11.5,
              //   child: const Text(
              //     '4',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              // const SizedBox(width: 5),
              // SizedBox(
              //   width: width / 11,
              //   child: const Text(
              //     '5',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              // const SizedBox(width: 5),
              // SizedBox(
              //   width: width / 11,
              //   child: const Text(
              //     '6',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              // const SizedBox(width: 5),
              // SizedBox(
              //   width: width / 11,
              //   child: const Text(
              //     '7',
              //     style: TextStyles.fontStyle10,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width / 6,
                    child: const Text(
                      'Date',
                      style: TextStyles.fontStyle16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: width / 11.5,
                    child: const Text(
                      '-',
                      style: TextStyles.fontStyle18,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 11.5,
                    child: const Text(
                      '1',
                      style: TextStyles.fontStyle16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 11.5,
                    child: const Text(
                      '2',
                      style: TextStyles.fontStyle16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 11.5,
                    child: const Text(
                      '3',
                      style: TextStyles.fontStyle16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 11,
                    child: const Text(
                      '4',
                      style: TextStyles.fontStyle16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 11,
                    child: const Text(
                      '5',
                      style: TextStyles.fontStyle16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 11,
                    child: const Text(
                      '6',
                      style: TextStyles.fontStyle16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: provider.listHourWiseData.length,
          controller: _listController,
          shrinkWrap: true,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: width / 6,
                      child: Text(
                        '${provider.listHourWiseData[index].attendancedate}',
                        style: TextStyles.fontStyle16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: width / 11.5,
                      child: const Text(
                        '-',
                        style: TextStyles.fontStyle18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 11.5,
                      child: Text(
                        '${provider.listHourWiseData[index].h1}',
                        style: TextStyles.fontStyle17,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 11.5,
                      child: Text(
                        '${provider.listHourWiseData[index].h2}',
                        style: TextStyles.fontStyle17,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 11.5,
                      child: Text(
                        '${provider.listHourWiseData[index].h3}',
                        style: TextStyles.fontStyle17,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 11,
                      child: Text(
                        '${provider.listHourWiseData[index].h5}',
                        style: TextStyles.fontStyle18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 11,
                      child: Text(
                        '${provider.listHourWiseData[index].h6}',
                        style: TextStyles.fontStyle18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SizedBox(
                      width: width / 11,
                      child: Text(
                        '${provider.listHourWiseData[index].h7}',
                        style: TextStyles.fontStyle18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;
  //   final provider = ref.watch(hourwiseProvider);
  //   log(
  //     'front ednd log >> ${provider.listHourWiseData.length}',
  //   );
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: const BorderRadius.all(Radius.circular(20)),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: const Offset(0, 3), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               width: width / 6,
  //               child: Text(
  //                 'kabir',
  //                 // '${provider.listHourWiseData[index].h1}',
  //                 style: TextStyles.fontStyle16,
  //               ),
  //             ),
  //             const SizedBox(width: 10),
  //             // SizedBox(
  //             //   width: width / 11.5,
  //             //   child: const Text(
  //             //     '-',
  //             //     style: TextStyles.fontStyle18,
  //             //   ),
  //             // ),
  //             // const SizedBox(width: 5),
  //             // SizedBox(
  //             //   width: width / 11.5,
  //             //   child: const Text(
  //             //     'P',
  //             //     style: TextStyles.fontStyle17,
  //             //   ),
  //             // ),
  //             // const SizedBox(width: 5),
  //             // SizedBox(
  //             //   width: width / 11.5,
  //             //   child: const Text(
  //             //     'P',
  //             //     style: TextStyles.fontStyle17,
  //             //   ),
  //             // ),
  //             // const SizedBox(width: 5),
  //             // SizedBox(
  //             //   width: width / 11.5,
  //             //   child: const Text(
  //             //     'P',
  //             //     style: TextStyles.fontStyle17,
  //             //   ),
  //             // ),
  //             // const SizedBox(width: 5),
  //             // SizedBox(
  //             //   width: width / 11,
  //             //   child: const Text(
  //             //     'A',
  //             //     style: TextStyles.fontStyle18,
  //             //   ),
  //             // ),
  //             // const SizedBox(width: 5),
  //             // SizedBox(
  //             //   width: width / 11,
  //             //   child: const Text(
  //             //     'A',
  //             //     style: TextStyles.fontStyle18,
  //             //   ),
  //             // ),
  //             const SizedBox(width: 5),
  //             // SizedBox(
  //             //   width: width / 11,
  //             //   child: const Text(
  //             //     'A',
  //             //     style: TextStyles.fontStyle18,
  //             //   ),
  //             // ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget navContainerDesign({
    required String text,
  }) {
    final provider = ref.watch(feesProvider);
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
                style: TextStyles.fontStyle11,
              )
            : Text(
                text,
                style: TextStyles.fontStyle11,
              ),
      ),
    );
  }
}
