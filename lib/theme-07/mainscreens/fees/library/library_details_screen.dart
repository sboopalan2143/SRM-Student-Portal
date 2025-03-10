import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';

class Theme07LibraryPage extends ConsumerStatefulWidget {
  const Theme07LibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme07LibraryPageState();
}

class _Theme07LibraryPageState extends ConsumerState<Theme07LibraryPage> {
  final ScrollController _listController = ScrollController();


  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(libraryProvider.notifier).getLibraryMemberDetails(
              ref.read(encryptionProvider.notifier),
            );
        await ref.read(libraryProvider.notifier).getLibraryMemberHiveData('');
      },
    );
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
      backgroundColor: AppColors.theme07secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme07primaryColor,
                  AppColors.theme07primaryColor,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            if (provider is LibraryTrancsactionStateLoading)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                  child:
                      CircularProgressIndicators.theme07primaryColorProgressIndication,
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
    );
  }

   Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(libraryProvider);
    return Padding(
      padding: const EdgeInsets.all(8),
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
                      'Member code',
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
                      '${provider.libraryTransactionData[index].membercode}' == ''
                          ? '-'
                          : '${provider.libraryTransactionData[index].membercode}',
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
                      '${provider.libraryTransactionData[index].membername}' == ''
                          ? '-'
                          : '${provider.libraryTransactionData[index].membername}',
                      style: TextStyles.fontStyle10,
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
                    child: const Text(
                      'Accession No',
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
                      '${provider.libraryTransactionData[index].policyname}' == ''
                          ? '-'
                          : '${provider.libraryTransactionData[index].policyname}',
                      style: TextStyles.fontStyle10,
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
               const SizedBox(height: 5),
          
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
