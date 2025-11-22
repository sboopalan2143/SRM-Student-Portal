import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07InternalMarksPage extends ConsumerStatefulWidget {
  const Theme07InternalMarksPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07InternalMarksPageState();
}

class _Theme07InternalMarksPageState extends ConsumerState<Theme07InternalMarksPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;

  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(internalMarksProvider.notifier).getHiveInternalMarks('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(internalMarksProvider);
    ref.listen(internalMarksProvider, (previous, next) {
      if (next is InternalMarksStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is InternalMarksStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
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
          title: Text(
            'INTERNAL MARKS',
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
                          .read(internalMarksProvider.notifier)
                          .getInternalMarksDetails(ref.read(encryptionProvider.notifier));
                      await ref.read(internalMarksProvider.notifier).getHiveInternalMarks('');
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
            if (provider is InternalMarksStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              )
            else if (provider.internalMarkHiveData.isEmpty && provider is! InternalMarksStateLoading)
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
            if (provider.internalMarkHiveData.isNotEmpty) const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                itemCount: provider.internalMarkHiveData.length,
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
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    final provider = ref.watch(internalMarksProvider);
    double.parse('${provider.internalMarkHiveData[index].sumofmaxmarks}');
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 + 40,
                    child: Text(
                      '${provider.internalMarkHiveData[index].subjectdesc}' == ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].subjectdesc}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.inverseSurface,
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
                        SizedBox(
                          width: 15,
                          child: Icon(
                            Icons.numbers,
                            color: Theme.of(context).colorScheme.inverseSurface.withAlpha(150),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: width / 2 - 100,
                          child: Text(
                            '${provider.internalMarkHiveData[index].subjectcode}' == ''
                                ? '-'
                                : '${provider.internalMarkHiveData[index].subjectcode}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.inverseSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: width / 2,
                    child: Text(
                      '${provider.internalMarkHiveData[index].sumofmarks}' == ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].sumofmarks}/${provider.internalMarkHiveData[index].sumofmaxmarks}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.inverseSurface,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    'Max Marks :',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.inverseSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  LinearPercentIndicator(
                    // trailing: SizedBox(
                    //   width: width / 4,
                    //   // child: Text(
                    //   //   (provider.internalMarkHiveData[index].sumofmaxmarks ==
                    //   //               null ||
                    //   //           provider
                    //   //               .internalMarkHiveData[index].sumofmaxmarks
                    //   //               .toString()
                    //   //               .isEmpty)
                    //   //       ? '-'
                    //   //       : '${provider.internalMarkHiveData[index].sumofmarks}/${provider.internalMarkHiveData[index].sumofmaxmarks}',
                    //   //   style: TextStyle(
                    //   //     fontSize: 16,
                    //   //     color: Theme.of(context).colorScheme.inverseSurface,
                    //   //     fontWeight: FontWeight.bold,
                    //   //   ),
                    //   //   textAlign: TextAlign.right,
                    //   // ),
                    // ),
                    width: MediaQuery.of(context).size.width - 200,
                    animation: true,
                    lineHeight: 10,
                    animationDuration: 1000,
                    backgroundColor: Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                    percent: (provider.internalMarkHiveData[index].sumofmarks != null &&
                            provider.internalMarkHiveData[index].sumofmaxmarks != null &&
                            double.tryParse(
                                  provider.internalMarkHiveData[index].sumofmaxmarks.toString(),
                                )! >
                                0)
                        ? (double.tryParse(
                              provider.internalMarkHiveData[index].sumofmarks.toString(),
                            )! /
                            double.tryParse(
                              provider.internalMarkHiveData[index].sumofmaxmarks.toString(),
                            )!)
                        : 0.0,
                    barRadius: const Radius.circular(15),
                    progressColor: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  const SizedBox(height: 20),
                ],
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
