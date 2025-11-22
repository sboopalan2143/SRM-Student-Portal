import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07LibraryBookSearch extends ConsumerStatefulWidget {
  const Theme07LibraryBookSearch({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07LibraryBookSearchState();
}

class _Theme07LibraryBookSearchState extends ConsumerState<Theme07LibraryBookSearch> {
  final ScrollController _listController = ScrollController();

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

    log(provider.libraryTransactionData.toString());
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search for Books',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inverseSurface.withAlpha(100),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.theme02secondaryColor1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: AppColors.theme07primaryColor,
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
                          // await showDialog(
                          //   context: context,
                          //   barrierDismissible: false,
                          //   builder: (context) {
                          //     return Center(
                          //       child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                          //     );
                          //   },
                          // );
                          try {
                            await ref.read(libraryProvider.notifier).saveLibrartBookSearchDetails(
                                  ref.read(encryptionProvider.notifier),
                                );
                          } finally {
                            // Navigator.of(context).pop();
                          }
                        }

                        provider.filter.clear();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (provider is LibraryTrancsactionStateLoading)
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Center(
                          child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                        ),
                      )
                    else if (provider.librarysearchData.isEmpty)
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
                                fontWeight: FontWeight.bold,
                                color: AppColors.theme02secondaryColor1,
                              ),
                            ),
                          ),
                        ],
                      )
                    else
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

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    final provider = ref.watch(libraryProvider);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    child: Text(
                      'Title',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.librarysearchData[index].title}' == ''
                          ? '-'
                          : '${provider.librarysearchData[index].title}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Accession Number',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.librarysearchData[index].accessionnumber}' == ''
                          ? '-'
                          : '${provider.librarysearchData[index].accessionnumber}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Author Name',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.librarysearchData[index].authorname}' == ''
                          ? '-'
                          : '${provider.librarysearchData[index].authorname}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.theme07primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Department',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 40,
                    child: Text(
                      '${provider.librarysearchData[index].department}' == ''
                          ? '-'
                          : '${provider.librarysearchData[index].department}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  // Widget cardDesign(int index) {
  //   final width = MediaQuery.of(context).size.width;

  //   final provider = ref.watch(libraryProvider);

  //   return GestureDetector(
  //     onTap: () {
  //       // Handle on-tap action
  //     },
  //     child: AnimatedContainer(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //       margin: const EdgeInsets.only(bottom: 10),
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [
  //             AppColors.theme02primaryColor,
  //             AppColors.theme02secondaryColor1,
  //           ],
  //           begin: Alignment.topCenter,
  //           end: Alignment.bottomCenter,
  //         ),
  //         borderRadius: BorderRadius.circular(20),
  //         boxShadow: [
  //           BoxShadow(
  //             color: AppColors.theme02primaryColor.withOpacity(0.3),
  //             blurRadius: 10,
  //             offset: const Offset(0, 5),
  //           ),
  //         ],
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(15),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             // Title Section
  //             Row(
  //               children: [
  //                 Icon(
  //                   Icons.book,
  //                   color: AppColors.theme02buttonColor2,
  //                   size: 40,
  //                 ),
  //                 const SizedBox(width: 10),
  //                 Expanded(
  //                   child: Text(
  //                     provider.librarysearchData[index].title?.isEmpty ?? true
  //                         ? 'Untitled'
  //                         : provider.librarysearchData[index].title!,
  //                     style: const TextStyle(
  //                       fontSize: 16,
  //                       color: AppColors.whiteColor,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     maxLines: 2,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 10),
  //             // Key Information Section
  //             buildInfoRow(
  //               Icons.qr_code,
  //               'Accession Number',
  //               provider.librarysearchData[index].accessionnumber,
  //             ),
  //             buildInfoRow(
  //               Icons.person,
  //               'Author Name',
  //               provider.librarysearchData[index].authorname,
  //             ),
  //             // buildInfoRow(
  //             //   Icons.apartment,
  //             //   'Department',
  //             //   provider.librarysearchData[index].department,
  //             // ),
  //             // buildInfoRow(
  //             //   Icons.category,
  //             //   'Classification',
  //             //   provider.librarysearchData[index].classificationNumber,
  //             // ),
  //             buildInfoRow(
  //               Icons.info,
  //               'Edition',
  //               provider.librarysearchData[index].edition,
  //             ),
  //             // buildInfoRow(Icons.availability, 'Availability',
  //             // provider.librarysearchData[index].availability),
  //             // buildInfoRow(
  //             //   Icons.bookmark,
  //             //   'Book Number',
  //             //   provider.librarysearchData[index].booknumber,
  //             // ),
  //             const SizedBox(height: 15),
  //             // Divider
  //             const Divider(height: 1, color: AppColors.whiteColor),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
              value?.isEmpty ?? true ? '$label - Not Available' : '$label - $value',
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
