import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/model/boarding_point_hive_model.dart';
import 'package:sample/home/main_pages/transport/model/route_hive_model.dart';
import 'package:sample/home/main_pages/transport/riverpod/transport_state.dart';
import 'package:sample/home/main_pages/transport/screens/transport.dart';
import 'package:sample/home/main_pages/transport/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class TransportRegisterPage extends ConsumerStatefulWidget {
  const TransportRegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransportRegisterPageState();
}

class _TransportRegisterPageState extends ConsumerState<TransportRegisterPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
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
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transportProvider.notifier).getRouteIdHiveDetails(
            '',
          );
      ref.read(transportProvider.notifier).getBoardingPointHiveDetails(
            '',
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transportProvider);
    final readProvider = ref.read(transportProvider.notifier);
    final width = MediaQuery.of(context).size.width;
    // log('status data in design>>>${provider.transportRegisterDetails!.status}, ${provider.transportRegisterDetails!.regconfig}');
    ref.listen(transportProvider, (previous, next) {
      if (next is TransportStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is TransportStateError) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
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
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const TransportTransactionPage(),
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
                'TRANSPORT',
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
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // scaffoldKey.currentState?.openEndDrawer();
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
          ],
        ),
      ),
      body: provider.transportRegisterDetails!.regconfig == '1' &&
              provider.transportRegisterDetails!.status == '0'
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
                              contentPadding:
                                  EdgeInsets.only(bottom: 2, top: 2),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width / 2 - 80,
                            child: const Text(
                              'Academicyear id',
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
                              '''${provider.transportAfterRegisterDetails!.academicyearid}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.academicyearid}''',
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
                              'Transport status',
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
                              '''${provider.transportAfterRegisterDetails!.transportstatus}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.transportstatus}''',
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
                              'Actives tatus',
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
                              '''${provider.transportAfterRegisterDetails!.activestatus}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.activestatus}''',
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
                              'Amount',
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
                              '''${provider.transportAfterRegisterDetails!.amount}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.amount}''',
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
                              'Application fees',
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
                              '''${provider.transportAfterRegisterDetails!.applicationfee}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.applicationfee}''',
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
                              'Boardingpoint name',
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
                              '''${provider.transportAfterRegisterDetails!.boardingpointname}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.boardingpointname}''',
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
                              'Busroute name',
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
                              '''${provider.transportAfterRegisterDetails!.busroutename}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.busroutename}''',
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
                              'Controller id',
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
                              '''${provider.transportAfterRegisterDetails!.controllerid}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.controllerid}''',
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
                              'Office id',
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
                              '''${provider.transportAfterRegisterDetails!.officeid}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.officeid}''',
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
                              'Regconfig',
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
                              '''${provider.transportAfterRegisterDetails!.regconfig}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.regconfig}''',
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
                              'Registration date',
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
                              '''${provider.transportAfterRegisterDetails!.registrationdate}''' ==
                                      ''
                                  ? '-'
                                  : '''${provider.transportAfterRegisterDetails!.registrationdate}''',
                              style: TextStyles.fontStyle10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
