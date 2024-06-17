import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/colors.dart';

class TermsAndConditions extends ConsumerStatefulWidget {
  const TermsAndConditions({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TermsAndConditionsState();
}

class _TermsAndConditionsState extends ConsumerState<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          // height: 800,
          decoration: BoxDecoration(
            border: Border.all(
                color: AppColors.whiteColor, style: BorderStyle.solid),
            color: const Color.fromARGB(255, 252, 250, 250),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text('''Lorem Ipsum is simply dummy text of the printing 
          and typesetting industry. Lorem Ipsum has been the industry's 
          standard dummy text ever since the 1500s, when an unknown printer
           took a galley of type and scrambled it to make a type specimen book.
            It has survived not only five centuries, but also the leap into 
            lectronic typesetting, remaining essentially unchanged. It was 
            popularised in the 1960s with the release of Letraset sheets 
            containing Lorem Ipsum passages, 
          and more recently with desktop publishing software like Aldus 
          PageMaker including versions of Lorem Ipsum.'''),
        ),
      ),
    );
  }
}
