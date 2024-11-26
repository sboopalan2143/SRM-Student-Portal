import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/library/screens/library.dart';
import 'package:sample/home/main_pages/library/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01ViewLibraryPage extends ConsumerStatefulWidget {
  const Theme01ViewLibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _Theme01ViewLibraryPageState();
}

class _Theme01ViewLibraryPageState
    extends ConsumerState<Theme01ViewLibraryPage> {
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
      backgroundColor: AppColors.theme01primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColor,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'BOOK SEARCH',
                style: TextStyles.buttonStyle01theme4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Filter',
                        style: TextStyles.theme01primary10smal3,
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '*',
                        style: TextStyles.redColorFontStyleastric,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: provider.filter,
                      style: TextStyles.fontStyle2,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyles.smallLightAshColorFontStyle,
                        filled: true,
                        fillColor: AppColors.secondaryColor,
                        contentPadding: const EdgeInsets.all(10),
                        enabledBorder:
                            BorderBoxButtonDecorations.loginTextFieldStyle,
                        focusedBorder:
                            BorderBoxButtonDecorations.loginTextFieldStyle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    child: ButtonDesign.buttonDesign(
                      'Submit',
                      AppColors.theme01primaryColor,
                      context,
                      ref.read(mainProvider.notifier),
                      ref,
                    ),
                  ),
                ],
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
                              'No List Added Yet!',
                              style: TextStyles.fontStyle,
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
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Material(
        elevation: 5,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.theme01secondaryColor1,
                AppColors.theme01secondaryColor2,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ExpansionTile(
              title: Row(
                children: [
                  SizedBox(
                    width: width / 2 - 100,
                    child: Text(
                      'Accession number :',
                      style: TextStyles.buttonStyle01theme2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${provider.librarysearchData[index].accessionnumber}' ==
                              ''
                          ? '-'
                          : '''${provider.librarysearchData[index].accessionnumber}''',
                      style: TextStyles.fontStyle10,
                    ),
                  ),
                ],
              ),
              collapsedIconColor: AppColors.theme01primaryColor,
              iconColor: AppColors.theme01primaryColor,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Author name :',
                  '${provider.librarysearchData[index].authorname}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].authorname}''',
                  width,
                ),
                _buildRow(
                  'Book number',
                  '${provider.librarysearchData[index].booknumber}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].booknumber}''',
                  width,
                ),
                _buildRow(
                  'Publisher name',
                  '${provider.librarysearchData[index].publishername}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].publishername}''',
                  width,
                ),
                _buildRow(
                  'title :',
                  '${provider.librarysearchData[index].title}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].title}''',
                  width,
                ),
                _buildRow(
                  'borrow',
                  '${provider.librarysearchData[index].borrow}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].borrow}''',
                  width,
                ),
                _buildRow(
                  'Classification Number',
                  '${provider.librarysearchData[index].classificationNumber}' ==
                          ''
                      ? '-'
                      : '''${provider.librarysearchData[index].classificationNumber}''',
                  width,
                ),
                _buildRow(
                  'department',
                  '${provider.librarysearchData[index].department}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].department}''',
                  width,
                ),
                _buildRow(
                  'edition',
                  '${provider.librarysearchData[index].edition}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].edition}''',
                  width,
                ),
                _buildRow(
                  'Inhand',
                  '${provider.librarysearchData[index].inhand}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].inhand}''',
                  width,
                ),
                const SizedBox(height: 10),
                _buildRow(
                  'Availability',
                  '${provider.librarysearchData[index].availability}' == ''
                      ? '-'
                      : '''${provider.librarysearchData[index].availability}''',
                  width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            title,
            style: TextStyles.buttonStyle01theme2,
          ),
        ),
        const Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle2,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle2,
          ),
        ),
      ],
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
