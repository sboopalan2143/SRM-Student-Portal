import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/drawer_pages/change_password/riverpod/change_password_state.dart';

class ChangePasswordTheme4 extends ConsumerStatefulWidget {
  const ChangePasswordTheme4({super.key});

  @override
  ConsumerState createState() => _ChangePasswordTheme4State();
}

class _ChangePasswordTheme4State extends ConsumerState<ChangePasswordTheme4>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(changePasswordProvider);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: AppColors.primaryColorTheme3,
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
                'Change password',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.primaryColorTheme4),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                child: TextField(
                  controller: provider.currentPassword,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: AppColors.whiteColor,
                    ),
                    hintText: 'Enter Current Password',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.whiteColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                    // filled: true,
                    // fillColor: AppColors.secondaryColorTheme3,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: provider.newPassword,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.whiteColor,
                    ),
                    hintText: 'Enter New Password',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.whiteColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                    // filled: true,
                    // fillColor: AppColors.secondaryColorTheme3,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 45,
                child: TextField(
                  controller: provider.confirmPassword,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.whiteColor,
                    ),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.whiteColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                    // filled: true,
                    // fillColor: AppColors.secondaryColorTheme3,
                    contentPadding: const EdgeInsets.all(10),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        elevation: 0,
                        // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        backgroundColor: AppColors.whiteColor,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {
                        // provider.setNavString('Home');

                        await ref
                            .read(changePasswordProvider.notifier)
                            .changePassword(
                                ref.read(encryptionProvider.notifier));
                      },
                      child: provider is ChangePasswordStateLoading
                          ? CircularProgressIndicator(
                              color: AppColors.secondaryColorTheme3,
                            )
                          : const Text(
                              'SAVE',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.theme4color2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
