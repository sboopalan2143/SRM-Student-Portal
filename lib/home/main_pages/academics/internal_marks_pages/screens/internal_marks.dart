import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/internal_marks_pages/riverpod/internal_marks_state.dart';
import 'package:sample/home/main_pages/academics/screens/academics.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class InternalMarksPage extends ConsumerStatefulWidget {
  const InternalMarksPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InternalMarksPageState();
}

class _InternalMarksPageState extends ConsumerState<InternalMarksPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(internalMarksProvider.notifier).getHiveinternalmark('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(internalMarksProvider.notifier).getInternalMarksDetails(
      //       ref.read(encryptionProvider.notifier),
      //     );
      ref.read(internalMarksProvider.notifier).getHiveinternalmark('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(internalMarksProvider);
    ref.listen(internalMarksProvider, (previous, next) {
      if (next is InternalMarksStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      // else if (next is InternalMarksStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
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
                      route: const AcademicsPage(),
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
                'INTERNAL MARKS',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(internalMarksProvider.notifier)
                              .getHiveinternalmark('');
                        },
                        child: const Icon(
                          Icons.refresh,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: AppColors.whiteColor,
              //       borderRadius: BorderRadius.circular(7),
              //       border: Border.all(
              //         color: AppColors.grey2,
              //       ),
              //     ),
              //     height: 40,
              //     child: DropdownSearch<String>(
              //       // dropdownButtonProps: DropdownButtonProps(
              //       //   focusNode: widget.focusNodeC,
              //       // ),
              //       dropdownDecoratorProps: const DropDownDecoratorProps(
              //         dropdownSearchDecoration: InputDecoration(
              //           border: InputBorder.none,
              //           contentPadding:
              //               EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              //         ),
              //       ),
              //       itemAsString: (item) => item,
              //       items: name,
              //       popupProps: const PopupProps.menu(
              //         searchFieldProps: TextFieldProps(
              //           autofocus: true,
              //         ),
              //         constraints: BoxConstraints(maxHeight: 250),
              //       ),
              //       selectedItem: selectedValue,
              //       onChanged: (value) {
              //         // readProvider.selectCustomer(value!);
              //         setState(() {
              //           selectedValue = value!;
              //         });
              //       },
              //       dropdownBuilder: (BuildContext context, name) {
              //         return Text(
              //           name!,
              //           maxLines: 1,
              //           overflow: TextOverflow.ellipsis,
              //           style: TextStyles.smallLightAshColorFontStyle,
              //         );
              //       },
              //     ),
              //   ),
              // ),
              // Center(
              //   child: Text(
              //     '2nd Year, 4th Sem',
              //     style: TextStyles.smallPrimaryColorFontStyle,
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ListView.builder(
                  itemCount: provider.internalMarkHiveData.length,
                  controller: _listController,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return cardDesign(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(internalMarksProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Code',
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
                      '${provider.internalMarkHiveData[index].subjectcode}' ==
                              ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].subjectcode}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Subject',
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
                      '${provider.internalMarkHiveData[index].subjectdesc}' ==
                              ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].subjectdesc}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Mark',
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
                      '${provider.internalMarkHiveData[index].sumofmarks}' == ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].sumofmarks}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: const Text(
                      'Max Marks',
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
                      '${provider.internalMarkHiveData[index].sumofmaxmarks}' ==
                              ''
                          ? '-'
                          : '${provider.internalMarkHiveData[index].sumofmaxmarks}',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
            ],
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
