import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/circular_progress_indicators.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(profileProvider.notifier).getProfileApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(profileProvider.notifier).getProfileHive('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).getProfileHive('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(profileProvider);
    ref.listen(profileProvider, (previous, next) {
      if (next is ProfileDetailsStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is ProfileDetailsStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    final base64Image =
        '${provider.profileDataHive.studentphoto}'; // shortened for brevity
    final imageBytes = base64Decode(base64Image);

    // log('profiel image >>> $base64Image');
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColor,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const HomePage2(),
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
                'PROFILE',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await ref.read(profileProvider.notifier).getProfileApi(
                              ref.read(
                                encryptionProvider.notifier,
                              ),
                            );
                        await ref
                            .read(profileProvider.notifier)
                            .getProfileHive('');
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        size: 35,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primaryColor,
        child: provider is ProfileDetailsStateLoading
            ? Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child:
                      CircularProgressIndicators.primaryColorProgressIndication,
                ),
              )
            : provider.profileDataHive.registerno == '' &&
                    provider is! ProfileDetailsStateLoading
                ? Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      const Center(
                        child: Text(
                          'No Data!',
                          style: TextStyles.fontStyle,
                        ),
                      ),
                    ],
                  )
                :
                // (provider.examDetailsData.isNotEmpty)
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      // height: 800,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.whiteColor,
                        ),
                        color: const Color.fromARGB(255, 252, 250, 250),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.memory(
                                  imageBytes,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width / 2 - 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Name',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.studentname}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.studentname}',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: width / 2 - 60,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width / 2 - 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Register NO',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.registerno}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.registerno}',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: width / 2 - 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Date of birth',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.dob}' == ''
                                          ? '-'
                                          : '${provider.profileDataHive.dob}',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width - 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Institution',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.universityname}' ==
                                              ''
                                          ? '-'
                                          : '''${provider.profileDataHive.universityname}''',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width / 2 - 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Program',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.program}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.program}',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: width / 2 - 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Semester',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.semester}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.semester}',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width / 2 - 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Section',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.sectiondesc}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.sectiondesc}',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: width / 2 - 60,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Academic Year',
                                      style: TextStyles.fontStyle7,
                                    ),
                                    Text(
                                      '${provider.profileDataHive.academicyear}' ==
                                              ''
                                          ? '-'
                                          : '''${provider.profileDataHive.academicyear}''',
                                      style: TextStyles
                                          .smallLightAshColorFontStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
      endDrawer: const DrawerDesign(),
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
