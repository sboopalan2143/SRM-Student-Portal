
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';

class Theme07ProfilePage extends ConsumerStatefulWidget {
  const Theme07ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07ProfilePageState();
}

class _Theme07ProfilePageState extends ConsumerState<Theme07ProfilePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileProvider.notifier).getProfileHive('');
    });
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final provider = ref.watch(profileProvider);

    final base64Image = '${provider.profileDataHive.studentphoto}';
    final imageBytes = base64Decode(base64Image);

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
            'PROFILE',
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
                                  .read(
                                   profileProvider
                                          .notifier,
                                             )
                                                              .getProfileApi(
                                                                ref.read(
                                                                  encryptionProvider
                                                                      .notifier,
                                                                ),
                                                              );
                                                          await ref
                                                              .read(
                                                                profileProvider
                                                                    .notifier,
                                                              )
                                                              .getProfileHive(
                                                                '',
                                                              );
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

      body: provider is ProfileDetailsStateLoading
          ? Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child:
                    CircularProgressIndicators.theme07primaryColorProgressIndication,
              ),
            )
          : provider.profileDataHive.registerno == '' &&
                  provider is! ProfileDetailsStateLoading
              ? Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
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
                      const SizedBox(height: 15,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                           decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                Column(
                                        children: [
                                         
                                        
                                          Container(
                                            height: 100,
                                            width: 100,
                                            padding:
                                                const EdgeInsets.all(3),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.whiteColor,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                50,
                                              ),
                                              child: Image.memory(
                                                imageBytes,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          Text(
                                            '${provider.profileDataHive.studentname}' ==
                                                    ''
                                                ? '-'
                                                : '${provider.profileDataHive.studentname}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.blackColor
                                                  .withOpacity(0.7),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: height * 0.001,
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
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                       SizedBox(
                                            height: height * 0.01,
                                          ),
                               
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Icon(
                                          Icons.event_note,
                                          size: 25,
                                          color: AppColors.theme07primaryColor,
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Icon(
                                          Icons.corporate_fare,
                                          size: 25,
                                          color: AppColors.theme07primaryColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
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
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: AppColors.blackColor.withOpacity(0.5),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Icon(
                                          Icons.school,
                                          size: 25,
                                          color: AppColors.theme07primaryColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Icon(
                                          Icons.web_stories,
                                          size: 25,
                                          color: AppColors.theme07primaryColor,
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Icon(
                                          Icons.diversity_2,
                                          size: 25,
                                          color: AppColors.theme07primaryColor,
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                        child: Icon(
                                          Icons.calendar_month,
                                          size: 25,
                                          color: AppColors.theme07primaryColor,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                    ],
                  ),
                ),
    );
  }

}
