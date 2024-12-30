import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/home/widgets/drawer_design.dart';

class Theme01LmsSaveWorkReplayDetailsDataPage extends ConsumerStatefulWidget {
  const Theme01LmsSaveWorkReplayDetailsDataPage({
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
      Theme01LmsSaveWorkReplayDetailsDataPageState();
}

enum SampleItem {
  itemOne,
  itemTwo,
  itemThree,
}

class Theme01LmsSaveWorkReplayDetailsDataPageState
    extends ConsumerState<Theme01LmsSaveWorkReplayDetailsDataPage> {
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

    if (result != null) {
      setState(() {
        // Extracting image paths and names
        imagePaths = result.files.map((file) => file.path!).toList();
        imageName = result.files.map((file) => file.name).toList();

        // Reading file bytes
        imageBytes = imagePaths.map((path) {
          return File(path).readAsBytesSync();
        }).toList();

        sampledata.clear();

        for (var i = 0; i < imagePaths.length; i++) {
          final base64String = base64Encode(imageBytes[i]);
          sampledata.add('${imageName[i]}!^!$base64String');
          log('Base64 Encoded Data: $imageBytes');
          log('Combined Data: $sampledata');
        }
        sendData = sampledata.join(', ');
      });
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider = ref.watch(lmsProvider);

    ref.listen(lmsProvider, (previous, next) {
      if (next is LmsStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LmsStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: AppColors.theme01primaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.theme01primaryColor,
                ),
              ),
              backgroundColor: AppColors.theme01secondaryColor4,
              elevation: 0,
              title: Text(
                'Save Attachments',
                style: TextStyles.buttonStyle01theme4,
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
                        child: Icon(
                          Icons.refresh,
                          color: AppColors.theme01primaryColor,
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
            color: AppColors.theme01primaryColor,
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
                          child: SizedBox(
                            width: 110,
                            child: Card(
                              shape: const RoundedRectangleBorder(
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
                                    color: AppColors.theme01primaryColor,
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
                                        ? Icon(
                                            Icons.insert_drive_file,
                                            color: AppColors
                                                .theme01secondaryColor4,
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
                                    side: BorderSide(
                                      color: AppColors.theme01secondaryColor4,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: AppColors.theme01secondaryColor4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      Icons.edit,
                                      size: 16,
                                      color: AppColors.theme01primaryColor,
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
                      Text(
                        'Action',
                        style: TextStyles.theme01primary10smal3,
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
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remarks',
                        style: TextStyles.theme01primary10smal3,
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
                          backgroundColor: AppColors.theme01secondaryColor4,
                          elevation: 5,
                        ),
                        child: Text(
                          'Submit',
                          style:
                              TextStyle(color: AppColors.theme01primaryColor),
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
