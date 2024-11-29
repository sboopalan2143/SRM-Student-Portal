import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme_3/library/library_page.dart';

class LibraryBookSearchTheme3 extends ConsumerStatefulWidget {
  const LibraryBookSearchTheme3({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LibraryBookSearchTheme3State();
}

class _LibraryBookSearchTheme3State
    extends ConsumerState<LibraryBookSearchTheme3> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //   @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //      ref.read(libraryProvider.notifier).saveLibrartBookSearchDetails(
  //               ref.read(encryptionProvider.notifier),
  //             );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(libraryProvider);
    ref.listen(libraryProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      }
      //  else if (next is LibraryTrancsactionStateSuccessful) {
      //   _showToast(context, next.successMessage, AppColors.greenColor);
      // }
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.primaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                RouteDesign(
                  route: const LibraryPageTheme3(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryColorTheme3,
            ),
          ),
          backgroundColor: AppColors.secondaryColorTheme3,
          elevation: 0,
          title: Text(
            'BOOK SEARCH',
            style: TextStyle(
              fontSize: 22,
              color: AppColors.primaryColorTheme3,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                height: 40,
                child: TextField(
                  controller: provider.filter,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for Books',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppColors.whiteColor.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.whiteColor),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: AppColors.whiteColor.withOpacity(0.8),
                      ),
                      onPressed: () async {
                        final provider = ref.watch(libraryProvider);

                        if (provider.filter.text == '') {
                          Alerts.errorAlert(
                            message: 'Filter empty',
                            context: context,
                          );
                        } else if (provider.filter.text.length < 3) {
                          Alerts.errorAlert(
                            message: 'Enter Morethan 3 Characters',
                            context: context,
                          );
                        } else {
                          await ref
                              .read(libraryProvider.notifier)
                              .saveLibrartBookSearchDetails(
                                ref.read(encryptionProvider.notifier),
                              );
                        }
                        provider.filter.clear();
                      },
                    ),
                  ),
                ),
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
                            height: MediaQuery.of(context).size.height / 5,
                          ),
                          const Center(
                            child: Text(
                              'SEARCH LIST IS EMPTY',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (provider.libraryTransactionData.isNotEmpty)
                      ListView.builder(
                        itemCount: provider.librarysearchData.length,
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

    final provider = ref.watch(libraryProvider);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width / 2 - 80,
                child: const Icon(
                  Icons.menu_book,
                  color: AppColors.whiteColor,
                  size: 35,
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width * 0.35,
                child: Text(
                  '${provider.librarysearchData[index].title}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].title}''',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].accessionnumber}' ==
                          'null' ||
                      '${provider.librarysearchData[index].accessionnumber}' ==
                          ''
                  ? 'ACCESSION NUMBER  -'
                  : '''ACCESSION NUMBER - ${provider.librarysearchData[index].accessionnumber}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].authorname}' == 'null' ||
                      '${provider.librarysearchData[index].authorname}' == ''
                  ? 'AUTHOR NAME  -'
                  : '''AUTHOR NAME - ${provider.librarysearchData[index].authorname}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].publishername}' == 'null' ||
                      '${provider.librarysearchData[index].publishername}' == ''
                  ? 'PUBLISHER NAME  -'
                  : '''PUBLISHER NAME - ${provider.librarysearchData[index].publishername}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].department}' == 'null' ||
                      '${provider.librarysearchData[index].department}' == ''
                  ? 'DEPARTMENT  -'
                  : '''DEPARTMENT - ${provider.librarysearchData[index].department}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].booknumber}' == 'null' ||
                      '${provider.librarysearchData[index].booknumber}' == ''
                  ? 'BOOK NUMBER  -'
                  : '''BOOK NUMBER - ${provider.librarysearchData[index].booknumber}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].inhand}' == 'null' ||
                      '${provider.librarysearchData[index].inhand}' == ''
                  ? 'INHAND  -'
                  : '''INHAND - ${provider.librarysearchData[index].inhand}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].availability}' == 'null' ||
                      '${provider.librarysearchData[index].availability}' == ''
                  ? 'AVAILABILITY  -'
                  : '''AVAILABILITY - ${provider.librarysearchData[index].availability}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].borrow}' == 'null' ||
                      '${provider.librarysearchData[index].borrow}' == ''
                  ? 'BORROW  -'
                  : '''BORROW - ${provider.librarysearchData[index].borrow}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].classificationNumber}' ==
                          'null' ||
                      '${provider.librarysearchData[index].classificationNumber}' ==
                          ''
                  ? 'CLASSIFICATION NUMBER  -'
                  : '''CLASSIFICATION NUMBER - ${provider.librarysearchData[index].classificationNumber}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: width / 2 + 95,
            child: Text(
              '${provider.librarysearchData[index].edition}' == 'null' ||
                      '${provider.librarysearchData[index].edition}' == ''
                  ? 'EDITION  -'
                  : '''EDITION - ${provider.librarysearchData[index].edition}''',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Divider(height: 1, color: AppColors.whiteColor)
        ],
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
