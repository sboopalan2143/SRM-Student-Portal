import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01SubjectPage extends ConsumerStatefulWidget {
  const Theme01SubjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01SubjectPageState();
}

class _Theme01SubjectPageState extends ConsumerState<Theme01SubjectPage> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

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
    final width = MediaQuery.of(context).size.width;
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
                'SUBJECTS',
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
                              .read(subjectProvider.notifier)
                              .getSubjectDetails(
                                  ref.read(encryptionProvider.notifier));
                          await ref
                              .read(subjectProvider.notifier)
                              .getHiveSubjectDetails('');
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
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.theme01secondaryColor4,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        width: width / 8,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sem',
                              style: TextStyles.fontStyletheme2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: width / 8,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Code',
                              style: TextStyles.fontStyletheme2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: width / 2.3,
                        child: const Column(
                          children: [
                            Text(
                              'Subject',
                              style: TextStyles.fontStyletheme2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5),
                      SizedBox(
                        width: width / 8,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Credit',
                              style: TextStyles.fontStyletheme2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (provider is SubjectStateLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircularProgressIndicators
                          .theme01primaryColorProgressIndication,
                    ),
                  )
                else if (provider.subjectHiveData.isEmpty &&
                    provider is! SubjectStateLoading)
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      const Center(
                        child: Text(
                          'No List Added',
                          style: TextStyles.fontStyle1,
                        ),
                      ),
                    ],
                  ),
                if (provider.subjectHiveData.isNotEmpty)
                  const SizedBox(height: 5),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: ListView.builder(
                    itemCount: provider.subjectHiveData.length,
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(subjectProvider);
    final width = MediaQuery.of(context).size.width;
    final data = provider.subjectHiveData[index].subjectdetails;
    final subjectData = data!.split('##');

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: width / 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectData[0],
                      style: TextStyles.theme01primary10small,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectData[1],
                      style: TextStyles.theme01primary10small,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2.3,
                child: Column(
                  children: [
                    Text(
                      subjectData[2],
                      style: TextStyles.theme01primary10small,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 8,
                child: Column(
                  children: [
                    Text(
                      subjectData[3],
                      style: TextStyles.theme01primary10small,
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
