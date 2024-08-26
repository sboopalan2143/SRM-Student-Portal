import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/riverpod/main_state.dart';

class LibraryPage extends ConsumerStatefulWidget {
  const LibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends ConsumerState<LibraryPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(libraryProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 2 - 100,
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
                width: width / 2 - 100,
                child: Text(
                  '${provider.libraryMemberData.membername}' == ''
                      ? '-'
                      : '${provider.libraryMemberData.membername}',
                  style: TextStyles.fontStyle10,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 2 - 100,
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
                width: width / 2 - 100,
                child: Text(
                  '${provider.libraryMemberData.membercode}' == ''
                      ? '-'
                      : '${provider.libraryMemberData.membercode}',
                  style: TextStyles.fontStyle10,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 2 - 100,
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
                width: width / 2 - 100,
                child: Text(
                  '${provider.libraryMemberData.membertype}' == ''
                      ? '-'
                      : '${provider.libraryMemberData.membertype}',
                  style: TextStyles.fontStyle10,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 2 - 100,
                child: const Text(
                  'Policy Name',
                  style: TextStyles.fontStyle10,
                ),
              ),
              const Text(
                ':',
                style: TextStyles.fontStyle10,
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 100,
                child: Text(
                  '${provider.libraryMemberData.policyname}' == ''
                      ? '-'
                      : '${provider.libraryMemberData.policyname}',
                  style: TextStyles.fontStyle10,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 2 - 100,
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
                width: width / 2 - 100,
                child: Text(
                  '${provider.libraryMemberData.status}' == ''
                      ? '-'
                      : '${provider.libraryMemberData.status}',
                  style: TextStyles.fontStyle10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ListView.builder(
            itemCount: 20,
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
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width / 2 - 125,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tran. ID',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Book',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Price',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 30,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SRM0190',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '21 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Data Structures',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Rs. 50.00',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(mainProvider.notifier).setNavString('View');
                },
                child: Text(
                  'View',
                  style: TextStyles.fontStyle14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
