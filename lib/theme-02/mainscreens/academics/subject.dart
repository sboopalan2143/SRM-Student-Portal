import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme02SubjectPage extends ConsumerStatefulWidget {
  const Theme02SubjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02SubjectPageState();
}

class _Theme02SubjectPageState extends ConsumerState<Theme02SubjectPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  // static int refreshNum = 10;
  // Stream<int> counterStream =
  //     Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(subjectProvider.notifier)
            .getSubjectDetails(ref.read(encryptionProvider.notifier));
        await ref.read(subjectProvider.notifier).getHiveSubjectDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(subjectProvider.notifier).getHiveSubjectDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(subjectProvider);
    ref.listen(subjectProvider, (previous, next) {
      if (next is SubjectStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is SubjectStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme02primaryColor,
                  AppColors.theme02secondaryColor1,
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
            'Subject',
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
                          .read(subjectProvider.notifier)
                          .getSubjectDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref
                          .read(subjectProvider.notifier)
                          .getHiveSubjectDetails('');
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              if (provider is SubjectStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.subjectHiveData.isEmpty &&
                  provider is! SubjectStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle,
                      ),
                    ),
                  ],
                ),
              if (provider.subjectHiveData.isNotEmpty)
                const SizedBox(height: 5),
              // ListView.builder(
              //   itemCount: provider.subjectHiveData.length,
              //   controller: _listController,
              //   shrinkWrap: true,
              //   itemBuilder: (BuildContext context, int index) {
              //     return cardDesign(index);
              //   },
              // ),

              SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 1; i <= 8; i++) ...[
                      if (provider.subjectHiveData.any((data) =>
                          data.subjectdetails!.split('##')[0] == '$i')) ...[
                        ExpansionTile(
                          title: Text(
                            'Semester $i',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.theme06primaryColor,
                            ),
                          ),
                          initiallyExpanded: false,
                          // Start collapsed by default
                          backgroundColor:
                              AppColors.theme02primaryColor.withOpacity(0.2),
                          iconColor: AppColors.whiteColor,
                          textColor: AppColors.whiteColor,
                          children: [
                            ...provider.subjectHiveData
                                .where((data) =>
                                    data.subjectdetails!.split('##')[0] == '$i')
                                .map((data) {
                              final subjectData =
                                  data.subjectdetails!.split('##');
                              return cardDesign(subjectData);
                            }).toList(),
                          ],
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(List<String> subjectData) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.theme02primaryColor,
              AppColors.theme02secondaryColor1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: Text(
                      'SEMESTER : ${subjectData[0]}',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.theme02buttonColor2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Text(
                      'Code : ${subjectData[1]}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(
                color: AppColors.grey4,
                height: 1,
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: Text(
                      'Subject : ${subjectData[2]}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: Text(
                      'Credit : ${subjectData[3]}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(
                thickness: 2,
                color: AppColors.theme02secondaryColor1,
                height: 1,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Widget cardDesign(int index) {
  //   final provider = ref.watch(subjectProvider);
  //   final data = provider.subjectHiveData[index].subjectdetails;
  //   final subjectData = data!.split('##');
  //
  //   return Padding(
  //     padding: const EdgeInsets.all(8),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [
  //             AppColors.theme02primaryColor,
  //             AppColors.theme02secondaryColor1,
  //           ],
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //         ),
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const SizedBox(height: 10),
  //             const SizedBox(height: 15),
  //             Row(
  //               children: [
  //                 const SizedBox(width: 30),
  //                 Expanded(
  //                   child: Text(
  //                     'SEMESTER : ${subjectData[0]}',
  //                     style: TextStyle(
  //                       fontSize: 14,
  //                       color: AppColors.theme02buttonColor2,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 30),
  //                 Expanded(
  //                   child: Text(
  //                     'Code : ${subjectData[1]}',
  //                     style: const TextStyle(
  //                       fontSize: 14,
  //                       color: AppColors.whiteColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 15),
  //             const Divider(
  //               color: AppColors.grey4,
  //               height: 1,
  //             ),
  //             const SizedBox(height: 15),
  //             Row(
  //               children: [
  //                 const SizedBox(width: 30),
  //                 Expanded(
  //                   child: Text(
  //                     'Subject : ${subjectData[2]}',
  //                     style: const TextStyle(
  //                       fontSize: 14,
  //                       color: AppColors.whiteColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 30),
  //                 Expanded(
  //                   child: Text(
  //                     'Credit : ${subjectData[3]}',
  //                     style: const TextStyle(
  //                       fontSize: 14,
  //                       color: AppColors.whiteColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 20),
  //             Divider(
  //               thickness: 2,
  //               color: AppColors.theme02secondaryColor1,
  //               height: 1,
  //             ),
  //             const SizedBox(height: 10),
  //           ],
  //         ),
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
