import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/main_pages/transport/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transportProvider);
    ref.listen(transportProvider, (previous, next) {
      if (next is TransportStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is TransportStateError) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Student ID',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.studentId,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Enter Student ID',
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Academicyear ID',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.academicyearId,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Enter Academicyear ID',
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Boardingpoint ID',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.boardingpointId,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Enter Boardingpoint ID',
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Busroute ID',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.busrouteId,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Enter Busroute ID',
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Controller ID',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.controllerId,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Enter Controller ID',
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
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Office ID',
                style: TextStyles.fontStyle2,
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.officeId,
                  style: TextStyles.fontStyle2,
                  decoration: InputDecoration(
                    hintText: 'Enter Office ID',
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
          Row(
            children: [
              Expanded(
                child: ButtonDesign.buttonDesign(
                  'Submit',
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
