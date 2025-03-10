import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';


class Theme07SubjectPage extends ConsumerStatefulWidget {
  const Theme07SubjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07SubjectPageState();
}

class _Theme07SubjectPageState extends ConsumerState<Theme07SubjectPage> {
  final ScrollController _listController = ScrollController();

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
            'COURSE',
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

              SingleChildScrollView(
                child: Column(
                  children: [
                    // Reverse the loop to display semesters in reverse order (anticlockwise)
                    for (int i = 8; i >= 1; i--) ...[
                      if (provider.subjectHiveData.any((data) =>
                          data.subjectdetails!.split('##')[0] == '$i')) ...[
                        Theme(

  data: Theme.of(context).copyWith(
    dividerColor: Colors.transparent, 
  ),
                          child: Column(
                            children: [

                              ExpansionTile(

                                title: Text(
                                  'Semester $i',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.theme07primaryColor,
                                  ),
                                ),
                                initiallyExpanded: false,
                                // Start collapsed by default
                                backgroundColor: AppColors.theme07secondaryColor,
                                iconColor: AppColors.blackColor,
                                textColor: AppColors.whiteColor,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          'Code',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.theme07primaryColor,
                                          )

                                      ),

                                      Text(
                                          'Course',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.theme07primaryColor,
                                          )

                                      ),Text(
                                          'Credit',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.theme07primaryColor,
                                          )

                                      ),
                                    ],
                                  ),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesign(List<String> subjectData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Clean background
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white, // Light blue header background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Code',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey.shade600,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Text(
                          subjectData[1],
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Course',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey.shade600,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Text(
                          subjectData[2],
                           style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   'Credit',
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //     color: Colors.grey.shade600,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Text(
                          subjectData[3],
                           style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Divider

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
