import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/hostel/model/hostel_hive_model.dart';
import 'package:sample/home/main_pages/hostel/model/room_type_hive_model.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07RegistrationPage extends ConsumerStatefulWidget {
  const Theme07RegistrationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07RegistrationPageState();
}

class _Theme07RegistrationPageState extends ConsumerState<Theme07RegistrationPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(hostelProvider.notifier).getHostelRegisterDetails(ref.read(encryptionProvider.notifier));
      ref.read(hostelProvider.notifier).gethostel(ref.read(encryptionProvider.notifier));

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
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
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          elevation: 0,
          title: Text(
            'REGISTRATION',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: (provider.hostelRegisterDetails.regconfig == '1' && provider.hostelRegisterDetails.status == '0')
          ? registrationForm()
          : (provider.hostelRegisterDetails.regconfig == '1' && provider.hostelRegisterDetails.status == '1')
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                      child: Material(
                        elevation: 5,
                        // shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: pro.Provider.of<ThemeProvider>(context).isDarkMode
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
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
                                  _buildRow(
                                    'Hostel fee amount',
                                    provider.hostelRegisterDetails.hostelfeeamount!.isEmpty
                                        ? '-'
                                        : '${provider.hostelRegisterDetails.hostelfeeamount}',
                                    width,
                                  ),
                                  _buildRow(
                                    'Registration date',
                                    provider.hostelRegisterDetails.registrationdate!.isEmpty
                                        ? '-'
                                        : '${provider.hostelRegisterDetails.registrationdate}',
                                    width,
                                  ),
                                  _buildRow(
                                    'Caution deposit amt',
                                    provider.hostelRegisterDetails.cautiondepositamt!.isEmpty
                                        ? '-'
                                        : '${provider.hostelRegisterDetails.cautiondepositamt}',
                                    width,
                                  ),
                                  _buildRow(
                                    'Room type',
                                    provider.hostelRegisterDetails.roomtype!.isEmpty
                                        ? '-'
                                        : '${provider.hostelRegisterDetails.roomtype}',
                                    width,
                                  ),
                                  _buildRow(
                                    'Active status',
                                    provider.hostelRegisterDetails.activestatus!.isEmpty
                                        ? '-'
                                        : '${provider.hostelRegisterDetails.activestatus}',
                                    width,
                                  ),
                                  _buildRow(
                                    'Mess fee amount',
                                    provider.hostelRegisterDetails.messfeeamount!.isEmpty
                                        ? '-'
                                        : '${provider.hostelRegisterDetails.messfeeamount}',
                                    width,
                                  ),
                                  _buildRow(
                                    'Application fee amount',
                                    provider.hostelRegisterDetails.applnfeeamount!.isEmpty
                                        ? '-'
                                        : '${provider.hostelRegisterDetails.applnfeeamount}',
                                    width,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : (provider.hostelRegisterDetails.regconfig == '0' && provider.hostelRegisterDetails.status == '0')
                  ? Center(
                      child: Text(
                        'Please Contact Admin Ofiice to Enable Registration',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.inverseSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
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
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Expanded(
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
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.inverseSurface,
              fontWeight: FontWeight.bold,
            ),
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
              Text(
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
              Text(
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
