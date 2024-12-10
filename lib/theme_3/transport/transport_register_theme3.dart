import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/model/boarding_point_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/route_hive_model.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';

class TransportRegisterPageTheme3 extends ConsumerStatefulWidget {
  const TransportRegisterPageTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransportRegisterPageTheme3State();
}

class _TransportRegisterPageTheme3State
    extends ConsumerState<TransportRegisterPageTheme3> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(transportProvider.notifier).getTransportStatusDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref
            .read(transportProvider.notifier)
            .getTransportStatusHiveDetails('');
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
        await ref
            .read(transportProvider.notifier)
            .getTransportHiveRegisterDetails('');
        await ref
            .read(transportProvider.notifier)
            .getTransportHiveAfterRegisterDetails('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transportProvider.notifier).getTransportStatusHiveDetails('');
      ref.read(transportProvider.notifier).getRouteIdHiveDetails(
            '',
          );
      ref.read(transportProvider.notifier).getBoardingPointHiveDetails(
            '',
          );
      ref.read(transportProvider.notifier).getTransportHiveRegisterDetails('');
      ref
          .read(transportProvider.notifier)
          .getTransportHiveAfterRegisterDetails('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transportProvider);
    final readProvider = ref.read(transportProvider.notifier);
    final width = MediaQuery.of(context).size.width;
    ref.listen(transportProvider, (previous, next) {
      if (next is TransportStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is TransportStateError) {
        _showToast(context, next.successMessage, AppColors.greenColorTheme3);
      }
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
                  ZoomDrawer.of(context)!.toggle();
                },
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'TRANSPORT',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: GestureDetector(
                        onTap: () async {
                          await ref
                              .read(transportProvider.notifier)
                              .getTransportStatusDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(transportProvider.notifier)
                              .getTransportStatusHiveDetails('');
                          await ref
                              .read(transportProvider.notifier)
                              .getRouteIdDetails(
                                ref.read(encryptionProvider.notifier),
                              );

                          await ref
                              .read(transportProvider.notifier)
                              .getRouteIdHiveDetails(
                                '',
                              );
                          await ref
                              .read(transportProvider.notifier)
                              .getBoardingIdDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(transportProvider.notifier)
                              .getBoardingPointHiveDetails(
                                '',
                              );
                          await ref
                              .read(transportProvider.notifier)
                              .gettransportRegisterDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                          await ref
                              .read(transportProvider.notifier)
                              .getTransportHiveRegisterDetails('');
                          await ref
                              .read(transportProvider.notifier)
                              .getTransportHiveAfterRegisterDetails('');
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      body: (provider.transportRegisterDetails!.regconfig == '1' &&
                  provider.transportRegisterDetails!.status == '0') ||
              (provider.transportAfterRegisterDetails!.regconfig == '1' &&
                  provider.transportAfterRegisterDetails!.status == '0')
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                children: [
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
                              contentPadding:
                                  EdgeInsets.only(bottom: 2, top: 2),
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
                          dropdownBuilder:
                              (BuildContext context, routedetails) {
                            return Text(
                              '''  ${routedetails?.busroutename}''',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  if (provider
                      .selectedRouteDetailsDataList.busrouteid!.isNotEmpty)
                    const SizedBox(height: 10),
                  if (provider
                      .selectedRouteDetailsDataList.busrouteid!.isNotEmpty)
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
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                // border: BorderRadius.circular(10),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(bottom: 2, top: 2),
                              ),
                            ),
                            itemAsString: (item) => item.boardingpointname!,
                            items: provider.boardingPointDataList,
                            popupProps: const PopupProps.menu(
                              constraints: BoxConstraints(maxHeight: 250),
                            ),
                            selectedItem:
                                provider.selectedBoardingPointDataList,
                            onChanged: (value) {
                              readProvider.setBorderRoute(
                                value!,
                              );
                            },
                            dropdownBuilder:
                                (BuildContext context, borderpoint) {
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
                            await ref
                                .read(transportProvider.notifier)
                                .gettransportRegisterDetails(
                                  ref.read(encryptionProvider.notifier),
                                );
                            await ref
                                .read(transportProvider.notifier)
                                .getRouteIdDetails(
                                  ref.read(encryptionProvider.notifier),
                                );

                            await ref
                                .read(transportProvider.notifier)
                                .saveTransportstatusDetails(
                                  ref.read(
                                    encryptionProvider.notifier,
                                  ),
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
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width / 2,
                            child: Text(
                              '''${provider.transportAfterRegisterDetails!.activestatus}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.activestatus}''',
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width / 4,
                            child: Text(
                              '''${provider.transportAfterRegisterDetails!.amount}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.amount}''',
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.greenColorTheme3,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width / 2,
                                child: const Text(
                                  'Boardingpoint',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                width: width * 0.80,
                                child: Text(
                                  '''${provider.transportAfterRegisterDetails!.boardingpointname}''' ==
                                          ''
                                      ? '-'
                                      : '''${provider.transportAfterRegisterDetails!.boardingpointname}''',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: AppColors.grey4,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 2,
                            child: const Text(
                              'Busroute',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.85,
                            child: Text(
                              '''${provider.transportAfterRegisterDetails!.busroutename}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.busroutename}''',
                              style: const TextStyle(
                                fontSize: 18,
                                color: AppColors.grey4,
                                fontWeight: FontWeight.bold,
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
                            width: width / 2 - 50,
                            child: const Text(
                              'Registration date',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            ':',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.grey4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: width / 2 - 60,
                            child: Text(
                              '''${provider.transportAfterRegisterDetails!.registrationdate}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.registrationdate}''',
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.grey4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
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
