import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/notification/riverpod/notification_state.dart';
import 'package:sample/home/screen/home_page.dart';
import 'package:sample/home/screen/home_page2.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  final ScrollController _listController = ScrollController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationProvider.notifier).getNotificationDetails(
            ref.read(encryptionProvider.notifier),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(notificationProvider);

    ref.listen(notificationProvider, (previous, next) {
      if (next is NotificationError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is NotificationSuccessFull) {
        /// Handle route to next page.

        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/Grievancesappbar.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    RouteDesign(
                      route: const HomePage2(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'NOTIFICATION',
                style: TextStyles.fontStyle4,
                overflow: TextOverflow.clip,
              ),
              centerTitle: true,
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
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 45,
                  width: width - 50,
                  decoration: BoxDecoration(
                    color: AppColors.grey1,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: AppColors.grey1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: navContainerDesign(
                            text: 'From Staff',
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: navContainerDesign(
                            text: 'From Circular',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (provider is NotificationLoading)
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                child:
                    CircularProgressIndicators.primaryColorProgressIndication,
              ),
            )
          else if (provider.notificationData.isEmpty &&
              provider is! NotificationLoading)
            Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 5),
                const Center(
                  child: Text(
                    'No List Added Yet!',
                    style: TextStyles.fontStyle6,
                  ),
                ),
              ],
            ),
          if (provider.notificationData.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView.builder(
                itemCount: 20,
                controller: _listController,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return provider.navNotificationString == 'From Staff'
                      ? cardDesignStaff(index)
                      : cardDesignCircular(index);
                },
              ),
            ),
        ],
      ),
      endDrawer: const DrawerDesign(),
    );
  }

  Widget cardDesignStaff(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/profile.png',
                    height: 20,
                  ),
                  const SizedBox(width: 10),
                  const Text('Ravi : ', style: TextStyles.fontStyle10),
                  const Text(
                    '  Lorem Ipsum is simply dummy text',
                    style: TextStyles.fontStyle15,
                  ),
                ],
              ),
              const Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.restore, color: AppColors.grey2),
                  SizedBox(width: 10),
                  Text(
                    '17:05 | 28:05:2024',
                    style: TextStyles.fontStyle15,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesignCircular(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
        child: const Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '  Lorem Ipsum is simply dummy text',
                    style: TextStyles.fontStyle15,
                  ),
                ],
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.restore, color: AppColors.grey2),
                  SizedBox(width: 10),
                  Text(
                    '17:05 | 28:05:2024',
                    style: TextStyles.fontStyle15,
                  ),
                ],
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
    final provider = ref.watch(notificationProvider);
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
          backgroundColor: text == provider.navNotificationString
              ? AppColors.primaryColor
              : AppColors.grey1,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {
          ref
              .read(notificationProvider.notifier)
              .setNotificationNavString(text);
        },
        child: text == provider.navNotificationString
            ? FittedBox(
                child: Text(
                  text,
                  style: TextStyles.fontStyle13,
                ),
              )
            : FittedBox(
                child: Text(
                  text,
                  style: TextStyles.smallLightAshColorFontStyle,
                ),
              ),
      ),
    );
  }

  void _showToast(BuildContext context, String message, Color color) {
    showToast(
      message,
      context: context,
      backgroundColor: color,
      axis: Axis.horizontal,
      alignment: Alignment.centerLeft,
      position: StyledToastPosition.center,
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(15),
        bottomLeft: Radius.circular(15),
      ),
      toastHorizontalMargin: MediaQuery.of(context).size.width / 3,
    );
  }
}
