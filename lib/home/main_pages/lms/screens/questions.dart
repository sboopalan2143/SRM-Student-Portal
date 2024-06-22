import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/lms/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';

class QuestionPage extends ConsumerStatefulWidget {
  const QuestionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                 Text('Questions', style: TextStyles.titleFontStyle),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('01.', style: TextStyles.smallBlackColorFontStyle),
                    Text(
                      'Who is the father of C language?',
                      style: TextStyles.smallBlackColorFontStyle,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/cprogram.png',
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonDesign.buttonDesign(
                        'Steve Jobs',
                        AppColors.primaryColor,
                        context,
                        ref.read(mainProvider.notifier),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ButtonDesign.buttonDesign(
                        'James Gosling',
                        AppColors.primaryColor,
                        context,
                        ref.read(mainProvider.notifier),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ButtonDesign.buttonDesign(
                        'Dennis Ritchie',
                        AppColors.primaryColor,
                        context,
                        ref.read(mainProvider.notifier),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ButtonDesign.buttonDesign(
                        'Rasmus Lerdarf',
                        AppColors.primaryColor,
                        context,
                        ref.read(mainProvider.notifier),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/Error.png',
                  height: 50,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                const Text('Wrong Answer', style: TextStyles.redColorFontStyle),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              child:  Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Explanation',
                      style: TextStyles.primaryColorTitleFontStyle,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Dennis Ritchie is the father '
                      'of C Programming Language.'
                      'C programming language was ',
                      style: TextStyles.fontStyle6,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: ButtonDesign.buttonDesign(
                    'Next Question',
                    AppColors.primaryColor,
                    context,
                    ref.read(mainProvider.notifier),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
