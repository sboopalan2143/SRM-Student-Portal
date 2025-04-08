import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hive/hive.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/profile/model/profile_hive_model.dart';
import 'package:sample/home/drawer_pages/profile/riverpod/profile_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/exam_detail.dart';
import 'package:sample/theme-07/mainscreens/fees/academy/internal_mark_screen.dart';

class Theme07GradeHomePage extends ConsumerStatefulWidget {
  const Theme07GradeHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07GradeHomePageState();
}

class _Theme07GradeHomePageState extends ConsumerState<Theme07GradeHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      await ref.read(hostelProvider.notifier).getRoomTypeHiveData('');

      final profile = await Hive.openBox<ProfileHiveData>('profile');
      if (profile.isEmpty) {
        await ref.read(profileProvider.notifier).getProfileApi(
              ref.read(
                encryptionProvider.notifier,
              ),
            );
        await ref.read(profileProvider.notifier).getProfileHive('');
      }
      await profile.close();
    });
  }

  @override
  Widget build(BuildContext context) {    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(hostelProvider);
    log('Regconfig  : ${provider.hostelRegisterDetails.regconfig}');
    log('status  : ${provider.hostelRegisterDetails.status}');
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
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
            'GRADE',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
           Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 120,
                                    width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                                    onPressed: () {
                                      Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme07InternalMarksPage(),
                  ),
                );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                       
                                       Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                       const SizedBox(
                                          child: Icon(
        Icons.note_alt_outlined, // Grade icon
        color: AppColors.grey1, // Gold color
        size: 40, // Icon size
      ),
                                        ),
                                        SizedBox(
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'Internal',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
                                        ),
                                      ],
                                    ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.06,
                                ),
                                SizedBox(
                                  height: 120,
                                    width: width * 0.36,
                                  child: ElevatedButton(
                                    style: BorderBoxButtonDecorations.homePageButtonStyle,
                                    onPressed: () {
                                       Navigator.push(
                  context,
                  RouteDesign(
                    route: const Theme07ExamDetailsPageTheme(),
                  ),
                );
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                       const SizedBox(
                                          child: Icon(
        Icons.inventory_rounded,// Grade icon
        color: AppColors.grey1, // Gold color
        size: 40, // Icon size
      ),
                                        ),
                                        SizedBox(
                                          height: height * 0.006,
                                        ),
                                        Text(
                                          'External',
                                          textAlign: TextAlign.center,
                                          style: width > 400
                                              ? TextStyles.smallBlackColorFontStyle
                                              : TextStyles.smallerBlackColorFontStyle,
                                        ),
                                      ],
                                    ),
                                      
                                       
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
          
        
        
        ],
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
