import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/theme_4/bottom_navigation_page_theme4.dart';

class SubjectPageTheme4 extends ConsumerStatefulWidget {
  const SubjectPageTheme4({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubjectPageTheme4State();
}

class _SubjectPageTheme4State extends ConsumerState<SubjectPageTheme4> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
      backgroundColor: AppColors.whiteColor,
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
                'SUBJECTS',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
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
        color: AppColors.theme4color1,
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
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
                ListView.builder(
                  itemCount: provider.subjectHiveData.length,
                  controller: _listController,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return cardDesign(index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(subjectProvider);
    final data = provider.subjectHiveData[index].subjectdetails;
    final subjectData = data!.split('##');

    return ColoredBox(
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.menu_book,
                  size: 25,
                  color: AppColors.grey1,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'SEMESTER  ${subjectData[0]}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.theme4color2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    subjectData[2],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Text(
                    subjectData[1],
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    subjectData[3],
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(
              height: 1,
              color: AppColors.grey,
            )
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
