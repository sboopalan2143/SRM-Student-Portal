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
import 'package:sample/theme_3/hostel/hostel_home_theme3.dart';
import 'package:sample/theme_3/hostel/hostel_page_theme.dart';

class RegistrationPageTheme3 extends ConsumerStatefulWidget {
  const RegistrationPageTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegistrationPageTheme3State();
}

class _RegistrationPageTheme3State
    extends ConsumerState<RegistrationPageTheme3> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(hostelProvider.notifier).getAfterHostelRegisterDetailsHive('');
      // ref.read(hostelProvider.notifier).getBeforeHostelRegisterDetailsHive('');
      ref.read(hostelProvider.notifier).getHostelNameHiveData('');
      ref.read(hostelProvider.notifier).getRoomTypeHiveData('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    final width = MediaQuery.of(context).size.width;
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
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColorTheme3,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const HostelHomeTheme3(),
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
                'REGISTRATION',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await ref
                            .read(hostelProvider.notifier)
                            .getHostelRegisterDetails(
                              ref.read(encryptionProvider.notifier),
                            );
                        // await ref
                        //     .read(hostelProvider.notifier)
                        //     .getBeforeHostelRegisterDetailsHive(
                        //       '',
                        //     );
                        // await ref
                        //     .read(hostelProvider.notifier)
                        //     .getAfterHostelRegisterDetailsHive(
                        //       '',
                        //     );
                      },
                      child: const Icon(
                        Icons.refresh,
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
      body: provider is HostelStateLoading
          ? Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child:
                    CircularProgressIndicators.primaryColorProgressIndication,
              ),
            )
          : (provider.hostelRegisterDetails!.status!.isEmpty ||
                      provider.hostelAfterRegisterDetails!.status!.isEmpty) &&
                  provider is! HostelStateLoading
              ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No Data!',
                        style: TextStyles.fontStyle,
                      ),
                    ),
                  ],
                )
              : (provider.hostelRegisterDetails!.status == '1' ||
                      provider.hostelAfterRegisterDetails!.status == '1')
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'Hostel',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.hostel}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.hostel}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'Hostel Fee Amount',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.hostelfeeamount}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'Registration Date',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.registrationdate}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.registrationdate}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'Caution Deposit Amount',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.cautiondepositamt}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'Room Type',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.roomtype}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.roomtype}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'Active Status',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.activestatus}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.activestatus}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'Mess Fee Amount',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.messfeeamount}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.messfeeamount}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 2 - 80,
                                    child: const Text(
                                      'App In-Fee Amount',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                  const Text(
                                    ':',
                                    style: TextStyles.fontStyle10,
                                  ),
                                  const SizedBox(width: 5),
                                  SizedBox(
                                    width: width / 2 - 60,
                                    child: Text(
                                      '''${provider.hostelAfterRegisterDetails!.applnfeeamount}''' ==
                                              ''
                                          ? '-'
                                          : '''${provider.hostelAfterRegisterDetails!.applnfeeamount}''',
                                      style: TextStyles.fontStyle10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : registrationForm(),
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    elevation: 0,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: AppColors.greenColorTheme3,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () {
                    ref
                        .read(hostelProvider.notifier)
                        .hostelRegister(ref.read(encryptionProvider.notifier));
                  },
                  child: const FittedBox(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // ButtonDesign.buttonDesign(
                //   'Register',
                //   AppColors.primaryColorTheme3,
                //   context,
                //   ref,
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
