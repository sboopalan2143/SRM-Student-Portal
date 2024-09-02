import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/designs/_designs.dart';

import 'package:sample/home/riverpod/main_state.dart';

class LMSPage extends ConsumerStatefulWidget {
  const LMSPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LMSPageState();
}

class _LMSPageState extends ConsumerState<LMSPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                ref
                    .read(mainProvider.notifier)
                    .setNavString('Online Assessment');
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
                ref.read(mainProvider.notifier).setNavString('Notes');
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
    );
  }
}
