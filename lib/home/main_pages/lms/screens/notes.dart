import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/home/main_pages/fees/riverpod/fees_state.dart';
import 'package:sample/home/riverpod/main_state.dart';

class NotesPage extends ConsumerStatefulWidget {
  const NotesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NotesPageState();
}

class _NotesPageState extends ConsumerState<NotesPage> {
  final ScrollController _listController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text('Select Topic', style: TextStyles.alertContentStyle),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView.builder(
            itemCount: 20,
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
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: () {
          ref
              .read(mainProvider.notifier)
              .setNavString('C Programming Language1');
        },
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
                  width: width / 2 - 70,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sem 1',
                        style: TextStyles.fontStyle10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  width: width / 2 - 20,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'C Programming Language',
                        style: TextStyles.fontStyle10,
                      ),
                    ],
                  ),
                )
              ],
            ),
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
