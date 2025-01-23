import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

class InternalMarksPageTheme4 extends ConsumerStatefulWidget {
  const InternalMarksPageTheme4({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InternalMarksPageTheme4State();
}

class _InternalMarksPageTheme4State
    extends ConsumerState<InternalMarksPageTheme4> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref
            .read(internalMarksProvider.notifier)
            .getInternalMarksDetails(ref.read(encryptionProvider.notifier));
        await ref.read(internalMarksProvider.notifier).getHiveInternalMarks('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

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
      backgroundColor: AppColors.secondaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return AppColors.primaryColorTheme4.createShader(bounds);
              },
              blendMode: BlendMode.srcIn,
              child: SvgPicture.asset(
                'assets/images/wave.svg',
                fit: BoxFit.fill,
                width: double.infinity,
                color: AppColors.whiteColor,
                colorBlendMode: BlendMode.srcOut,
              ),
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const MainScreenPage4(),
                    ),
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
                              .getInternalMarksDetails(
                                  ref.read(encryptionProvider.notifier));
                          await ref
                              .read(internalMarksProvider.notifier)
                              .getHiveInternalMarks('');
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
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        onRefresh: _handleRefresh,
        color: AppColors.theme4color1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (provider is InternalMarksStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.internalMarkHiveData.isEmpty &&
                  provider is! InternalMarksStateLoading)
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
              if (provider.internalMarkHiveData.isNotEmpty)
                const SizedBox(height: 5),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(internalMarksProvider);
    return Padding(
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 + 40,
                    child: Text(
                      '${provider.internalMarkHiveData[index].subjectdesc}' ==
                              ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].subjectdesc}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      '${provider.internalMarkHiveData[index].sumofmarks}' == ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].sumofmarks}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: AppColors.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
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
                          width: width / 2 - 130,
                          child: Text(
                            '${provider.internalMarkHiveData[index].subjectcode}' ==
                                    ''
                                ? '-'
                                : '${provider.internalMarkHiveData[index].subjectcode}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.grey4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'MAX MARKS',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.grey1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: width / 5,
                        child: Text(
                          '${provider.internalMarkHiveData[index].sumofmaxmarks}' ==
                                  ''
                              ? '-'
                              : '${provider.internalMarkHiveData[index].sumofmaxmarks}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.grey4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
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
