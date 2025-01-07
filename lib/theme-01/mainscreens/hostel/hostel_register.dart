import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_hive_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';

class Theme01RegistrationPage extends ConsumerStatefulWidget {
  const Theme01RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01RegistrationPageState();
}

class _Theme01RegistrationPageState
    extends ConsumerState<Theme01RegistrationPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(hostelProvider.notifier).getAfterHostelRegisterDetailsHive('');
      // ref.read(hostelProvider.notifier).getBeforeHostelRegisterDetailsHive('');

      ref
          .read(hostelProvider.notifier)
          .gethostel(ref.read(encryptionProvider.notifier));

      ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      ref.read(hostelProvider.notifier).getRoomTypeHiveData('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    log('hostelData dropdown kabir>>> ${provider.hostelData}');
    log('roomtypeData dropdown kabir>>> ${provider.roomTypeData}');
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is HostelStateSuccessful) {
      //   /// Handle route to next page.

      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });

    return Scaffold(
        backgroundColor: AppColors.theme01primaryColor,
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
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.theme01primaryColor,
                  ),
                ),
                backgroundColor: AppColors.theme01secondaryColor4,
                elevation: 0,
                title: Text(
                  'REGISTRATION',
                  style: TextStyles.buttonStyle01theme4,
                  overflow: TextOverflow.clip,
                ),
                centerTitle: true,
                actions: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.menu,
                          size: 35,
                          color: AppColors.theme01primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        body: registrationForm()

        //  provider is HostelStateLoading
        //     ? Padding(
        //         padding: const EdgeInsets.only(top: 100),
        //         child: Center(
        //           child:
        //               CircularProgressIndicators.primaryColorProgressIndication,
        //         ),
        //       )
        //     : provider.hostelRegisterDetails!.status == '1' &&
        //             provider is! HostelStateLoading
        //         ? Column(
        //             children: [
        //               SizedBox(height: MediaQuery.of(context).size.height / 5),
        //               const Center(
        //                 child: Text(
        //                   'No Data!',
        //                   style: TextStyles.fontStyle,
        //                 ),
        //               ),
        //             ],
        //           )
        //         : Padding(
        //             padding:
        //                 const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        //             child: Material(
        //               elevation: 5,
        //               shadowColor:
        //                   AppColors.theme01secondaryColor4.withOpacity(0.4),
        //               borderRadius: BorderRadius.circular(20),
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   gradient: LinearGradient(
        //                     colors: [
        //                       AppColors.theme01secondaryColor1,
        //                       AppColors.theme01secondaryColor2,
        //                     ],
        //                     begin: Alignment.topLeft,
        //                     end: Alignment.bottomRight,
        //                   ),
        //                   borderRadius: BorderRadius.circular(20),
        //                 ),
        //                 child: Padding(
        //                   padding: const EdgeInsets.all(20),
        //                   child: ExpansionTile(
        //                     title: Row(
        //                       children: [
        //                         SizedBox(
        //                           width: width / 2 - 100,
        //                           child: Text(
        //                             'Hostel :',
        //                             style: TextStyles.buttonStyle01theme2,
        //                           ),
        //                         ),
        //                         Expanded(
        //                           child: Text(
        //                             '''${provider.hostelAfterRegisterDetails!.hostel}''' ==
        //                                     ''
        //                                 ? '-'
        //                                 : '''${provider.hostelAfterRegisterDetails!.hostel}''',
        //                             style: TextStyles.fontStyle2,
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     collapsedIconColor: AppColors.theme01primaryColor,
        //                     iconColor: AppColors.theme01primaryColor,
        //                     children: [
        //                       Divider(
        //                           color: AppColors.theme01primaryColor
        //                               .withOpacity(0.5)),
        //                       _buildRow(
        //                         'Hostel Fee Amount :',
        //                         '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''' ==
        //                                 ''
        //                             ? '-'
        //                             : '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''',
        //                         width,
        //                       ),
        //                       _buildRow(
        //                         'Registration Date',
        //                         '''${provider.hostelAfterRegisterDetails!.registrationdate}''' ==
        //                                 ''
        //                             ? '-'
        //                             : '''${provider.hostelAfterRegisterDetails!.registrationdate}''',
        //                         width,
        //                       ),
        //                       _buildRow(
        //                         'Caution Deposit Amt',
        //                         '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''' ==
        //                                 ''
        //                             ? '-'
        //                             : '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''',
        //                         width,
        //                       ),
        //                       _buildRow(
        //                         'Room Type :',
        //                         '''${provider.hostelAfterRegisterDetails!.roomtype}''' ==
        //                                 ''
        //                             ? '-'
        //                             : '''${provider.hostelAfterRegisterDetails!.roomtype}''',
        //                         width,
        //                       ),
        //                       _buildRow(
        //                         'Active Status',
        //                         '''${provider.hostelAfterRegisterDetails!.activestatus}''' ==
        //                                 ''
        //                             ? '-'
        //                             : '''${provider.hostelAfterRegisterDetails!.activestatus}''',
        //                         width,
        //                       ),
        //                       _buildRow(
        //                         'Active Status',
        //                         '''${provider.hostelAfterRegisterDetails!.messfeeamount}''' ==
        //                                 ''
        //                             ? '-'
        //                             : '''${provider.hostelAfterRegisterDetails!.messfeeamount}''',
        //                         width,
        //                       ),
        //                       _buildRow(
        //                         'Active Status',
        //                         '''${provider.hostelAfterRegisterDetails!.applnfeeamount}''' ==
        //                                 ''
        //                             ? '-'
        //                             : '''${provider.hostelAfterRegisterDetails!.applnfeeamount}''',
        //                         width,
        //                       ),
        //                       const SizedBox(height: 10),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ),
        );
  }

  Widget _buildRow(String title, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            title,
            style: TextStyles.buttonStyle01theme2,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle2,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle2,
          ),
        ),
      ],
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

  Widget registrationForm() {
    final provider = ref.watch(hostelProvider);
    final providerRead = ref.read(hostelProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Column(
        children: [
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
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: AppColors.grey2,
                    ),
                  ),
                  height: 40,
                  child: DropdownSearch<HostelHiveData>(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                      ),
                    ),
                    itemAsString: (item) => item.hostelname!,
                    items: provider.hostelData,
                    popupProps: const PopupProps.menu(
                      searchFieldProps: TextFieldProps(
                        autofocus: true,
                      ),
                      constraints: BoxConstraints(maxHeight: 250),
                    ),
                    selectedItem: provider.selectedHostelData,
                    onChanged: (value) {
                      providerRead.setHostelValue(
                        value!,
                        ref.read(encryptionProvider.notifier),
                      );
                    },
                    dropdownBuilder: (BuildContext context, name) {
                      return Text(
                        name!.hostelname!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.smallLightAshColorFontStyle,
                      );
                    },
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
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      color: AppColors.grey2,
                    ),
                  ),
                  height: 40,
                  child: DropdownSearch<RoomTypeHiveData>(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                      ),
                    ),
                    itemAsString: (item) => item.roomtypename!,
                    items: provider.roomTypeData,
                    popupProps: const PopupProps.menu(
                      searchFieldProps: TextFieldProps(
                        autofocus: true,
                      ),
                      constraints: BoxConstraints(maxHeight: 250),
                    ),
                    selectedItem: provider.selectedRoomTypeData,
                    onChanged: (value) {
                      providerRead.setRoomTypeValue(value!);
                    },
                    dropdownBuilder: (BuildContext context, name) {
                      return Text(
                        name!.roomtypename!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.smallLightAshColorFontStyle,
                      );
                    },
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
                  'Register',
                  AppColors.primaryColor,
                  context,
                  ref,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
