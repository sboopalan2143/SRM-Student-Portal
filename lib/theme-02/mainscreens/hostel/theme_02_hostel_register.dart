import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_hive_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';
import 'package:sample/theme-02/mainscreens/hostel/theme_02_hostel_leave_application.dart';

class Theme02RegistrationPage extends ConsumerStatefulWidget {
  const Theme02RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02RegistrationPageState();
}

class _Theme02RegistrationPageState
    extends ConsumerState<Theme02RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(hostelProvider.notifier).getAfterHostelRegisterDetailsHive('');
      // ref.read(hostelProvider.notifier).getBeforeHostelRegisterDetailsHive('');
      // try {
      //   ref
      //       .read(hostelProvider.notifier)
      //       .getBeforeHostelRegisterDetailsHive('');
      // } catch (e) {
      //   print('An error occurred: $e');
      // }

      ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      ref.read(hostelProvider.notifier).getRoomTypeHiveData('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    final width = MediaQuery.of(context).size.width;
    log('Regconfig  : ${provider.hostelRegisterDetails!.regconfig}');
    log('status  : ${provider.hostelRegisterDetails!.status}');
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme02primaryColor,
                  AppColors.theme02secondaryColor1,
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
            'REGISTRATION',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: provider.hostelRegisterDetails!.regconfig == '0'
          ? registrationForm()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Material(
                elevation: 5,
                shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.theme02primaryColor,
                            AppColors.theme02secondaryColor1,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              SizedBox(
                                width: width / 2 - 100,
                                child: const Text(
                                  'hostel :',
                                  style: TextStyles.fontStyle1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '''${provider.hostelAfterRegisterDetails!.hostel}''' ==
                                          ''
                                      ? '-'
                                      : '''${provider.hostelAfterRegisterDetails!.hostel}''',
                                  style: TextStyles.fontStyle1,
                                ),
                              ),
                            ],
                          ),
                          collapsedIconColor: AppColors.whiteColor,
                          iconColor: AppColors.whiteColor,
                          children: [
                            Divider(
                              color: AppColors.theme01primaryColor
                                  .withOpacity(0.5),
                            ),
                            _buildRow(
                              'Hostel fee amount :',
                              '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''',
                              width,
                            ),
                            _buildRow(
                              'Registration date',
                              '''${provider.hostelAfterRegisterDetails!.registrationdate}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.hostelAfterRegisterDetails!.registrationdate}''',
                              width,
                            ),
                            _buildRow(
                              'Caution deposit amt',
                              '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''',
                              width,
                            ),
                            _buildRow(
                              'Room type :',
                              '''${provider.hostelAfterRegisterDetails!.roomtype}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.hostelAfterRegisterDetails!.roomtype}''',
                              width,
                            ),
                            _buildRow(
                              'Active status',
                              '''${provider.hostelAfterRegisterDetails!.activestatus}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.hostelAfterRegisterDetails!.activestatus}''',
                              width,
                            ),
                            _buildRow(
                              'Active status',
                              '''${provider.hostelAfterRegisterDetails!.messfeeamount}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.hostelAfterRegisterDetails!.messfeeamount}''',
                              width,
                            ),
                            _buildRow(
                              'Active status',
                              '''${provider.hostelAfterRegisterDetails!.applnfeeamount}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.hostelAfterRegisterDetails!.applnfeeamount}''',
                              width,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                        backgroundColor: AppColors.theme02buttonColor2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          RouteDesign(
                            route: const Theme02LeaveApplicationPage(),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Leave Application',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

      //  provider is HostelStateLoading
      //     ? Padding(
      //         padding: const EdgeInsets.only(top: 100),
      //         child: Center(
      //           child:
      //               CircularProgressIndicators.primaryColorProgressIndication,
      //         ),
      //       )
      //     : provider.hostelRegisterDetails!.status == '0' &&
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
      //                       AppColors.theme02primaryColor,
      //                       AppColors.theme02secondaryColor1,
      //                     ],
      //                     begin: Alignment.topCenter,
      //                     end: Alignment.bottomCenter,
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
      //                           child: const Text(
      //                             'hostel :',
      //                             style: TextStyles.fontStyle1,
      //                           ),
      //                         ),
      //                         Expanded(
      //                           child: Text(
      //                             '''${provider.hostelAfterRegisterDetails!.hostel}''' ==
      //                                     ''
      //                                 ? '-'
      //                                 : '''${provider.hostelAfterRegisterDetails!.hostel}''',
      //                             style: TextStyles.fontStyle1,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     collapsedIconColor: AppColors.whiteColor,
      //                     iconColor: AppColors.whiteColor,
      //                     children: [
      //                       Divider(
      //                         color: AppColors.theme01primaryColor
      //                             .withOpacity(0.5),
      //                       ),
      //                       _buildRow(
      //                         'Hostel fee amount :',
      //                         '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''' ==
      //                                 ''
      //                             ? '-'
      //                             : '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''',
      //                         width,
      //                       ),
      //                       _buildRow(
      //                         'Registration date',
      //                         '''${provider.hostelAfterRegisterDetails!.registrationdate}''' ==
      //                                 ''
      //                             ? '-'
      //                             : '''${provider.hostelAfterRegisterDetails!.registrationdate}''',
      //                         width,
      //                       ),
      //                       _buildRow(
      //                         'Caution deposit amt',
      //                         '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''' ==
      //                                 ''
      //                             ? '-'
      //                             : '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''',
      //                         width,
      //                       ),
      //                       _buildRow(
      //                         'Room type :',
      //                         '''${provider.hostelAfterRegisterDetails!.roomtype}''' ==
      //                                 ''
      //                             ? '-'
      //                             : '''${provider.hostelAfterRegisterDetails!.roomtype}''',
      //                         width,
      //                       ),
      //                       _buildRow(
      //                         'Active status',
      //                         '''${provider.hostelAfterRegisterDetails!.activestatus}''' ==
      //                                 ''
      //                             ? '-'
      //                             : '''${provider.hostelAfterRegisterDetails!.activestatus}''',
      //                         width,
      //                       ),
      //                       _buildRow(
      //                         'Active status',
      //                         '''${provider.hostelAfterRegisterDetails!.messfeeamount}''' ==
      //                                 ''
      //                             ? '-'
      //                             : '''${provider.hostelAfterRegisterDetails!.messfeeamount}''',
      //                         width,
      //                       ),
      //                       _buildRow(
      //                         'Active status',
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
            style: TextStyles.fontStyle1,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle1,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle1,
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
                style: TextStyles.fontStyle1,
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
                style: TextStyles.fontStyle1,
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
