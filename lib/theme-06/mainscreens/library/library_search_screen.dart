import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
import 'package:sample/theme_3/library/library_page.dart';

class Theme06LibraryBookSearch extends ConsumerStatefulWidget {
  const Theme06LibraryBookSearch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme06LibraryBookSearchState();
}

class _Theme06LibraryBookSearchState
    extends ConsumerState<Theme06LibraryBookSearch> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(libraryProvider.notifier).getLibraryMemberHiveData('');
    });
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme06primaryColor,
                  AppColors.theme06primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'BOOK SEARCH',
            style: TextStyles.fontStyle4,
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
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for Books',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.theme02secondaryColor1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.theme02secondaryColor1,
                      ),
                    ),
                    // suffixIcon: IconButton(
                    //   icon: Icon(
                    //     Icons.search,
                    //     color: AppColors.theme02buttonColor2,
                    //   ),
                    //   onPressed: () async {
                    //     final provider = ref.watch(libraryProvider);

                    //     if (provider.filter.text == '') {
                    //       Alerts.errorAlert(
                    //         message: 'Filter empty',
                    //         context: context,
                    //       );
                    //     } else if (provider.filter.text.length < 3) {
                    //       Alerts.errorAlert(
                    //         message: 'Enter Morethan 3 Characters',
                    //         context: context,
                    //       );
                    //     } else {
                    //       await ref
                    //           .read(libraryProvider.notifier)
                    //           .saveLibrartBookSearchDetails(
                    //             ref.read(encryptionProvider.notifier),
                    //           );
                    //     }
                    //     provider.filter.clear();
                    //   },
                    // ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: AppColors.theme02buttonColor2,
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
                            message: 'Enter More than 3 Characters',
                            context: context,
                          );
                        } else {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          try {
                            await ref
                                .read(libraryProvider.notifier)
                                .saveLibrartBookSearchDetails(
                                  ref.read(encryptionProvider.notifier),
                                );
                          } finally {
                            Navigator.of(context).pop();
                          }
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
                          Center(
                            child: Text(
                              'SEARCH LIST IS EMPTY',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.theme02secondaryColor1,
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
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;

  //   final provider = ref.watch(libraryProvider);

  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 10),
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         colors: [
  //           AppColors.theme02primaryColor,
  //           AppColors.theme02secondaryColor1,
  //         ],
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //       ),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(15),
  //       child: Column(
  //         children: [
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                 width: width / 2 - 80,
  //                 child: Icon(
  //                   Icons.book,
  //                   color: AppColors.theme02buttonColor2,
  //                   size: 35,
  //                 ),
  //               ),
  //               const SizedBox(width: 5),
  //               SizedBox(
  //                 width: width * 0.35,
  //                 child: Text(
  //                   '${provider.librarysearchData[index].title}' == ''
  //                       ? '-'
  //                       : '''${provider.librarysearchData[index].title}''',
  //                   style: const TextStyle(
  //                     fontSize: 12,
  //                     color: AppColors.whiteColor,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 10),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].accessionnumber}' ==
  //                           'null' ||
  //                       '${provider.librarysearchData[index].accessionnumber}' ==
  //                           ''
  //                   ? 'ACCESSION NUMBER  -'
  //                   : '''ACCESSION NUMBER - ${provider.librarysearchData[index].accessionnumber}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].authorname}' == 'null' ||
  //                       '${provider.librarysearchData[index].authorname}' == ''
  //                   ? 'AUTHOR NAME  -'
  //                   : '''AUTHOR NAME - ${provider.librarysearchData[index].authorname}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].publishername}' ==
  //                           'null' ||
  //                       '${provider.librarysearchData[index].publishername}' ==
  //                           ''
  //                   ? 'PUBLISHER NAME  -'
  //                   : '''PUBLISHER NAME - ${provider.librarysearchData[index].publishername}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].department}' == 'null' ||
  //                       '${provider.librarysearchData[index].department}' == ''
  //                   ? 'DEPARTMENT  -'
  //                   : '''DEPARTMENT - ${provider.librarysearchData[index].department}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].booknumber}' == 'null' ||
  //                       '${provider.librarysearchData[index].booknumber}' == ''
  //                   ? 'BOOK NUMBER  -'
  //                   : '''BOOK NUMBER - ${provider.librarysearchData[index].booknumber}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].inhand}' == 'null' ||
  //                       '${provider.librarysearchData[index].inhand}' == ''
  //                   ? 'INHAND  -'
  //                   : '''INHAND - ${provider.librarysearchData[index].inhand}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 // fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].availability}' == 'null' ||
  //                       '${provider.librarysearchData[index].availability}' ==
  //                           ''
  //                   ? 'AVAILABILITY  -'
  //                   : '''AVAILABILITY - ${provider.librarysearchData[index].availability}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 // fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].borrow}' == 'null' ||
  //                       '${provider.librarysearchData[index].borrow}' == ''
  //                   ? 'BORROW  -'
  //                   : '''BORROW - ${provider.librarysearchData[index].borrow}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 // fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].classificationNumber}' ==
  //                           'null' ||
  //                       '${provider.librarysearchData[index].classificationNumber}' ==
  //                           ''
  //                   ? 'CLASSIFICATION NUMBER  -'
  //                   : '''CLASSIFICATION NUMBER - ${provider.librarysearchData[index].classificationNumber}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 // fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //           SizedBox(
  //             width: width / 2 + 95,
  //             child: Text(
  //               '${provider.librarysearchData[index].edition}' == 'null' ||
  //                       '${provider.librarysearchData[index].edition}' == ''
  //                   ? 'EDITION  -'
  //                   : '''EDITION - ${provider.librarysearchData[index].edition}''',
  //               style: const TextStyle(
  //                 fontSize: 12,
  //                 color: AppColors.whiteColor,
  //                 // fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 15),
  //           const Divider(height: 1, color: AppColors.whiteColor)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(libraryProvider);

    return GestureDetector(
      onTap: () {
        // Handle on-tap action
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.theme02primaryColor,
              AppColors.theme02secondaryColor1,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.theme02primaryColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Row(
                children: [
                  Icon(
                    Icons.book,
                    color: AppColors.theme02buttonColor2,
                    size: 40,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      provider.librarysearchData[index].title?.isEmpty ?? true
                          ? 'Untitled'
                          : provider.librarysearchData[index].title!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Key Information Section
              buildInfoRow(
                Icons.qr_code,
                'Accession Number',
                provider.librarysearchData[index].accessionnumber,
              ),
              buildInfoRow(
                Icons.person,
                'Author Name',
                provider.librarysearchData[index].authorname,
              ),
              buildInfoRow(
                Icons.apartment,
                'Department',
                provider.librarysearchData[index].department,
              ),
              buildInfoRow(
                Icons.category,
                'Classification',
                provider.librarysearchData[index].classificationNumber,
              ),
              buildInfoRow(
                Icons.info,
                'Edition',
                provider.librarysearchData[index].edition,
              ),
              // buildInfoRow(Icons.availability, 'Availability',
              // provider.librarysearchData[index].availability),
              buildInfoRow(
                Icons.bookmark,
                'Book Number',
                provider.librarysearchData[index].booknumber,
              ),
              const SizedBox(height: 15),
              // Divider
              const Divider(height: 1, color: AppColors.whiteColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.whiteColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value?.isEmpty ?? true
                  ? '$label - Not Available'
                  : '$label - $value',
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.whiteColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
