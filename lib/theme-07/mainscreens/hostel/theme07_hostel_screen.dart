import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/theme-07/mainscreens/hostel/theme_02_hostel_button_style.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07HostelPage extends ConsumerStatefulWidget {
  const Theme07HostelPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07HostelPageState();
}

class _Theme07HostelPageState extends ConsumerState<Theme07HostelPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  // static int refreshNum = 10;
  // Stream<int> counterStream =
  //     Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(hostelProvider).toString().isNotEmpty
      //     ? ref.read(hostelProvider.notifier).getAfterHostelRegisterDetailsHive(
      //           '',
      //         )
      //     : ref.read(hostelProvider.notifier).getHostelRegisterDetails(
      //           ref.read(encryptionProvider.notifier),
      //         );
      ref.read(hostelProvider.notifier).getHostelRegisterDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is HostelStateSuccessful) {
      //   /// Handle route to next page.

      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });

    log('Regconfig: ${provider.hostelRegisterDetails!.regconfig}\nStatus: ${provider.hostelRegisterDetails!.status}');
    log('Condition 1: ${provider.hostelRegisterDetails.regconfig == '1' && provider.hostelRegisterDetails.status == '0'}');
    log('Condition 2: ${provider.hostelRegisterDetails.regconfig == '1' && provider.hostelRegisterDetails.status == '1'}');

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
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
          title: Text(
            'HOSTEL',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(hostelProvider.notifier).getHostelRegisterDetails(
                      ref.read(encryptionProvider.notifier),
                    );
              },
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.white,
              ),
            ),
          ],
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          if (provider is HostelStateLoading)
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            )
          else if (provider.hostelRegisterDetails.regconfig == '1' && provider.hostelRegisterDetails.status == '0')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Theme02ButtonDesign.buttonDesign(
                          'Registration',
                          Theme.of(context).colorScheme.primary,
                          context,
                          ref,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (provider is HostelStateLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    )
                  else if (provider.gethostelData.isEmpty && provider is! HostelStateLoading)
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 5,
                        ),
                        Center(
                          child: Text(
                            '',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.inverseSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  // if (provider.gethostelData.isNotEmpty)
                  //   ListView.builder(
                  //     itemCount: provider.gethostelData.length,
                  //     controller: _listController,
                  //     shrinkWrap: true,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return cardDesign(index);
                  //     },
                  //   ),
                ],
              ),
            )
          else if (provider.hostelRegisterDetails.regconfig == '1' && provider.hostelRegisterDetails.status == '1')
            ListView.builder(
              itemCount: 1,
              controller: _listController,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return cardDesign(index);
              },
            )
          else
            Expanded(
              child: Center(
                child: Text(
                  'Hostel Not Registered',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.inverseSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(hostelProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildRow(
              'Hostel',
              provider.hostelRegisterDetails.hostel!.isEmpty ? '-' : '${provider.hostelRegisterDetails.hostel}',
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
              provider.hostelRegisterDetails.roomtype!.isEmpty ? '-' : '${provider.hostelRegisterDetails.roomtype}',
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
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            ':',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.inverseSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.inverseSurface,
              fontWeight: FontWeight.bold,
            ),
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
}
