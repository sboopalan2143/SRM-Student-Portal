import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/designs/detailed_row.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07ProfilePage extends ConsumerStatefulWidget {
  const Theme07ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07ProfilePageState();
}

class _Theme07ProfilePageState extends ConsumerState<Theme07ProfilePage> {
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

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey<LiquidPullToRefreshState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).getProfileHive('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = pro.Provider.of<ThemeProvider>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(profileProvider);

    final base64Image = '${provider.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);
    log(base64Image);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(60),
      //   child: AppBar(
      //     flexibleSpace: Container(
      //       decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //           colors: [
      //             AppColors.theme07primaryColor,
      //             AppColors.theme07primaryColor,
      //           ],
      //           begin: Alignment.topCenter,
      //           end: Alignment.bottomCenter,
      //         ),
      //       ),
      //     ),
      //     leading: IconButton(
      //       onPressed: () {
      //         Navigator.pop(
      //           context,
      //         );
      //       },
      //       icon: const Icon(
      //         Icons.arrow_back_ios_new,
      //         color: AppColors.whiteColor,
      //       ),
      //     ),
      //     backgroundColor: Colors.transparent,
      //     elevation: 0,
      //     title: Text(
      //       'PROFILE',
      //       style: TextStyles.fontStyle4,
      //       overflow: TextOverflow.clip,
      //     ),
      //     centerTitle: true,
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.only(right: 20),
      //         child: Row(
      //           children: [
      //             GestureDetector(
      //               onTap: () async {
      //                 await ref
      //                     .read(
      //                       profileProvider.notifier,
      //                     )
      //                     .getProfileApi(
      //                       ref.read(
      //                         encryptionProvider.notifier,
      //                       ),
      //                     );
      //                 await ref
      //                     .read(
      //                       profileProvider.notifier,
      //                     )
      //                     .getProfileHive(
      //                       '',
      //                     );
      //               },
      //               child: const Icon(
      //                 Icons.refresh,
      //                 color: AppColors.whiteColor,
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: provider is ProfileDetailsStateLoading
          ? Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: CircularProgressIndicators.theme07primaryColorProgressIndication,
              ),
            )
          : provider.profileDataHive.registerno == '' && provider is! ProfileDetailsStateLoading
              ? Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    Center(
                      child: Text(
                        'No Data!',
                        style: TextStyles.fontStyle,
                      ),
                    ),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: _handleRefresh,
                  color: Theme.of(context).colorScheme.tertiary,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // P R O F I L E   T I L E
                        Container(
                          padding: const EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(100, 0)),
                            // borderRadius: const BorderRadius.only(
                            //   bottomRight: Radius.elliptical(80, 80),
                            //   topLeft: Radius.elliptical(80, 80),
                            // ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // P R O F I L E   I M A G E
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Center(
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: imageBytes.isNotEmpty
                                          ? DecorationImage(
                                              image: MemoryImage(imageBytes),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                      color: Theme.of(context).colorScheme.tertiary,
                                    ),
                                    child: imageBytes.isEmpty
                                        ? const Icon(
                                            FontAwesomeIcons.userGraduate,
                                            size: 50,
                                            color: Colors.white70,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${provider.profileDataHive.studentname}' == ''
                                        ? '-'
                                        : '${provider.profileDataHive.studentname}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${provider.profileDataHive.registerno}' == ''
                                        ? '-'
                                        : '${provider.profileDataHive.registerno}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  // Text(
                                  //   '${provider.profileDataHive.dob}' == '' ? '-' : '${provider.profileDataHive.dob}',
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //     color: Colors.white70,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Personal Information:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailedRow(
                                  label: 'Date of Birth',
                                  value:
                                      '${provider.profileDataHive.dob}' == '' ? '-' : '${provider.profileDataHive.dob}',
                                  icon: Icons.cake,
                                ),
                                DetailedRow(
                                  label: 'University',
                                  value: '${provider.profileDataHive.universityname}' == ''
                                      ? '-'
                                      : '''${provider.profileDataHive.universityname}''',
                                  icon: Icons.calendar_month,
                                ),
                                DetailedRow(
                                  label: 'Semester',
                                  value: '${provider.profileDataHive.semester}' == ''
                                      ? '-'
                                      : '${provider.profileDataHive.semester}',
                                  icon: Icons.call,
                                ),
                                DetailedRow(
                                  label: 'Section',
                                  value: '${provider.profileDataHive.sectiondesc}' == ''
                                      ? '-'
                                      : '${provider.profileDataHive.sectiondesc} Section',
                                  icon: Icons.mail,
                                ),
                                DetailedRow(
                                  label: 'Academic Year',
                                  value: '${provider.profileDataHive.academicyear}' == ''
                                      ? '-'
                                      : '''${provider.profileDataHive.academicyear}''',
                                  icon: Icons.calendar_month,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
