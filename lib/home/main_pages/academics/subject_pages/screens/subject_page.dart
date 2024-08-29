import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/academics/subject_pages/riverpod/subjects_state.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';

class SubjectPage extends ConsumerStatefulWidget {
  const SubjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubjectPageState();
}

class _SubjectPageState extends ConsumerState<SubjectPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(subjectProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                width: width / 8,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sem',
                      style: TextStyles.fontStyle12,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 8,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Code',
                      style: TextStyles.fontStyle12,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2.3,
                child: const Column(
                  children: [
                    Text(
                      'Subject',
                      style: TextStyles.fontStyle12,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 8,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credit',
                      style: TextStyles.fontStyle12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: ListView.builder(
            itemCount: provider.subjectData.length,
            controller: _listController,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return cardDesign(index);
            },
          ),
        ),
      ],
    );
  }

  Widget cardDesign(int index) {
    final provider = ref.watch(subjectProvider);
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: width / 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${provider.subjectData[index][0]}',
                      style: TextStyles.fontStyle10,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${provider.subjectData[index][1]}',
                      style: TextStyles.fontStyle10small,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 2.3,
                child: Column(
                  children: [
                    Text(
                      '${provider.subjectData[index][2]}',
                      style: TextStyles.fontStyle10small,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: width / 8,
                child: Column(
                  children: [
                    Text(
                      '${provider.subjectData[index][3]}',
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

  Widget navContainerDesign({
    required String text,
  }) {
    final provider = ref.watch(feesProvider);
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // side: BorderSide(
          //   color: AppColors.whiteColor,
          // ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          elevation: 0,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: text == provider.navFeesString
              ? AppColors.primaryColor
              : AppColors.grey1,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          ref.read(feesProvider.notifier).setFeesNavString(text);
        },
        child: text == provider.navFeesString
            ? Text(
                text,
                style: TextStyles.fontStyle11,
              )
            : Text(
                text,
                style: TextStyles.fontStyle11,
              ),
      ),
    );
  }
}
