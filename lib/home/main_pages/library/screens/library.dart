import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/library/screens/view.dart';
import 'package:sample/home/screen/home_page.dart';
import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(libraryProvider.notifier).getLibraryMemberDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(libraryProvider);
    ref.listen(libraryProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
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
                  route: const HomePage(),
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
            'LIBRARY',
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            RouteDesign(route: const ViewLibraryPage()),
                          );
                        },
                        child: const Text(
                          'Book Search',
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: const Text(
            //         'Member Name',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //     const Text(
            //       ':',
            //       style: TextStyles.fontStyle10,
            //     ),
            //     const SizedBox(width: 5),
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: Text(
            //         // '${provider.libraryMemberData.membername}' == ''
            //         //     ? '-'
            //         //     : '${provider.libraryMemberData.membername}',

            //         '',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: const Text(
            //         'Member Code',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //     const Text(
            //       ':',
            //       style: TextStyles.fontStyle10,
            //     ),
            //     const SizedBox(width: 5),
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: Text(
            //         // '${provider.libraryMemberData.membercode}' == ''
            //         //     ? '-'
            //         //     : '${provider.libraryMemberData.membercode}',

            //         '',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: const Text(
            //         'Member Type',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //     const Text(
            //       ':',
            //       style: TextStyles.fontStyle10,
            //     ),
            //     const SizedBox(width: 5),
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: Text(
            //         // '${provider.libraryMemberData.membertype}' == ''
            //         //     ? '-'
            //         //     : '${provider.libraryMemberData.membertype}',

            //         '',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: const Text(
            //         'Policy Name',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //     const Text(
            //       ':',
            //       style: TextStyles.fontStyle10,
            //     ),
            //     const SizedBox(width: 5),
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: Text(
            //         // '${provider.libraryMemberData.policyname}' == ''
            //         //     ? '-'
            //         //     : '${provider.libraryMemberData.policyname}',

            //         '',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: const Text(
            //         'Status',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //     const Text(
            //       ':',
            //       style: TextStyles.fontStyle10,
            //     ),
            //     const SizedBox(width: 5),
            //     SizedBox(
            //       width: width / 2 - 100,
            //       child: Text(
            //         // '${provider.libraryMemberData.status}' == ''
            //         //     ? '-'
            //         //     : '${provider.libraryMemberData.status}',
            //         '',
            //         style: TextStyles.fontStyle10,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 20),
            if (provider is LibraryTrancsactionStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child:
                      CircularProgressIndicators.primaryColorProgressIndication,
                ),
              )
            else if (provider.libraryTransactionData.isEmpty &&
                provider is! LibraryTrancsactionStateLoading)
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
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
                itemCount: provider.libraryTransactionData.length,
                controller: _listController,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return cardDesign(index);
                },
              ),
          ],
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(libraryProvider);
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
                    child: Text(
                      '${provider.libraryTransactionData[index].membername}' ==
                              ''
                          ? '-'
                          : '''${provider.libraryTransactionData[index].membername}''',
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
                    child: Text(
                      '${provider.libraryTransactionData[index].membercode}' ==
                              ''
                          ? '-'
                          : '''${provider.libraryTransactionData[index].membercode}''',
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
                    child: Text(
                      '${provider.libraryTransactionData[index].membertype}' ==
                              ''
                          ? '-'
                          : '''${provider.libraryTransactionData[index].membertype}''',
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
                    child: Text(
                      '${provider.libraryTransactionData[index].status}' == ''
                          ? '-'
                          : '${provider.libraryTransactionData[index].status}',
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
