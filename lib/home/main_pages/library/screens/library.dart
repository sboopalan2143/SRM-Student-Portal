import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(libraryProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              child: CircularProgressIndicators.primaryColorProgressIndication,
            ),
          )
        else if (provider.libraryTransactionData.isEmpty && provider is! LibraryTrancsactionStateLoading)
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
                          : '${provider.libraryTransactionData[index].membername}',
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
                          : '${provider.libraryTransactionData[index].membercode}',
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
                          : '${provider.libraryTransactionData[index].membertype}',
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

    // Padding(
    //   padding: const EdgeInsets.only(bottom: 8),
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: const BorderRadius.all(Radius.circular(20)),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.2),
    //           spreadRadius: 5,
    //           blurRadius: 7,
    //           offset: const Offset(0, 3), // changes position of shadow
    //         ),
    //       ],
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           SizedBox(
    //             width: width / 2 - 100,
    //             child: const Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   'Member Name',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'Member Code',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'Member Type',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   'Status',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //               Text(
    //                 ':',
    //                 style: TextStyles.fontStyle10,
    //               ),
    //             ],
    //           ),
    //           const SizedBox(width: 5),
    //           SizedBox(
    //             width: width / 2 - 60,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   '${provider.libraryTransactionData[index].membername}' ==
    //                           ''
    //                       ? '-'
    //                       : '${provider.libraryTransactionData[index].membername}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.libraryTransactionData[index].membercode}' ==
    //                           ''
    //                       ? '-'
    //                       : '${provider.libraryTransactionData[index].membercode}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.libraryTransactionData[index].membertype}' ==
    //                           ''
    //                       ? '-'
    //                       : '${provider.libraryTransactionData[index].membertype}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //                 Text(
    //                   '${provider.libraryTransactionData[index].status}' == ''
    //                       ? '-'
    //                       : '${provider.libraryTransactionData[index].status}',
    //                   style: TextStyles.fontStyle10,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           TextButton(
    //             onPressed: () {
    //               ref.read(mainProvider.notifier).setNavString('View');
    //             },
    //             child: Text(
    //               'View',
    //               style: TextStyles.fontStyle14,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
