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

class Theme07RegistrationPage extends ConsumerStatefulWidget {
  const Theme07RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07RegistrationPageState();
}

class _Theme07RegistrationPageState
    extends ConsumerState<Theme07RegistrationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      ref
          .read(hostelProvider.notifier)
          .getHostelRegisterDetails(ref.read(encryptionProvider.notifier));

      ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      ref.read(hostelProvider.notifier).getRoomTypeHiveData('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    final width = MediaQuery.of(context).size.width;
    // ref.listen(hostelProvider, (previous, next) {
    //   if (next is HostelStateError) {
    //     _showToast(context, next.errorMessage, AppColors.redColor);
    //   } else if (next is HostelStateSuccessful) {
    //     _showToast(context, next.successMessage, AppColors.greenColor);
    //   }
    // });

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
            'REGISTRATION',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: provider.hostelRegisterDetails.status == '0'
          ? registrationForm()
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  child: Material(
                    elevation: 5,
                    shadowColor:
                        AppColors.theme01secondaryColor4.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient:const LinearGradient(
                              colors: [
                                AppColors.whiteColor,
                                AppColors.whiteColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //   'Hostel Details',
                                //   style: TextStyles.fontStyle1.copyWith(
                                //       fontSize: 18, fontWeight: FontWeight.bold),
                                // ),
                                // const SizedBox(height: 10),
                                _buildRow(
                                  'Hostel',
                                  provider.hostelRegisterDetails.hostel!.isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.hostel}',
                                  width,
                                ),
                                const Divider(),
                                _buildRow(
                                  'Hostel fee amount',
                                  provider.hostelRegisterDetails
                                          .hostelfeeamount!.isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.hostelfeeamount}',
                                  width,
                                ),
                                const Divider(),
                                _buildRow(
                                  'Registration date',
                                  provider.hostelRegisterDetails
                                          .registrationdate!.isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.registrationdate}',
                                  width,
                                ),
                                const Divider(),
                                _buildRow(
                                  'Caution deposit amt',
                                  provider.hostelRegisterDetails
                                          .cautiondepositamt!.isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.cautiondepositamt}',
                                  width,
                                ),
                                const Divider(),
                                _buildRow(
                                  'Room type',
                                  provider.hostelRegisterDetails.roomtype!
                                          .isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.roomtype}',
                                  width,
                                ),
                                const Divider(),
                                _buildRow(
                                  'Active status',
                                  provider.hostelRegisterDetails.activestatus!
                                          .isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.activestatus}',
                                  width,
                                ),
                                const Divider(),
                                _buildRow(
                                  'Mess fee amount',
                                  provider.hostelRegisterDetails.messfeeamount!
                                          .isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.messfeeamount}',
                                  width,
                                ),
                                const Divider(),
                                _buildRow(
                                  'Application fee amount',
                                  provider.hostelRegisterDetails.applnfeeamount!
                                          .isEmpty
                                      ? '-'
                                      : '${provider.hostelRegisterDetails.applnfeeamount}',
                                  width,
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ],
            ),

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
            style: TextStyles.smallerBlackColorFontStyle,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.smallerBlackColorFontStyle,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 20,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.smallerBlackColorFontStyle,
          ),
        ),
      ],
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
