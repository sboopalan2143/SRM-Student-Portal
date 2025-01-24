import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/designs/_designs.dart';

class OfflinePage extends ConsumerStatefulWidget {
  const OfflinePage({super.key});

  @override
  ConsumerState createState() => _OfflinePageState();
}

class _OfflinePageState extends ConsumerState<OfflinePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        appBar: StatusBarNavigationBarDesigns.noAppBar,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/svg/no_network.svg',
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'No Internet Available',
              style: TextStyles.lessSmallerBlackColorFontStyle,
            ),
          ],
        ),
      ),
    );
  }
}
