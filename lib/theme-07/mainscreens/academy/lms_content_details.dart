import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/lms/lms%20content%20details/content%20details%20riverpod/lms_content_details_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/theme/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Theme07LmsContentDetailsPage extends ConsumerStatefulWidget {
  const Theme07LmsContentDetailsPage({required this.subjectid, super.key});

  final String subjectid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07LmsContentDetailsPageState();
}

class _Theme07LmsContentDetailsPageState extends ConsumerState<Theme07LmsContentDetailsPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await ref.read(lmsContentDetailsProvider.notifier).getLmsContentDetails(
              ref.read(encryptionProvider.notifier),
              widget.subjectid,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsContentDetailsProvider);
    ref.listen(lmsProvider, (previous, next) {
      if (next is LmsContentDetailsError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LmsContentDetailsError) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          elevation: 0,
          title: Text(
            'LMS CONTENT DETAILS',
            style: TextStyles.fontStyle4,
            overflow: TextOverflow.clip,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.read(lmsContentDetailsProvider.notifier).getLmsContentDetails(
                            ref.read(encryptionProvider.notifier),
                            widget.subjectid,
                          );
                    },
                    child: const Icon(
                      Icons.refresh,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 20),
              if (provider is LmsStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                  ),
                )
              else if (provider.lmsContentData.isEmpty && provider is! LmsStateLoading)
                Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 5),
                    Center(
                      child: Text(
                        'No List Added',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                      ),
                    ),
                  ],
                ),
              if (provider.lmsContentData.isNotEmpty)
                ListView.builder(
                  itemCount: provider.lmsContentData.length,
                  controller: _listController,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return cardDesign(index);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsContentDetailsProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Emp Name',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.lmsContentData[index].employeefirstandmidname}' == ''
                          ? '-'
                          : '${provider.lmsContentData[index].employeefirstandmidname}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Upload Date',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.lmsContentData[index].uploadeddate}' == ''
                          ? '-'
                          : '${provider.lmsContentData[index].uploadeddate}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width / 2 - 80,
                    child: Text(
                      'Description',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                  Text(
                    ':',
                    style: TextStyles.fontStyle10.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SizedBox(
                    width: width / 2 - 60,
                    child: Text(
                      '${provider.lmsContentData[index].description}' == ''
                          ? '-'
                          : '${provider.lmsContentData[index].description}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          log('lms Content URL ${provider.lmsContentData[index].url}');

                          final url = Uri.parse('${provider.lmsContentData[index].url}');

                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.inAppWebView,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Could not launch the URL')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.theme07primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),
                        child: Text(
                          provider.lmsContentData[index].url.toString().isNotEmpty ? 'Open URL' : 'Download Content',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
