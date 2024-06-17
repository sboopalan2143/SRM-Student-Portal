import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';

import '../../../riverpod/main_state.dart';

class AcademicsPage extends ConsumerStatefulWidget {
  const AcademicsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AcademicsPageState();
}

class _AcademicsPageState extends ConsumerState<AcademicsPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Timetable');
                  },
                  child: const Text(
                    'Timetable',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Subjects');
                  },
                  child: const Text(
                    'Subjects',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref
                        .read(mainProvider.notifier)
                        .setNavString('Internal Marks');
                  },
                  child: const Text(
                    'Internal Marks',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref.read(mainProvider.notifier).setNavString('Attendance');
                  },
                  child: const Text(
                    'Attendance',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref
                        .read(mainProvider.notifier)
                        .setNavString('Hour Attendance');
                  },
                  child: const Text(
                    'Hour Attendance',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref
                        .read(mainProvider.notifier)
                        .setNavString('Cumulative Attendance');
                  },
                  child: const Text(
                    'Cumulative Attendance',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: ElevatedButton(
                  style: BorderBoxButtonDecorations.homePageButtonStyle,
                  onPressed: () {
                    ref
                        .read(mainProvider.notifier)
                        .setNavString('Exam Details');
                  },
                  child: const Text(
                    'Exam Details',
                    textAlign: TextAlign.center,
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.06,
              ),
              SizedBox(
                height: height * 0.15,
                width: width * 0.40,
                child: const Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyles.fontStyle6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
