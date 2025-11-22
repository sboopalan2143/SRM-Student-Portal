import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/model/boarding_point_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/route_hive_model.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07TransportRegisterPage extends ConsumerStatefulWidget {
  const Theme07TransportRegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07TransportRegisterPageState();
}

class _Theme07TransportRegisterPageState extends ConsumerState<Theme07TransportRegisterPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(transportProvider.notifier).getTransportStatusDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getTransportStatusHiveDetails('');
        await ref.read(transportProvider.notifier).getRouteIdDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getRouteIdHiveDetails(
              '',
            );
        await ref.read(transportProvider.notifier).getBoardingIdDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getBoardingPointHiveDetails(
              '',
            );
        await ref.read(transportProvider.notifier).gettransportRegisterDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(transportProvider.notifier).getTransportHiveRegisterDetails('');
        await ref.read(transportProvider.notifier).getTransportHiveAfterRegisterDetails('');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transportProvider);
    final readProvider = ref.read(transportProvider.notifier);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    log('Regconfig: ${provider.transportAfterRegisterDetails!.regconfig}\nStatus: ${provider.transportAfterRegisterDetails!.status}');

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
            'TRANSPORT',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: (provider.transportAfterRegisterDetails!.status == '0' &&
              provider.transportAfterRegisterDetails!.regconfig == '0')
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
          : (provider.transportAfterRegisterDetails!.status == '0' &&
                  provider.transportAfterRegisterDetails!.regconfig == '1')
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Busroute ID',
                            style: TextStyles.fontStyle2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: AppColors.grey2,
                              ),
                            ),
                            height: 40,
                            child: DropdownSearch<RouteDetailsHiveData>(
                              dropdownDecoratorProps: const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  // border: BorderRadius.circular(10),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                                ),
                              ),
                              itemAsString: (item) => item.busroutename!,
                              items: provider.routeDetailsDataList,
                              popupProps: const PopupProps.menu(
                                constraints: BoxConstraints(maxHeight: 250),
                              ),
                              selectedItem: provider.selectedRouteDetailsDataList,
                              onChanged: (value) {
                                readProvider.setsubtype(
                                  value!,
                                  ref.read(encryptionProvider.notifier),
                                );
                              },
                              dropdownBuilder: (BuildContext context, routedetails) {
                                return Text(
                                  ''' ${routedetails?.busroutename} ''',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      if (provider.selectedRouteDetailsDataList.busrouteid!.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Boardingpoint ID',
                              style: TextStyles.fontStyle2,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(
                                  color: AppColors.grey2,
                                ),
                              ),
                              height: 40,
                              child: DropdownSearch<BoardingPointHiveData>(
                                dropdownDecoratorProps: const DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    // border: BorderRadius.circular(10),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                                  ),
                                ),
                                itemAsString: (item) => item.boardingpointname!,
                                items: provider.boardingPointDataList,
                                popupProps: const PopupProps.menu(
                                  constraints: BoxConstraints(maxHeight: 250),
                                ),
                                selectedItem: provider.selectedBoardingPointDataList,
                                onChanged: (value) {
                                  readProvider.setBorderRoute(
                                    value!,
                                  );
                                },
                                dropdownBuilder: (BuildContext context, borderpoint) {
                                  return Text(
                                    '''  ${borderpoint?.boardingpointname}''',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10),
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
                                backgroundColor: AppColors.greenColor,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () async {
                                await ref.read(transportProvider.notifier).saveTransportstatusDetails(
                                      ref.read(
                                        encryptionProvider.notifier,
                                      ),
                                    );
                                await ref.read(transportProvider.notifier).gettransportRegisterDetails(
                                      ref.read(encryptionProvider.notifier),
                                    );
                                await ref.read(transportProvider.notifier).getRouteIdDetails(
                                      ref.read(encryptionProvider.notifier),
                                    );
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            //  ButtonDesign.buttonDesign(
                            //   'Submit',
                            //   AppColors.primaryColorTheme3,
                            //   context,
                            //   ref.read(mainProvider.notifier),
                            //   ref,
                            // ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              // Center(
              //     child: Text(
              //       'Transport Not Registered',
              //       style: TextStyle(
              //         fontSize: 18,
              //         color: Theme.of(context).colorScheme.inverseSurface,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   )
              : (provider.transportAfterRegisterDetails!.status == '1' &&
                      provider.transportAfterRegisterDetails!.regconfig == '1')
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          if (provider.transportAfterRegisterDetails!.busroutename == '')
                            Center(
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
                          if (provider.transportAfterRegisterDetails!.busroutename != '') ...[
                            Card(
                              color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow(
                                      Icons.directions_bus,
                                      'Bus Route :',
                                      provider.transportAfterRegisterDetails!.busroutename,
                                    ),
                                    _buildInfoRow(
                                      Icons.location_on,
                                      'Point :',
                                      provider.transportAfterRegisterDetails!.boardingpointname,
                                    ),
                                    _buildInfoRow(
                                      Icons.date_range,
                                      'Date :',
                                      provider.transportAfterRegisterDetails!.registrationdate,
                                    ),
                                    _buildInfoRow(
                                      Icons.monetization_on,
                                      'Bus Fee :',
                                      provider.transportAfterRegisterDetails!.amount,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String? value) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: 10),
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
              (value == null || value.isEmpty) ? '-' : value,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.inverseSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
