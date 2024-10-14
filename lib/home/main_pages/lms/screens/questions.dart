import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/lms/screens/online_assessment.dart';
import 'package:sample/home/main_pages/lms/widgets/button_design.dart';
import 'package:sample/home/riverpod/main_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class QuestionPage extends ConsumerStatefulWidget {
  const QuestionPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                RouteDesign(
                  route: const OnlineAssessmentPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: const Text(
            'ONLINE ASSESSMENT',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 35,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
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
                    const Text('Wrong Answer',
                        style: TextStyles.redColorFontStyle,),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Explanation',
                          style: TextStyles.primaryColorTitleFontStyle,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Dennis Ritchie is the father '
                          'of C Programming Language. '
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20,),
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
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }
}
