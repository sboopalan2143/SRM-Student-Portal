import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';


class Theme07ExamDetailsPageTheme extends ConsumerStatefulWidget {
  const Theme07ExamDetailsPageTheme({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07ExamDetailsPageThemeState();
}

class _Theme07ExamDetailsPageThemeState
    extends ConsumerState<Theme07ExamDetailsPageTheme> {
  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(examDetailsProvider.notifier).getHiveExamDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(examDetailsProvider);
    ref.listen(examDetailsProvider, (previous, next) {
      if (next is ExamDetailsError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      //  else if (next is ExamDetailsStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
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
            'EXAM DETAILS',
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
                      await ref
                          .read(examDetailsProvider.notifier)
                          .getExamDetailsApi(
                            ref.read(
                              encryptionProvider.notifier,
                            ),
                          );
                      await ref
                          .read(examDetailsProvider.notifier)
                          .getHiveExamDetails('');
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
            if (provider is ExamDetailsStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child:
                      CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              )
            else if (provider.examDetailsHiveData.isEmpty &&
                provider is! ExamDetailsStateLoading)
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  const Center(
                    child: Text(
                      'No List Added Yet!',
                      style: TextStyles.fontStyle6,
                    ),
                  ),
                ],
              ),
            if (provider.examDetailsHiveData.isNotEmpty)
              const SizedBox(height: 5),
           
            SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 8; i >= 1; i--) ...[
                    if (provider.examDetailsHiveData
                        .any((data) => data.semester == '$i')) ...[
                      
                      Theme(
                          data: Theme.of(context).copyWith(
    dividerColor: Colors.transparent, 
  ),
                        child: ExpansionTile(
                          title: Text(
                            'Semester $i',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.theme07primaryColor,
                            ),
                          ),
                          initiallyExpanded: false,
                          backgroundColor: AppColors.theme07secondaryColor,
                          iconColor: AppColors.whiteColor,
                          textColor: AppColors.whiteColor,
                          children: [
                            ...provider.examDetailsHiveData
                                .where((data) => data.semester == '$i')
                                .map((data) {
                              final index =
                                  provider.examDetailsHiveData.indexOf(data);
                              return cardDesign(index);
                            }).toList(),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.grey4,
                      ),
                    ]
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


   Widget cardDesign(int index) {  final width = MediaQuery.of(context).size.width; final provider = ref.watch(examDetailsProvider);
    double.parse(
      provider.examDetailsHiveData[index].internal ?? '0',
    );
    double.parse(
      provider.examDetailsHiveData[index].external ?? '0',
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient:const LinearGradient(
            colors: [
              AppColors.whiteColor,
              AppColors.whiteColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width / 1.5,
                    child: Text(
                      '${provider.examDetailsHiveData[index].subjectdesc}' ==
                              ''
                          ? '-'
                          : '${provider.examDetailsHiveData[index].subjectdesc}',
                      style:const TextStyle(
                        fontSize: 14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                   SizedBox(
                  
                    child: Text(
                      '${provider.examDetailsHiveData[index].result}' ==
                              ''
                          ? '-'
                          : '${provider.examDetailsHiveData[index].result}',
                        
                     style: TextStyle(
    fontSize: 14,
    color: provider.examDetailsHiveData[index].result == 'PASS' 
        ? AppColors.greenColor 
        : AppColors.redColor, 
    fontWeight: FontWeight.bold,
  ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                          child: Icon(
                            Icons.numbers,
                            color: AppColors.grey4,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 2 - 100,
                          child: Text(
                            '${provider.examDetailsHiveData[index].subjectcode}' ==
                                    ''
                                ? '-'
                                : '${provider.examDetailsHiveData[index].subjectcode}',
                             style:const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width / 5,
                    child: Text(
                      '${provider.examDetailsHiveData[index].credit}' == ''
                          ? '-'
                          : 'Credit : ${provider.examDetailsHiveData[index].credit}',
                     style:const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                   SizedBox(
                    width: width / 3,
                    child: Text(
                      '${provider.examDetailsHiveData[index].grade}' == ''
                          ? '-'
                          : 'Grade : ${provider.examDetailsHiveData[index].grade}',
                      style:const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                       
                        SizedBox(
                          width: width / 2 ,
                          child: Text(
                            '${provider.examDetailsHiveData[index].internal}' ==
                                    ''
                                ? '-'
                                : 'Internal : ${provider.examDetailsHiveData[index].internal}',
                            style:const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      '${provider.examDetailsHiveData[index].external}' == ''
                          ? '-'
                          : 'External: ${provider.examDetailsHiveData[index].external}',
                      style:const TextStyle(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  
                ],
              ),
            
            ],
          ),
        ),
      ),
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width; final provider = ref.watch(examDetailsProvider);
  //   double.parse(
  //     provider.examDetailsHiveData[index].internal ?? '0',
  //   );
  //   double.parse(
  //     provider.examDetailsHiveData[index].external ?? '0',
  //   );

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: const BorderRadius.all(Radius.circular(20)),
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: const Offset(0, 3),
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           children: [
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Subject desc',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].subjectdesc}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].subjectdesc}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //              const SizedBox(height: 5),
            
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Sub Code',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].subjectcode}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].subjectcode}',
                     
  //                        style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //              const SizedBox(height: 5),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Semester',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].semester}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].semester}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //              const SizedBox(height: 5),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Grade',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].grade}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].grade}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //                const SizedBox(height: 5),
  //              Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Credit',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].credit}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].credit}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ), const SizedBox(height: 5),
  //              Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Internal',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].internal}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].internal}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),const SizedBox(height: 5),
  //              Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'External',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].external}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].external}',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //            const SizedBox(height: 5),
  //              Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 SizedBox(
  //                   width: width / 2 - 80,
  //                   child: const Text(
  //                     'Result',
  //                     style: TextStyles.fontStyle10,
  //                   ),
  //                 ),
  //                 const Text(
  //                   ':',
  //                   style: TextStyles.fontStyle10,
  //                 ),
  //                 const SizedBox(width: 5),
  //                 SizedBox(
  //                   width: width / 2 - 60,
  //                   child: Text(
  //                     '${provider.examDetailsHiveData[index].result}' == ''
  //                         ? '-'
  //                         : '${provider.examDetailsHiveData[index].result}',
  //          style: TextStyle(
  //                       fontSize: 14,
  //                       fontWeight: FontWeight.bold,
  //                       color: AppColors.theme07primaryColor,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget examCardDesign(int index) {
  //   final provider = ref.watch(examDetailsProvider);
  //   final internal = double.parse(
  //     provider.examDetailsHiveData[index].internal ?? '0',
  //   );
  //   final external = double.parse(
  //     provider.examDetailsHiveData[index].external ?? '0',
  //   );
  //   final internalResult = internal / 100;
  //   final externalResult = external / 100;

  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //     child: Card(
  //       elevation: 4,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           // Header Section
  //           Container(
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: [
  //                   AppColors.theme02primaryColor,
  //                   AppColors.theme02secondaryColor1,
  //                 ],
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //               ),
  //               borderRadius:
  //                   const BorderRadius.vertical(top: Radius.circular(16)),
  //             ),
  //             padding: const EdgeInsets.all(16),
  //             child: Row(
  //               children: [
  //                 SvgPicture.asset(
  //                   'assets/images/examdetailstheme3.svg',
  //                   color: AppColors.theme02buttonColor2,
  //                   height: 40,
  //                 ),
  //                 const SizedBox(width: 12),
  //                 Expanded(
  //                   child: Text(
  //                     provider.examDetailsHiveData[index].subjectdesc!.isEmpty
  //                         ? '-'
  //                         : provider.examDetailsHiveData[index].subjectdesc!,
  //                     style: const TextStyle(
  //                       fontSize: 16,
  //                       color: AppColors.whiteColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),

  //           // Body Section
  //           Padding(
  //             padding: const EdgeInsets.all(16),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Course Code: ${provider.examDetailsHiveData[index].subjectcode ?? '-'}',
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                         color: AppColors.grey4,
  //                       ),
  //                     ),
  //                     Row(
  //                       children: [
  //                         Text(
  //                           'Grade: ${provider.examDetailsHiveData[index].grade ?? '-'}',
  //                           style: const TextStyle(
  //                             fontSize: 14,
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColors.grey4,
  //                           ),
  //                         ),
  //                         const SizedBox(width: 4),
  //                         Icon(
  //                           Icons.grade,
  //                           color: AppColors.theme02buttonColor2,
  //                           size: 18,
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Semester: ${provider.examDetailsHiveData[index].semester ?? '-'}',
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                         color: AppColors.grey4,
  //                       ),
  //                     ),
  //                     Text(
  //                       'Credit: ${provider.examDetailsHiveData[index].credit ?? '-'}',
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                         color: AppColors.grey4,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Text(
  //                       'Result : ${provider.examDetailsHiveData[index].result ?? '-'}',
  //                       style: const TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w500,
  //                         color: AppColors.grey4,
  //                       ),
  //                     ),
  //                     // Text(
  //                     //   'Credit: ${provider.examDetailsHiveData[index].credit ?? '-'}',
  //                     //   style: const TextStyle(
  //                     //     fontSize: 14,
  //                     //     fontWeight: FontWeight.w500,
  //                     //     color: AppColors.grey4,
  //                     //   ),
  //                     // ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),

  //           // Divider
  //           const Divider(height: 1, color: AppColors.grey4),

  //           // Circular Indicators
  //           Padding(
  //             padding: const EdgeInsets.all(16),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Column(
  //                   children: [
  //                     CircularPercentIndicator(
  //                       radius: 55,
  //                       lineWidth: 12,
  //                       animation: true,
  //                       animationDuration: 1200,
  //                       percent: internalResult,
  //                       center: Text(
  //                         '${provider.examDetailsHiveData[index].internal ?? '-'}',
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold,
  //                           color: AppColors.theme02primaryColor,
  //                         ),
  //                       ),
  //                       circularStrokeCap: CircularStrokeCap.round,
  //                       progressColor: AppColors.theme02secondaryColor1,
  //                       backgroundColor: AppColors.grey4.withOpacity(0.3),
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Text(
  //                       'Internal',
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w600,
  //                         color: AppColors.theme02primaryColor,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   children: [
  //                     CircularPercentIndicator(
  //                       radius: 55,
  //                       lineWidth: 12,
  //                       animation: true,
  //                       animationDuration: 1200,
  //                       percent: externalResult,
  //                       center: Text(
  //                         '${provider.examDetailsHiveData[index].external ?? '-'}',
  //                         style: TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold,
  //                           color: AppColors.theme02primaryColor,
  //                         ),
  //                       ),
  //                       circularStrokeCap: CircularStrokeCap.round,
  //                       progressColor: AppColors.theme02secondaryColor1,
  //                       backgroundColor: AppColors.grey4.withOpacity(0.3),
  //                     ),
  //                     const SizedBox(height: 8),
  //                     Text(
  //                       'External',
  //                       style: TextStyle(
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w600,
  //                         color: AppColors.theme02primaryColor,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

 

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
