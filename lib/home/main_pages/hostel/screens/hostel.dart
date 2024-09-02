import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/hostel/riverpod/hostel_state.dart';
import 'package:sample/home/main_pages/hostel/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class HostelPage extends ConsumerStatefulWidget {
  const HostelPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HostelPageState();
}

class _HostelPageState extends ConsumerState<HostelPage> {
  final ScrollController _listController = ScrollController();
  List<String> name = ['Select Year/Sem', 'one', 'two', 'three'];
  String selectedValue = 'Select Year/Sem';

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(hostelProvider);
    ref.listen(hostelProvider, (previous, next) {
      if (next is HostelStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is HostelStateSuccessful) {
        /// Handle route to next page.

        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ButtonDesign.buttonDesign(
                      'Leave Application',
                      AppColors.primaryColor,
                      context,
                      ref.read(mainProvider.notifier),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: ButtonDesign.buttonDesign(
                      'Registration',
                      AppColors.primaryColor,
                      context,
                      ref.read(mainProvider.notifier),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (provider is HostelStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators
                        .primaryColorProgressIndication,
                  ),
                )
              else if (provider.hospitalData.isEmpty &&
                  provider is! HostelStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    const Center(
                      child: Text(
                        'No List Added Yet!',
                        style: TextStyles.fontStyle6,
                      ),
                    ),
                  ],
                ),
              if (provider.hospitalData.isNotEmpty)
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
        ),
      ],
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
            children: [
              SizedBox(
                width: width / 2 - 125,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Gender',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Facilities',
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
                ],
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2 - 20,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Perungalathur, Chennai',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Gents',
                      style: TextStyles.fontStyle10,
                    ),
                    Text(
                      'Food, Parking, AC',
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
