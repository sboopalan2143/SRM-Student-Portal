import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/login/widget/button_design.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  @override
  ConsumerState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
