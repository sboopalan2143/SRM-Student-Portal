import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/academics/exam_details_pages/riverpod/exam_details_state.dart';
import 'package:sample/home/main_pages/academics/hourwise_attendence/riverpod/hourwise_attendence_state.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';

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
                  child: Text(
                    'Timetable',
                    textAlign: TextAlign.center,
                    style: width > 400
                        ? TextStyles.fontStyle6
                        : TextStyles.fontStyle8,
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
                    ref.read(subjectProvider.notifier).getSubjectDetails(
                        ref.read(encryptionProvider.notifier));
                    ref.read(mainProvider.notifier).setNavString('Subjects');
                  },
                  child: Text(
                    'Subjects',
                    textAlign: TextAlign.center,
                    style: width > 400
                        ? TextStyles.fontStyle6
                        : TextStyles.fontStyle8,
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
                  child: Text(
                    'Internal Marks',
                    textAlign: TextAlign.center,
                    style: width > 400
                        ? TextStyles.fontStyle6
                        : TextStyles.fontStyle8,
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
                  child: Text(
                    'Attendance',
                    textAlign: TextAlign.center,
                    style: width > 400
                        ? TextStyles.fontStyle6
                        : TextStyles.fontStyle8,
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
                    ref.read(hourwiseProvider.notifier).gethourwiseDetails(
                          ref.read(encryptionProvider.notifier),
                        );
                    ref
                        .read(mainProvider.notifier)
                        .setNavString('Hour Attendance');
                  },
                  child: Text(
                    'Hour Attendance',
                    textAlign: TextAlign.center,
                    style: width > 400
                        ? TextStyles.fontStyle6
                        : TextStyles.fontStyle8,
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
                  child: Text(
                    'Cumulative Attendance',
                    textAlign: TextAlign.center,
                    style: width > 400
                        ? TextStyles.fontStyle6
                        : TextStyles.fontStyle8,
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
                    ref.read(examDetailsProvider.notifier).getExamDetails(
                          ref.read(encryptionProvider.notifier),
                        );
                    ref
                        .read(mainProvider.notifier)
                        .setNavString('Exam Details');
                  },
                  child: Text(
                    'Exam Details',
                    textAlign: TextAlign.center,
                    style: width > 400
                        ? TextStyles.fontStyle6
                        : TextStyles.fontStyle8,
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
