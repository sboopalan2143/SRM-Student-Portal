import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_provider.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

// class NotificationPage extends ConsumerStatefulWidget {
//   const NotificationPage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _NotificationPageState();
// }

// class _NotificationPageState extends ConsumerState<NotificationPage> {
//   final ScrollController _listController = ScrollController();
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(notificationProvider.notifier).getNotificationDetails(
//             ref.read(encryptionProvider.notifier),
//           );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final provider = ref.watch(notificationProvider);

//     ref.listen(notificationProvider, (previous, next) {
//       if (next is NotificationError) {
//         _showToast(context, next.errorMessage, AppColors.redColor);
//       } else if (next is NotificationSuccessFull) {
//         /// Handle route to next page.

//         _showToast(context, next.successMessage, AppColors.greenColor);
//       }
//     });
//     return Scaffold(
//       backgroundColor: AppColors.secondaryColor,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/images/Grievancesappbar.png',
//               fit: BoxFit.cover,
//               width: double.infinity,
//             ),
//             AppBar(
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(
//                     context,
//                   );
//                 },
//                 icon: const Icon(
//                   Icons.arrow_back_ios_new,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               title: const Text(
//                 'NOTIFICATION',
//                 style: TextStyles.fontStyle4,
//                 overflow: TextOverflow.clip,
//               ),
//               centerTitle: true,
//               actions: [
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: () {},
//                       icon: const Icon(
//                         Icons.menu,
//                         size: 35,
//                         color: AppColors.whiteColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   height: 45,
//                   width: width - 50,
//                   decoration: BoxDecoration(
//                     color: AppColors.grey1,
//                     borderRadius: const BorderRadius.all(Radius.circular(20)),
//                     border: Border.all(
//                       color: AppColors.grey1,
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(5),
//                     child: Row(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Expanded(
//                           child: navContainerDesign(
//                             text: 'From Staff',
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         Expanded(
//                           child: navContainerDesign(
//                             text: 'From Circular',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (provider is NotificationLoading)
//             Padding(
//               padding: const EdgeInsets.only(top: 100),
//               child: Center(
//                 child:
//                     CircularProgressIndicators.primaryColorProgressIndication,
//               ),
//             )
//           else if (provider.notificationData.isEmpty &&
//               provider is! NotificationLoading)
//             Column(
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height / 5),
//                 const Center(
//                   child: Text(
//                     'No List Added Yet!',
//                     style: TextStyles.fontStyle6,
//                   ),
//                 ),
//               ],
//             ),
//           if (provider.notificationData.isNotEmpty)
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//               child: ListView.builder(
//                 itemCount: 20,
//                 controller: _listController,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return provider.notificationData == 'From Staff'
//                       ? cardDesignStaff(index)
//                       : cardDesignCircular(index);
//                 },
//               ),
//             ),
//         ],
//       ),
//       endDrawer: const DrawerDesign(),
//     );
//   }

//   Widget cardDesignStaff(int index) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.asset(
//                     'assets/images/profile.png',
//                     height: 20,
//                   ),
//                   const SizedBox(width: 10),
//                   const Text('Ravi : ', style: TextStyles.fontStyle10),
//                   const Text(
//                     'Lorem Ipsum is simply dummy text',
//                     style: TextStyles.fontStyle15,
//                   ),
//                 ],
//               ),
//               const Row(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.restore, color: AppColors.grey2),
//                   SizedBox(width: 10),
//                   Text(
//                     '17:05 | 28:05:2024',
//                     style: TextStyles.fontStyle15,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget cardDesignCircular(int index) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 5,
//               blurRadius: 7,
//               offset: const Offset(0, 3), // changes position of shadow
//             ),
//           ],
//         ),
//         child: const Padding(
//           padding: EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '  Lorem Ipsum is simply dummy text',
//                     style: TextStyles.fontStyle15,
//                   ),
//                 ],
//               ),
//               Row(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 // mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Icon(Icons.restore, color: AppColors.grey2),
//                   SizedBox(width: 10),
//                   Text(
//                     '17:05 | 28:05:2024',
//                     style: TextStyles.fontStyle15,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget navContainerDesign({
//     required String text,
//   }) {
//     final provider = ref.watch(notificationProvider);
//     return SizedBox(
//       height: 40,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           // side: BorderSide(
//           //   color: AppColors.whiteColor,
//           // ),
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(20),
//             ),
//           ),
//           elevation: 0,
//           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//           backgroundColor: text == provider.notificationData
//               ? AppColors.primaryColor
//               : AppColors.grey1,
//           shadowColor: Colors.transparent,
//         ),
//         onPressed: () {
//           // ref
//           //     .read(notificationProvider.notifier)
//           //     .setNotificationNavString(text);
//         },
//         child: text == provider.notificationData
//             ? FittedBox(
//                 child: Text(
//                   text,
//                   style: TextStyles.fontStyle13,
//                 ),
//               )
//             : FittedBox(
//                 child: Text(
//                   text,
//                   style: TextStyles.smallLightAshColorFontStyle,
//                 ),
//               ),
//       ),
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

// import 'package:sample/home/riverpod/main_state.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  final ScrollController _listController = ScrollController();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  Future<void> _handleRefresh() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        ref.read(notificationProvider.notifier).getNotificationDetails(
              ref.read(encryptionProvider.notifier),
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
      ref.read(notificationProvider.notifier).getNotificationDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(notificationProvider);
    ref.listen(notificationProvider, (previous, next) {
      if (next is NotificationError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is NotificationSuccessFull) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
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
                'Notification',
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
                              .read(notificationProvider.notifier)
                              .getNotificationDetails(
                                ref.read(encryptionProvider.notifier),
                              );
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                if (provider is NotificationLoading)
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: CircularProgressIndicators
                          .primaryColorProgressIndication,
                    ),
                  )
                else if (provider.notificationData.isEmpty &&
                    provider is! NotificationLoading)
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
                if (provider.notificationData.isNotEmpty)
                  ListView.builder(
                    itemCount: provider.notificationData.length,
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
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;

    final provider = ref.watch(notificationProvider);
    return GestureDetector(
      onTap: () {},
      child: Padding(
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
                        'Notification Id',
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
                        '${provider.notificationData[index].notificationid}' ==
                                'null'
                            ? '-'
                            : '''${provider.notificationData[index].notificationid}''',
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
                        'Notification Subject',
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
                        '${provider.notificationData[index].notificationsubject}' ==
                                'null'
                            ? '-'
                            : '${provider.notificationData[index].notificationsubject}',
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
                        'Notification Category Desc',
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
                        '${provider.notificationData[index].notificationcategorydesc}' ==
                                'null'
                            ? '-'
                            : '''${provider.notificationData[index].notificationcategorydesc}''',
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
                        'Notification Description',
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
                        '${provider.notificationData[index].notificationdescription}' ==
                                'null'
                            ? '-'
                            : '''${provider.notificationData[index].notificationdescription}''',
                        style: TextStyles.fontStyle10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
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
