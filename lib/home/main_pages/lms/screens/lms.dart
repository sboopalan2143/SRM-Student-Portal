import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/lms/screens/notes.dart';
import 'package:sample/home/main_pages/lms/screens/online_assessment.dart';
import 'package:sample/home/screen/home_page.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class LMSPage extends ConsumerStatefulWidget {
  const LMSPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LMSPageState();
}

class _LMSPageState extends ConsumerState<LMSPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                  route: const HomePage(),
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
            'LMS',
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
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
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
                height: height * 0.15,
                width: width - 40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const OnlineAssessmentPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Online Assessment',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              Container(
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
                height: height * 0.15,
                width: width - 40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      RouteDesign(
                        route: const NotesPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Notes',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }
}
