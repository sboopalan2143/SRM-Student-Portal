import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07LibraryPage extends ConsumerStatefulWidget {
  const Theme07LibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07LibraryPageState();
}

class _Theme07LibraryPageState extends ConsumerState<Theme07LibraryPage> {
  final ScrollController _listController = ScrollController();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

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

    // Member details are at the first index
    // final memberData = provider.libraryTransactionData.first;

    // Skip the first entry for transactions
    // final transactionDataList = provider.libraryTransactionData.skip(1);
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
                      await ref.read(libraryProvider.notifier).getLibraryMemberDetails(
                            ref.read(encryptionProvider.notifier),
                          );
                      await ref.read(libraryProvider.notifier).getLibraryMemberHiveData('');
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
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              )
            else if (provider.libraryTransactionData.isEmpty && provider is! LibraryTrancsactionStateLoading)
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 5),
                  Center(
                    child: Text(
                      'No List Added Yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
            if (provider.libraryTransactionData.isNotEmpty) ...[
              ListView.builder(
                controller: _listController,
                shrinkWrap: true,
                itemCount: provider.libraryTransactionData.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return memberCardDesign(index);
                  } else {
                    return libraryCardDesign(index);
                  }
                },
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget memberCardDesign(int index) {
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
                      'Member code',
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
                      provider.libraryTransactionData[index].membercode.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].membercode}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
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
                      'Member Name',
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
                      provider.libraryTransactionData[index].membername.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].membername}',
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
                      'Policy Name',
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
                      provider.libraryTransactionData[index].policyname.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].policyname}',
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
                      'Status',
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
                      provider.libraryTransactionData[index].status.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].status}',
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

  Widget libraryCardDesign(int index) {
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
                      provider.libraryTransactionData[index].title.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].title}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
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
                      'Assession No.',
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
                      provider.libraryTransactionData[index].accessionno.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].accessionno}',
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
                      'Due Date',
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
                      provider.libraryTransactionData[index].duedate.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].duedate}',
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
                      'Returned Date',
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
                      provider.libraryTransactionData[index].returndate.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].returndate}',
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
                      'Status',
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
                      provider.libraryTransactionData[index].status.toString().isEmpty
                          ? '-'
                          : '${provider.libraryTransactionData[index].status}',
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
