import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/lms/screens/notes.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class NotesDetailsPage extends ConsumerStatefulWidget {
  const NotesDetailsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotesDetailsPageState();
}

class _NotesDetailsPageState extends ConsumerState<NotesDetailsPage> {
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
                  route: const NotesPage(),
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
            'NOTES DETAILS',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('C Introduction', style: TextStyles.titleFontStyle),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/cprogram.png',
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'What is C?',
                    style: TextStyles.fontStyle7,
                  ),
                ],
              ),
              const Text(
                'C is a general-purpose programming'
                ' language created by Dennis Ritchie '
                ' at the Bell Laboratories in 1972. '
                'It is a very popular language, '
                ' despite being old. The main reason '
                'for its popularity is because it is '
                'a fundamental language in the field '
                ' of computer science. '
                'C is strongly associated with UNIX,',
                style: TextStyles.fontStyle16,
                textAlign: TextAlign.justify,
                // softWrap: true,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Why Learn C?',
                    style: TextStyles.fontStyle7,
                  ),
                ],
              ),
              const Text(
                'It is one of the most popular programming languages in the world'
                ' If you know C, you will have no problem learning other popular '
                ''' programming languages such as Java, Python, C++, C#, etc, as the '''
                ' syntax is similar C is very fast, compared to other programming'
                ' languages, like Java and Python ',
                style: TextStyles.fontStyle16,
                textAlign: TextAlign.justify,
                // softWrap: true,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Difference between C and C++',
                    style: TextStyles.fontStyle7,
                  ),
                ],
              ),
              const Text(
                'It is one of the most popular programming languages in the world'
                ' If you know C, you will have no problem learning other popular '
                ''' programming languages such as Java, Python, C++, C#, etc, as the '''
                ' syntax is similar C is very fast, compared to other programming'
                ' languages, like Java and Python ',
                style: TextStyles.fontStyle16,
                textAlign: TextAlign.justify,
                // softWrap: true,
              ),
            ],
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }
}
