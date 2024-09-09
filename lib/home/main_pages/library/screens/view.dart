import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_provider.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/library/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class ViewLibraryPage extends ConsumerStatefulWidget {
  const ViewLibraryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewLibraryPageState();
}

class _ViewLibraryPageState extends ConsumerState<ViewLibraryPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(libraryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Book Search',
          ),
        ),
        backgroundColor: Colors.blueAccent, // Custom color for AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Student ID',
                    style: TextStyles.fontStyle2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: provider.studentId,
                      style: TextStyles.fontStyle2,
                      decoration: InputDecoration(
                        hintText: 'Enter Student ID',
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
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Office id',
                    style: TextStyles.fontStyle2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: provider.officeid,
                      style: TextStyles.fontStyle2,
                      decoration: InputDecoration(
                        hintText: 'Office id',
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
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'filter',
                    style: TextStyles.fontStyle2,
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
                        hintText: 'filter',
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
                  // ElevatedButton(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     padding:const EdgeInsets.symmetric(
                  //         horizontal: 30,
                  //         vertical: 15,), // Adjusts the button size
                  //     backgroundColor:
                  //         AppColors.primaryColor, // Button background color
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius:
                  //           BorderRadius.circular(30), // Rounded corners
                  //     ),
                  //     elevation: 5, // Adds shadow for elevation
                  //   ),
                  //   child:const Text(
                  //     'Submit',
                  //     style: TextStyle(
                  //       fontSize: 18, // Font size for the text
                  //       fontWeight: FontWeight.bold, // Bold text
                  //       color: Colors.white, // Text color
                  //     ),
                  //   ),
                  // )

                  Expanded(
                    child: ButtonDesign.buttonDesign(
                      'Submit',
                      AppColors.primaryColor,
                      context,
                      ref.read(mainProvider.notifier),
                      ref,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
                      'Acc.no',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Issue Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Book',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Due Date',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Return',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Status',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Fine',
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
                  Text(
                    ':',
                    style: TextStyles.fontStyle10,
                  ),
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 1.6 - 20,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SRM0200',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '1020200',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '25 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Data Structures',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '25 May, 2024',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Not returned',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Books in hand',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      '0',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      ' Rs. 50.00',
                      style: TextStyles.fontStyle10,
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
}
