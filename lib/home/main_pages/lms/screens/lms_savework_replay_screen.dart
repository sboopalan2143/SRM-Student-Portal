import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';
// import 'package:sample/home/riverpod/main_state.dart';

class LmsSaveWorkReplayDetailsDataPage extends ConsumerStatefulWidget {
  const LmsSaveWorkReplayDetailsDataPage({
    required this.classworkID,
    required this.classworkreplyid,
    required this.fieldrequirements,
    required this.action,
    required this.fileid,
    super.key,
  });
  final String classworkID;
  final String classworkreplyid;
  final String fieldrequirements;
  final String action;
  final String fileid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      LmsSaveWorkReplayDetailsDataPageState();
}

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
}

class LmsSaveWorkReplayDetailsDataPageState
    extends ConsumerState<LmsSaveWorkReplayDetailsDataPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
      //       ref.read(encryptionProvider.notifier),
      //       widget.classworkID,
      //     );
    });
  }

  String imagepath = '';

  // Future<void> _pickPDF() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     setState(() {
  //       imagepath = '${result.files.first.path}';
  //       // if (uploadproductbill != '') {
  //       //   uploadproductbill = '';
  //       // }
  //     });
  //   }
  // }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setState(() {
        imagepath = '${result.files.first.path}';
        if (imagepath != '') {
          imagepath = '';
        }
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    // final width = MediaQuery.of(context).size.width;
    ref.watch(lmsProvider);
    // ref.listen(lmsProvider, (previous, next) {
    //   if (next is LibraryTrancsactionStateError) {
    //     _showToast(context, next.errorMessage, AppColors.redColor);
    //   } else if (next is LibraryTrancsactionStateSuccessful) {
    //     _showToast(context, next.successMessage, AppColors.greenColor);
    //   }
    //   log('classworkdeta >>> ${provider.classWorkDetailsData.length}');
    // });

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColor,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  // ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
                  //       ref.read(encryptionProvider.notifier),
                  //       widget.classworkID,
                  //     );
                  Navigator.pop(context);
                  // Navigator.push(
                  //   context,
                  //   RouteDesign(
                  //     route: const HomePage2(),
                  //   ),
                  // );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.whiteColor,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Save Attachments',
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
                          // ref
                          //     .read(lmsProvider.notifier)
                          //     .getLmsAttachmentDetails(
                          //       ref.read(encryptionProvider.notifier),
                          //       widget.classworkID,
                          //     );
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 0,
          color: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Remarks',
                      style: TextStyles.fontStyle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // SizedBox(
                    //   height: 40,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       _pickFile();
                    //     },
                    //     child: const Text(
                    //       'Add PDF',
                    //       style: TextStyles.fontStyle2,
                    //     ),
                    //   ),
                    // ),
                    // Image.file(
                    //   height: 200,
                    //   width: 100,
                    //   File(imagepath),
                    //   fit: BoxFit.cover,
                    // ),
                    Stack(
                      children: <Widget>[
                        if (imagepath == '')
                          GestureDetector(
                            child: const SizedBox(
                              width: 110,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.homepagecolor2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: SizedBox(
                                  width: 300,
                                  height: 100,
                                  child: Center(
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (imagepath != '')
                          Center(
                            child: Stack(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                      50,
                                    ),
                                    child: imagepath.endsWith('.pdf')
                                        ? const Icon(
                                            Icons.picture_as_pdf,
                                            color: Colors.red,
                                            size: 50,
                                          )
                                        : Image.file(
                                            File(imagepath),
                                            height: 200,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Positioned(
                          left: 65,
                          top: 65,
                          child: Row(
                            children: [
                              PopupMenuButton<SampleItem>(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        color: AppColors.homepagecolor2,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: AppColors.primaryColor,
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                        left: 8,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onSelected: (SampleItem item) {},
                                itemBuilder: (
                                  BuildContext context,
                                ) =>
                                    <PopupMenuEntry<SampleItem>>[
                                  PopupMenuItem<SampleItem>(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.photo_library,
                                          color: AppColors.primaryColor2,
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(
                                                  context,
                                                );
                                                _pickFile();
                                              },
                                              child: const Text(
                                                'Add PDF',
                                                style: TextStyles.fontStyle2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Remarks',
                      style: TextStyles.fontStyle2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextField(
                        // controller: provider.confirmPassword,
                        style: TextStyles.fontStyle2,
                        decoration: InputDecoration(
                          hintStyle: TextStyles.smallLightAshColorFontStyle,
                          filled: true,
                          fillColor: AppColors.secondaryColor,
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                          focusedBorder:
                              BorderBoxButtonDecorations.loginTextFieldStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(lmsProvider.notifier).saveClassWorkReplay(
                              ref.read(encryptionProvider.notifier),
                              widget.classworkID,
                              widget.classworkreplyid,
                              widget.fieldrequirements,
                              widget.action,
                              widget.fileid,
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        foregroundColor: Colors.white,
                        elevation: 5,
                      ),
                      child: const Text(
                        'Question and Answer',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
    );
  }
}
