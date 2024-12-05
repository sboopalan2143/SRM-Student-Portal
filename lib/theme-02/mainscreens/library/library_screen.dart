// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:sample/designs/_designs.dart';
// import 'package:sample/encryption/encryption_state.dart';
// import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
// import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/theme-01/mainscreens/library/library_search_screen.dart';
// // import 'package:sample/home/riverpod/main_state.dart';

// class Theme01LibraryPage extends ConsumerStatefulWidget {
//   const Theme01LibraryPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _Theme01LibraryPageState();
// }

// class _Theme01LibraryPageState extends ConsumerState<Theme01LibraryPage> {
//   final ScrollController _listController = ScrollController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
//       GlobalKey<LiquidPullToRefreshState>();

//   static int refreshNum = 10;
//   Stream<int> counterStream =
//       Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

//   Future<void> _handleRefresh() async {
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) async {
//         await ref.read(libraryProvider.notifier).getLibraryMemberDetails(
//               ref.read(encryptionProvider.notifier),
//             );
//         await ref.read(libraryProvider.notifier).getLibraryMemberHiveData('');
//       },
//     );

//     final completer = Completer<void>();
//     Timer(const Duration(seconds: 1), completer.complete);
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(libraryProvider.notifier).getLibraryMemberHiveData('');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = ref.watch(libraryProvider);
//     ref.listen(libraryProvider, (previous, next) {
//       if (next is LibraryTrancsactionStateError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is LibraryTrancsactionStateSuccessful) {
//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: AppColors.theme01primaryColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Stack(
//           children: [
//             AppBar(
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(
//                   Icons.arrow_back_ios_new,
//                   color: AppColors.theme01primaryColor,
//                 ),
//               ),
//               backgroundColor: AppColors.theme01secondaryColor4,
//               elevation: 0,
//               title: Text(
//                 'LIBRARY',
//                 style: TextStyles.buttonStyle01theme4,
//                 overflow: TextOverflow.clip,
//               ),
//               centerTitle: true,
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(right: 20),
//                   child: Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           await ref
//                               .read(libraryProvider.notifier)
//                               .getLibraryMemberDetails(
//                                 ref.read(encryptionProvider.notifier),
//                               );
//                           await ref
//                               .read(libraryProvider.notifier)
//                               .getLibraryMemberHiveData('');
//                         },
//                         child: Icon(
//                           Icons.refresh,
//                           color: AppColors.theme01primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: LiquidPullToRefresh(
//         key: _refreshIndicatorKey,
//         onRefresh: _handleRefresh,
//         color: AppColors.theme01primaryColor,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Center(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         width: 200,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(9),
//                               ),
//                             ),
//                             elevation: 0,
//                             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                             backgroundColor: AppColors.theme01secondaryColor4,
//                             shadowColor: Colors.transparent,
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               RouteDesign(
//                                 route: const Theme01ViewLibraryPage(),
//                               ),
//                             );
//                           },
//                           child: Text(
//                             'Book Search',
//                             style: TextStyles.buttonStyle01theme2,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               ),
//               if (provider is LibraryTrancsactionStateLoading)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 100),
//                   child: Center(
//                     child: CircularProgressIndicators
//                         .primaryColorProgressIndication,
//                   ),
//                 )
//               else if (provider.libraryTransactionData.isEmpty &&
//                   provider is! LibraryTrancsactionStateLoading)
//                 Column(
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height / 5),
//                     const Center(
//                       child: Text(
//                         'No List Added Yet!',
//                         style: TextStyles.fontStyle5,
//                       ),
//                     ),
//                   ],
//                 ),
//               if (provider.libraryTransactionData.isNotEmpty)
//                 ListView.builder(
//                   itemCount: provider.libraryTransactionData.length,
//                   controller: _listController,
//                   shrinkWrap: true,
//                   itemBuilder: (BuildContext context, int index) {
//                     return cardDesign(index);
//                   },
//                 ),
//             ],
//           ),
//         ),
//       ),
//       endDrawer: const DrawerDesign(),
//     );
//   }

//   Widget cardDesign(int index) {
//     final width = MediaQuery.of(context).size.width;
//     final provider = ref.watch(libraryProvider);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
//       child: Material(
//         elevation: 5,
//         shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 AppColors.theme01secondaryColor1,
//                 AppColors.theme01secondaryColor2,
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: ExpansionTile(
//               title: Row(
//                 children: [
//                   SizedBox(
//                     width: width / 2 - 100,
//                     child: Text(
//                       'Status :',
//                       style: TextStyles.buttonStyle01theme2,
//                     ),
//                   ),
//                   Expanded(
//                     child: Text(
//                       '${provider.libraryTransactionData[index].status}',
//                       style: TextStyles.fontStyle2,
//                     ),
//                   ),
//                 ],
//               ),
//               collapsedIconColor: AppColors.theme01primaryColor,
//               iconColor: AppColors.theme01primaryColor,
//               children: [
//                 Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
//                 _buildRow(
//                   'Member name :',
//                   '${provider.libraryTransactionData[index].membername}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].membername}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Member code',
//                   '${provider.libraryTransactionData[index].membercode}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].membercode}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Member type',
//                   '${provider.libraryTransactionData[index].membertype}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].membertype}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Policy name :',
//                   '${provider.libraryTransactionData[index].policyname}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].policyname}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Accession no',
//                   '${provider.libraryTransactionData[index].accessionno}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].accessionno}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Due date',
//                   '${provider.libraryTransactionData[index].duedate}' == 'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].duedate}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Fine amount',
//                   '${provider.libraryTransactionData[index].fineamount}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].fineamount}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Issue date',
//                   '${provider.libraryTransactionData[index].issuedate}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].issuedate}',
//                   width,
//                 ),
//                 _buildRow(
//                   'Return date',
//                   '${provider.libraryTransactionData[index].returndate}' ==
//                           'null'
//                       ? '-'
//                       : '${provider.libraryTransactionData[index].returndate}',
//                   width,
//                 ),
//                 const SizedBox(height: 10),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildRow(String title, String value, double width) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: width / 2 - 60,
//           child: Text(
//             title,
//             style: TextStyles.buttonStyle01theme2,
//           ),
//         ),
//         const Expanded(
//           child: Text(
//             ':',
//             style: TextStyles.fontStyle2,
//           ),
//         ),
//         const SizedBox(width: 5),
//         SizedBox(
//           width: width / 2 - 60,
//           child: Text(
//             value.isEmpty ? '-' : value,
//             style: TextStyles.fontStyle2,
//           ),
//         ),
//       ],
//     );
//   }

//   void _showToast(BuildContext context, String message, Color color) {
//     showToast(
//       message,
//       context: context,
//       backgroundColor: color,
//       axis: Axis.horizontal,
//       alignment: Alignment.centerLeft,
//       position: StyledToastPosition.center,
//       borderRadius: const BorderRadius.only(
//         topRight: Radius.circular(15),
//         bottomLeft: Radius.circular(15),
//       ),
//       toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/theme-01/mainscreens/library/library_search_screen.dart';
import 'package:sample/theme-02/mainscreens/library/library_search_screen.dart';
import 'package:sample/theme_3/library/library_booksearch.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class Theme02LibraryPage extends ConsumerStatefulWidget {
  const Theme02LibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme02LibraryPageState();
}

class _Theme02LibraryPageState extends ConsumerState<Theme02LibraryPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(libraryProvider.notifier).getLibraryMemberDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(libraryProvider.notifier).getLibraryMemberHiveData('');
      },
    );

    final completer = Completer<void>();
    Timer(const Duration(seconds: 1), completer.complete);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(libraryProvider.notifier).getLibraryMemberHiveData('');
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
                  AppColors.theme02primaryColor,
                  AppColors.theme02secondaryColor1,
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
            'LIBRARY',
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
                    onTap: () async {
                      await ref
                          .read(libraryProvider.notifier)
                          .getLibraryMemberDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref
                          .read(libraryProvider.notifier)
                          .getLibraryMemberHiveData('');
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
      body: LiquidPullToRefresh(
        key: _refreshIndicatorKey,
        onRefresh: _handleRefresh,
        color: AppColors.theme02secondaryColor1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            elevation: 0,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: AppColors.theme02secondaryColor1,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              RouteDesign(
                                route: const Theme02LibraryBookSearch(),
                              ),
                            );
                          },
                          child: const Text(
                            'Book Search',
                            style: TextStyles.fontStyle13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
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
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle,
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
      ),
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(libraryProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
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
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${provider.libraryTransactionData[index].membername}' ==
                            'null'
                        ? '-'
                        : '''${provider.libraryTransactionData[index].membername}''',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${provider.libraryTransactionData[index].membercode}' ==
                                'null'
                            ? '-'
                            : '''${provider.libraryTransactionData[index].membercode}''',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${provider.libraryTransactionData[index].policyname}' ==
                            'null'
                        ? '-'
                        : '${provider.libraryTransactionData[index].policyname}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Status :',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color:
                              provider.libraryTransactionData[index].status ==
                                      'Active'
                                  ? AppColors.greenColor
                                  : AppColors.redColor,
                        ),
                      ),
                    ],
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
