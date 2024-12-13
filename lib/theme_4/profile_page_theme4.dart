import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/theme_4/login_screen_theme4.dart';

class ProfilePageTheme4 extends ConsumerStatefulWidget {
  const ProfilePageTheme4({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfilePageTheme4State();
}

class _ProfilePageTheme4State extends ConsumerState<ProfilePageTheme4> {
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

    final height = MediaQuery.of(context).size.height;
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

    return Scaffold(
      backgroundColor: AppColors.secondaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(230),
        child: Container(
          decoration:
              const BoxDecoration(gradient: AppColors.primaryColorTheme4),
          child: provider is ProfileDetailsStateLoading
              ? Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              : provider.profileDataHive.registerno == '' &&
                      provider is! ProfileDetailsStateLoading
                  ? Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 5),
                        const Center(
                          child: Text(
                            'No Data!',
                            style: TextStyles.fontStyle,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: height * 0.05),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await ref
                                    .read(profileProvider.notifier)
                                    .getProfileApi(
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
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                          ],
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.memory(
                              imageBytes,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text(
                          '${provider.profileDataHive.studentname}' == ''
                              ? '-'
                              : '${provider.profileDataHive.studentname}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * 0.001),
                        Text(
                          '${provider.profileDataHive.registerno}' == ''
                              ? '-'
                              : '${provider.profileDataHive.registerno}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primaryColorTheme3,
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
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Icon(
                                        Icons.numbers,
                                        size: 25,
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${provider.profileDataHive.registerno}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.registerno}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Icon(
                                        Icons.event_note,
                                        size: 25,
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${provider.profileDataHive.dob}' == ''
                                          ? '-'
                                          : '${provider.profileDataHive.dob}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Icon(
                                        Icons.corporate_fare,
                                        size: 25,
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${provider.profileDataHive.universityname}' ==
                                              ''
                                          ? '-'
                                          : '''${provider.profileDataHive.universityname}''',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Icon(
                                        Icons.school,
                                        size: 25,
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${provider.profileDataHive.program}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.program}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Icon(
                                        Icons.web_stories,
                                        size: 25,
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${provider.profileDataHive.semester}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.semester}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Icon(
                                        Icons.diversity_2,
                                        size: 25,
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${provider.profileDataHive.sectiondesc}' ==
                                              ''
                                          ? '-'
                                          : '${provider.profileDataHive.sectiondesc} Section',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 75,
                                      child: Icon(
                                        Icons.calendar_month,
                                        size: 25,
                                        color: AppColors.blackColor
                                            .withOpacity(0.8),
                                      ),
                                    ),
                                    Text(
                                      '${provider.profileDataHive.academicyear}' ==
                                              ''
                                          ? '-'
                                          : '''${provider.profileDataHive.academicyear}''',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.blackColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.blackColor.withOpacity(0.5),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ref
                                      .read(mainProvider.notifier)
                                      .setNavString('Logout');
                                  TokensManagement.clearSharedPreference();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    RouteDesign(route: const LoginPageTheme4()),
                                    (route) => false,
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Icon(
                                          Icons.logout,
                                          size: 25,
                                          color: AppColors.blackColor
                                              .withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        'LOGOUT',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.blackColor
                                              .withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //   child: Row(
                        //     children: [
                        //       const SizedBox(
                        //         width: 50,
                        //         child: Icon(Icons.sync, size: 25),
                        //       ),
                        //       Text(
                        //         'Last Updated : ',
                        //         style: TextStyle(
                        //           fontSize: 16,
                        //           color: AppColors.blackColor.withOpacity(0.7),
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
