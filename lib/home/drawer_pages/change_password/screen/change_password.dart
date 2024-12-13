import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/login/widget/button_design.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(changePasswordProvider);

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
                'CHANGE PASSWORD',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // scaffoldKey.currentState?.openEndDrawer();
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 0,
          color: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Password',
                      style: TextStyles.fontStyle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: provider.currentPassword,
                        style: TextStyles.fontStyle2,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.account_circle,
                            color: AppColors.grey2,
                          ),
                          hintText: 'Enter Current Password',
                          hintStyle: TextStyles.smallLightAshColorFontStyle,
                          filled: true,
                          fillColor: AppColors.secondaryColor,
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                          focusedBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'New Password',
                      style: TextStyles.fontStyle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: provider.newPassword,
                        style: TextStyles.fontStyle2,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.grey2,
                          ),
                          hintText: 'Enter New Password',
                          hintStyle: TextStyles.smallLightAshColorFontStyle,
                          filled: true,
                          fillColor: AppColors.secondaryColor,
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                          focusedBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Confirm Password',
                      style: TextStyles.fontStyle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        controller: provider.confirmPassword,
                        style: TextStyles.fontStyle2,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.grey2,
                          ),
                          hintText: 'Confirm Password',
                          hintStyle: TextStyles.smallLightAshColorFontStyle,
                          filled: true,
                          fillColor: AppColors.secondaryColor,
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                          focusedBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ButtonDesign.buttonDesign(
                        'Save',
                        AppColors.primaryColor,
                        context,
                        ref.read(mainProvider.notifier),
                        ref,
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
}
