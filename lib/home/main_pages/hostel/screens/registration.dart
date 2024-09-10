import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/api_token_services/api_tokens_services.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/hostel/screens/hostel.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState extends ConsumerState<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.

        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    final provider = ref.watch(hostelProvider);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                RouteDesign(
                  route: const HostelPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text(
            'REGISTRATION',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          actions: [
            Row(
              children: [
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Text(
            //       'Select Hostel',
            //       style: TextStyles.fontStyle2,
            //     ),
            //     const SizedBox(
            //       height: 5,
            //     ),
            //     Container(
            //       decoration: BoxDecoration(
            //         color: AppColors.whiteColor,
            //         borderRadius: BorderRadius.circular(7),
            //         border: Border.all(
            //           color: AppColors.grey2,
            //         ),
            //       ),
            //       height: 40,
            //       child: DropdownSearch<String>(
            //         // dropdownButtonProps: DropdownButtonProps(
            //         //   focusNode: widget.focusNodeC,
            //         // ),
            //         dropdownDecoratorProps: const DropDownDecoratorProps(
            //           dropdownSearchDecoration: InputDecoration(
            //             border: InputBorder.none,
            //             contentPadding:
            //                 EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //           ),
            //         ),
            //         itemAsString: (item) => item,
            //         items: name,
            //         popupProps: const PopupProps.menu(
            //           searchFieldProps: TextFieldProps(
            //             autofocus: true,
            //           ),
            //           constraints: BoxConstraints(maxHeight: 250),
            //         ),
            //         selectedItem: selectedValue,
            //         onChanged: (value) {
            //           // readProvider.selectCustomer(value!);
            //           setState(() {
            //             selectedValue = value!;
            //           });
            //         },
            //         dropdownBuilder: (BuildContext context, name) {
            //           return Text(
            //             name!,
            //             maxLines: 1,
            //             overflow: TextOverflow.ellipsis,
            //             style: TextStyles.smallLightAshColorFontStyle,
            //           );
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 20),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text(
            //             'FromDate',
            //             style: TextStyles.fontStyle2,
            //           ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           Container(
            //             decoration: BoxDecoration(
            //               color: AppColors.whiteColor,
            //               borderRadius: BorderRadius.circular(7),
            //               border: Border.all(
            //                 color: AppColors.grey2,
            //               ),
            //             ),
            //             height: 40,
            //             child: DropdownSearch<String>(
            //               // dropdownButtonProps: DropdownButtonProps(
            //               //   focusNode: widget.focusNodeC,
            //               // ),
            //               dropdownDecoratorProps: const DropDownDecoratorProps(
            //                 dropdownSearchDecoration: InputDecoration(
            //                   border: InputBorder.none,
            //                   contentPadding: EdgeInsets.symmetric(
            //                     horizontal: 20,
            //                     vertical: 5,
            //                   ),
            //                 ),
            //               ),
            //               itemAsString: (item) => item,
            //               items: name,
            //               popupProps: const PopupProps.menu(
            //                 searchFieldProps: TextFieldProps(
            //                   autofocus: true,
            //                 ),
            //                 constraints: BoxConstraints(maxHeight: 250),
            //               ),
            //               selectedItem: selectedValue,
            //               onChanged: (value) {
            //                 // readProvider.selectCustomer(value!);
            //                 setState(() {
            //                   selectedValue = value!;
            //                 });
            //               },
            //               dropdownBuilder: (BuildContext context, name) {
            //                 return Text(
            //                   name!,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyles.smallLightAshColorFontStyle,
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const Text(
            //             'ToDate',
            //             style: TextStyles.fontStyle2,
            //           ),
            //           const SizedBox(
            //             height: 5,
            //           ),
            //           Container(
            //             decoration: BoxDecoration(
            //               color: AppColors.whiteColor,
            //               borderRadius: BorderRadius.circular(7),
            //               border: Border.all(
            //                 color: AppColors.grey2,
            //               ),
            //             ),
            //             height: 40,
            //             child: DropdownSearch<String>(
            //               // dropdownButtonProps: DropdownButtonProps(
            //               //   focusNode: widget.focusNodeC,
            //               // ),
            //               dropdownDecoratorProps: const DropDownDecoratorProps(
            //                 dropdownSearchDecoration: InputDecoration(
            //                   border: InputBorder.none,
            //                   contentPadding: EdgeInsets.symmetric(
            //                     horizontal: 20,
            //                     vertical: 5,
            //                   ),
            //                 ),
            //               ),
            //               itemAsString: (item) => item,
            //               items: name,
            //               popupProps: const PopupProps.menu(
            //                 searchFieldProps: TextFieldProps(
            //                   autofocus: true,
            //                 ),
            //                 constraints: BoxConstraints(maxHeight: 250),
            //               ),
            //               selectedItem: selectedValue,
            //               onChanged: (value) {
            //                 // readProvider.selectCustomer(value!);
            //                 setState(() {
            //                   selectedValue = value!;
            //                 });
            //               },
            //               dropdownBuilder: (BuildContext context, name) {
            //                 return Text(
            //                   name!,
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyles.smallLightAshColorFontStyle,
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Academic Year',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.academicYearId,
                    keyboardType: TextInputType.number,
                    inputFormatters: KeyboardRule.numberInputRule,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
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
                  'Room Type',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.roomTypeId,
                    keyboardType: TextInputType.number,
                    inputFormatters: KeyboardRule.numberInputRule,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
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
                  'Hostel',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.hostelId,
                    keyboardType: TextInputType.number,
                    inputFormatters: KeyboardRule.numberInputRule,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
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
                  'Controller',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.controllerId,
                    keyboardType: TextInputType.number,
                    inputFormatters: KeyboardRule.numberInputRule,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
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
                  'Office',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.officeId,
                    keyboardType: TextInputType.number,
                    inputFormatters: KeyboardRule.numberInputRule,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: Checkbox(
                    side: const BorderSide(color: AppColors.grey, width: 2),
                    checkColor: AppColors.whiteColor,
                    value: false,
                    onChanged: (bool? value) {},
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  'I Agree and Continue to ',
                  style: TextStyles.fontStyle10,
                ),
                Text(
                  ' Terms and Conditions',
                  style: TextStyles.fontStyle14,
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
                    ref,
                  ),
                ),
              ],
            ),
          ],
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
