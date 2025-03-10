// ignore_for_file: document_ignores, strict_raw_type

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class LmsSaveWorkReplayDataPageTheme3 extends ConsumerStatefulWidget {
  const LmsSaveWorkReplayDataPageTheme3({
    required this.classworkID,
    required this.classworkreplyid,
    required this.fieldrequirements,
    required this.imageattachmentid,
    super.key,
  });
  final String classworkID;
  final String classworkreplyid;
  final String fieldrequirements;
  final String imageattachmentid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      LmsSaveWorkReplayDataPageTheme3State();
}

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
}

class LmsSaveWorkReplayDataPageTheme3State
    extends ConsumerState<LmsSaveWorkReplayDataPageTheme3> {
  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  List<String> imagePaths = [];
  List<String> imageName = [];
  List<String> sampledata = [];
  List<Uint8List> imageBytes = [];
  String sendData = '';

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    // if (result != null) {
    //   setState(() {
    //     imagePaths = result.files.map((file) => file.path!).toList();
    //     imageName = result.files.map((file) => file.name).toList();
    //     imageBytes = imagePaths.map((path) {
    //       return File(path).readAsBytesSync();
    //     }).toList();
    //     log('data >>> $sampledata');
    //     for (var i = 0; i < imagePaths.length; i++) {
    //       final con = base64Encode(imageBytes[i]);
    //       sampledata.add('${imageName[i]}!^!${imagePaths[i]}');
    //       log('Combined Data>>>>>>>>>$sampledata');
    //     }
    //     // log('data >>> $data');
    //     // sendData = data.join(', ');
    //     // log('sendData >>> $sendData');

    //     // log('imagePaths Length >>>>>>> ${imageName.length}');
    //     // log('imageBytes Length >>>>>>> ${imageBytes.length}');
    //   });
    // }
    if (result != null) {
      setState(() {
        // Extracting image paths and names
        imagePaths = result.files.map((file) => file.path!).toList();
        imageName = result.files.map((file) => file.name).toList();

        // Reading file bytes
        imageBytes = imagePaths.map((path) {
          return File(path).readAsBytesSync();
        }).toList();

        // Clearing sampledata to avoid duplicate entries on repeated calls
        sampledata.clear();

        // Combining image data
        for (var i = 0; i < imagePaths.length; i++) {
          final base64String = base64Encode(imageBytes[i]);
          sampledata.add('${imageName[i]}!^!$base64String');
          // log('Base64 Encoded Data: $base64String');
          // log('Combined Data: $sampledata');
        }

        // Joining the list into a single string for further use
        sendData = sampledata.join(', ');
        // log('Final Combined Data as String: $sendData');
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider = ref.watch(lmsProvider);

    // for (var i = 0; i < imagePaths.length; i++) {
    //   final con = base64Encode(imageBytes[i]);
    //   data.add('${imageName[i]}!^!${imagePaths[i]}');
    //   log('Combined Data>>>>>>>>>$data');
    // }

    // sendData = data.join(', ');
    // log('sendData >>> $sendData');

    // log('imagePaths Length >>>>>>> ${imageName.length}');
    // log('imageBytes Length >>>>>>> ${imageBytes.length}');

    ref.listen(lmsProvider, (previous, next) {
      if (next is LmsStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LmsStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColorTheme3);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.secondaryColorTheme3,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.primaryColorTheme3,
              colorBlendMode: BlendMode.srcOut,
            ),
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
                        onTap: () {},
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 0,
            color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: <Widget>[
                      if (imagePaths.isEmpty)
                        GestureDetector(
                          onTap: _pickFile,
                          child: const SizedBox(
                            width: 110,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: SizedBox(
                                width: 300,
                                height: 100,
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      else
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: imagePaths.map((image) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: image.endsWith('.pdf')
                                    ? const Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 50,
                                      )
                                    : image.endsWith('.xlsx') ||
                                            image.endsWith('.xls')
                                        ? const Icon(
                                            Icons.insert_drive_file,
                                            color: Colors.blue,
                                            size: 50,
                                          )
                                        : Image.file(
                                            File(image),
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            );
                          }).toList(),
                        ),
                      Positioned(
                        left: 65,
                        top: 65,
                        child: Row(
                          children: [
                            PopupMenuButton(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: Colors.blue,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              onSelected: (value) {
                                _pickFile();
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.photo_library,
                                        color: Colors.blue,
                                      ),
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _pickFile();
                                          },
                                          child: const Text(
                                            'Add Files',
                                            style: TextStyle(fontSize: 16),
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
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Action',
                        style: TextStyles.fontStyle2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: provider.action,
                          style: TextStyles.fontStyle2,
                          decoration: InputDecoration(
                            hintStyle: TextStyles.smallLightAshColorFontStyle,
                            filled: true,
                            fillColor: AppColors.secondaryColorTheme3,
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
                          controller: provider.remarks,
                          style: TextStyles.fontStyle2,
                          decoration: InputDecoration(
                            hintStyle: TextStyles.smallLightAshColorFontStyle,
                            filled: true,
                            fillColor: AppColors.secondaryColorTheme3,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref.read(lmsProvider.notifier).saveClassWorkReplay(
                                ref.read(encryptionProvider.notifier),
                                widget.classworkID,
                                widget.imageattachmentid,
                                widget.classworkreplyid,
                                widget.fieldrequirements,
                                sendData,
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColorTheme3,
                          elevation: 5,
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: const DrawerDesign(),
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
