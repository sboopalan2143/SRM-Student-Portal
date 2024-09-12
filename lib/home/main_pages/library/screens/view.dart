import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/library/screens/library.dart';
import 'package:sample/home/main_pages/library/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/screen/home_page.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class ViewLibraryPage extends ConsumerStatefulWidget {
  const ViewLibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewLibraryPageState();
}

class _ViewLibraryPageState extends ConsumerState<ViewLibraryPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(libraryProvider);
    ref.listen(libraryProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
        Navigator.push(
          context,
          RouteDesign(
            route: const HomePage(),
          ),
        );
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
                  route: const LibraryPage(),
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
            'BOOK SEARCH',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'filter',
                    style: TextStyles.fontStyle2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: provider.filter,
                      style: TextStyles.fontStyle2,
                      decoration: InputDecoration(
                        hintText: 'filter',
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
              const SizedBox(height: 40),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (provider is LibraryTrancsactionStateLoading)
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: CircularProgressIndicators
                              .primaryColorProgressIndication,
                        ),
                      )
                    else if (provider.libraryTransactionData.isEmpty &&
                        provider is! LibraryTrancsactionStateLoading)
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 5),
                          const Center(
                            child: Text(
                              'No List Added Yet!',
                              style: TextStyles.fontStyle1,
                            ),
                          ),
                        ],
                      ),
                    if (provider.libraryTransactionData.isNotEmpty)
                      ListView.builder(
                        itemCount: 2,
                        controller: _listController,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return cardDesign(index);
                        },
                      ),
                  ],
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
                    width: width / 2 - 80,
                    child: const Text(
                      'Member Name',
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
                    child: const Text(
                      'text',
                      // '${provider.libraryTransactionData[index].membername}' ==
                      //         ''
                      //     ? '-'
                      //     : '''${provider.libraryTransactionData[index].membername}''',
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
                      'Member Code',
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
                    child: const Text(
                      'text',
                      // '${provider.libraryTransactionData[index].membercode}' ==
                      //         ''
                      //     ? '-'
                      //     : '''${provider.libraryTransactionData[index].membercode}''',
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
                      'Member Type',
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
                    child: const Text(
                      'text',
                      // '${provider.libraryTransactionData[index].membertype}' ==
                      //         ''
                      //     ? '-'
                      //     : '''${provider.libraryTransactionData[index].membertype}''',
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
                      'Status',
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
                    child: const Text(
                      'text',
                      // '${provider.libraryTransactionData[index].status}' == ''
                      //     ? '-'
                      //     : '${provider.libraryTransactionData[index].status}',
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
