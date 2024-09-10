import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/transport/model/border_point_model.dart';
import 'package:sample/home/main_pages/transport/model/route_model.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transportProvider.notifier).getBorderIdDetails(
            ref.read(encryptionProvider.notifier),
          );
      ref.read(transportProvider.notifier).getRouteIdDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(transportProvider);

    final readProvider = ref.read(transportProvider.notifier);
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
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 40,
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
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text(
            'TRANSPORT',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Student ID',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.studentId,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      hintText: 'Enter Student ID',
                      hintStyle: TextStyles.smallLightAshColorFontStyle,
                      filled: true,
                      fillColor: AppColors.secondaryColor,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Academicyear ID',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.academicyearId,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      hintText: 'Enter Academicyear ID',
                      hintStyle: TextStyles.smallLightAshColorFontStyle,
                      filled: true,
                      fillColor: AppColors.secondaryColor,
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
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Text(
            //       'Boardingpoint ID',
            //       style: TextStyles.fontStyle2,
            //     ),
            //     const SizedBox(
            //       height: 5,
            //     ),
            //     SizedBox(
            //       height: 40,
            //       child: TextField(
            //         controller: provider.boardingpointId,
            //         style: TextStyles.fontStyle2,
            //         decoration: InputDecoration(
            //           hintText: 'Enter Boardingpoint ID',
            //           hintStyle: TextStyles.smallLightAshColorFontStyle,
            //           filled: true,
            //           fillColor: AppColors.secondaryColor,
            //           contentPadding: const EdgeInsets.all(10),
            //           enabledBorder:
            //               BorderBoxButtonDecorations.loginTextFieldStyle,
            //           focusedBorder:
            //               BorderBoxButtonDecorations.loginTextFieldStyle,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
                  child: DropdownSearch<BorderPointData>(
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        // border: BorderRadius.circular(10),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 2, top: 2),
                      ),
                    ),
                    itemAsString: (item) => item.boardingpointname!,
                    items: provider.borderpointDataList,
                    popupProps: const PopupProps.menu(
                      constraints: BoxConstraints(maxHeight: 250),
                    ),
                    selectedItem: provider.selectedborderpointDataList,
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
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Text(
            //       'Busroute ID',
            //       style: TextStyles.fontStyle2,
            //     ),
            //     const SizedBox(
            //       height: 5,
            //     ),
            //     SizedBox(
            //       height: 40,
            //       child: TextField(
            //         controller: provider.busrouteId,
            //         style: TextStyles.fontStyle2,
            //         decoration: InputDecoration(
            //           hintText: 'Enter Busroute ID',
            //           hintStyle: TextStyles.smallLightAshColorFontStyle,
            //           filled: true,
            //           fillColor: AppColors.secondaryColor,
            //           contentPadding: const EdgeInsets.all(10),
            //           enabledBorder:
            //               BorderBoxButtonDecorations.loginTextFieldStyle,
            //           focusedBorder:
            //               BorderBoxButtonDecorations.loginTextFieldStyle,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
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
                  child: DropdownSearch<RouteDetailsData>(
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
                      );
                    },
                    dropdownBuilder: (BuildContext context, routedetails) {
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
                  'Controller ID',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.controllerId,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      hintText: 'Enter Controller ID',
                      hintStyle: TextStyles.smallLightAshColorFontStyle,
                      filled: true,
                      fillColor: AppColors.secondaryColor,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Office ID',
                  style: TextStyles.fontStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 40,
                  child: TextField(
                    controller: provider.officeId,
                    style: TextStyles.fontStyle2,
                    decoration: InputDecoration(
                      hintText: 'Enter Office ID',
                      hintStyle: TextStyles.smallLightAshColorFontStyle,
                      filled: true,
                      fillColor: AppColors.secondaryColor,
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
