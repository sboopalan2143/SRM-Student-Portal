import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart' as pro;
import 'package:sample/designs/_designs.dart';
import 'package:sample/encryption/encryption_state.dart';
import 'package:sample/home/main_pages/library/riverpod/library_member_state.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/theme-02/mainscreens/lms/mcq_entry%20page.dart';
import 'package:sample/theme-07/mainscreens/academy/lms_pdf_pagetheme07.dart';
import 'package:sample/theme/theme_provider.dart';

class Theme07LmsClassworkDetailPage extends ConsumerStatefulWidget {
  const Theme07LmsClassworkDetailPage({
    required this.classworkID,
    required this.subjectID,
    super.key,
  });

  final String classworkID;
  final String subjectID;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Theme07LmsClassworkDetailPageState();
}

class _Theme07LmsClassworkDetailPageState extends ConsumerState<Theme07LmsClassworkDetailPage> {
  final ScrollController _listController = ScrollController();

  // final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =  GlobalKey<LiquidPullToRefreshState>();

  bool isLoading = false;
  static int refreshNum = 10;
  Stream<int> counterStream = Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(lmsProvider.notifier).getLmsClassWorkDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
          );
      ref.read(lmsProvider.notifier).getLmsAttachmentDetails(
            ref.read(encryptionProvider.notifier),
            widget.classworkID,
          );
    });
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
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);
    ref.listen(lmsProvider, (previous, next) {
      if (next is LibraryTrancsactionStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LibraryTrancsactionStateSuccessful) {
        _showToast(context, next.successMessage, AppColors.greenColor);
      }
    });
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.tertiary,
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
        title: Text(
          'Class Work Details',
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
                    ref.read(lmsProvider.notifier).getLmscommentDetails(
                          ref.read(encryptionProvider.notifier),
                          widget.classworkID,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (provider is LibraryTrancsactionStateLoading)
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 5),
                      Center(
                        child: Text(
                          'No List Added Yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                        ),
                      ),
                    ],
                  ),
                )
              else if (provider.classWorkDetailsData.isEmpty && provider is! LibraryTrancsactionStateLoading)
                Center(
                  child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                ),
              if (provider.classWorkDetailsData.isNotEmpty)
                ListView.builder(
                  itemCount: provider.classWorkDetailsData.length,
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
    final provider = ref.watch(lmsProvider);
    final themeProvider = pro.Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                      'ID',
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
                      '${provider.classWorkDetailsData[index].classworkid}' == ''
                          ? '-'
                          : '${provider.classWorkDetailsData[index].classworkid}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
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
                      'Work Type',
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
                      '${provider.classWorkDetailsData[index].classworktypedesc}' == ''
                          ? '-'
                          : '${provider.classWorkDetailsData[index].classworktypedesc}',
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
                      'Start time',
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
                      '${provider.classWorkDetailsData[index].dpstartdatetime}' == ''
                          ? '-'
                          : '${provider.classWorkDetailsData[index].dpstartdatetime}',
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
                      'End Time',
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
                      '${provider.classWorkDetailsData[index].dpenddatetime}' == ''
                          ? '-'
                          : '${provider.classWorkDetailsData[index].dpenddatetime}',
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
                      'Topic Desc',
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
                      '${provider.classWorkDetailsData[index].topicdesc}' == ''
                          ? '-'
                          : '${provider.classWorkDetailsData[index].topicdesc}',
                      style: TextStyles.fontStyle10.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider is LibraryTrancsactionStateLoading)
                    Center(
                      child: Text(
                        'No List Added',
                        style: TextStyles.fontStyle1.copyWith(
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                    )
                  else if (provider.lmsAttachmentDetailsData.isEmpty && provider is! LibraryTrancsactionStateLoading)
                    const Column(
                      children: [
                        SizedBox(height: 2),
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ],
                    ),
                  if (provider.lmsAttachmentDetailsData.isNotEmpty)
                    ListView.builder(
                      itemCount: provider.lmsAttachmentDetailsData.length,
                      controller: _listController,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return cardStaffAttachmentDesign(index);
                      },
                    ),
                ],
              ),
              if (provider.lmsStudentAttachmentDetailsData.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      if (provider is LibraryTrancsactionStateLoading)
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Center(
                            child: CircularProgressIndicators.theme07primaryColorProgressIndication,
                          ),
                        )
                      else if (provider.lmsStudentAttachmentDetailsData.isEmpty &&
                          provider is! LibraryTrancsactionStateLoading)
                        Column(
                          children: [
                            Center(
                              child: Text(
                                'No Student Attacment',
                                style: TextStyles.smallerBlackColorFontStyle.copyWith(
                                  color: Theme.of(context).colorScheme.inverseSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (provider.lmsStudentAttachmentDetailsData.isNotEmpty)
                        ListView.builder(
                          itemCount: provider.lmsStudentAttachmentDetailsData.length,
                          controller: _listController,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return cardStudentAttachmentDesign(index);
                          },
                        ),
                    ],
                  ),
                ),
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Classwork Replay',
                        style: TextStyles.smallerBlackColorFontStyle.copyWith(
                          color: Theme.of(context).colorScheme.inverseSurface,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: <Widget>[
                          if (imagePaths.isEmpty)
                            GestureDetector(
                              onTap: _pickFile,
                              child: SizedBox(
                                width: 110,
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  color: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                                  child: SizedBox(
                                    width: 300,
                                    height: 100,
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 50,
                                        color: AppColors.theme02buttonColor2,
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
                                        ? Icon(
                                            Icons.picture_as_pdf,
                                            color: AppColors.theme07primaryColor,
                                            size: 50,
                                          )
                                        : image.endsWith('.xlsx') || image.endsWith('.xls')
                                            ? Icon(
                                                Icons.insert_drive_file,
                                                color: AppColors.theme01secondaryColor4,
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
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
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
                                      color: Theme.of(context).colorScheme.primary,
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
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
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
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Remarks',
                            style: TextStyles.alertContentStyle.copyWith(
                              color: Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            child: TextField(
                              controller: provider.remarks,
                              style: TextStyles.fontStyle2.copyWith(
                                color: Theme.of(context).colorScheme.inverseSurface.withAlpha(200),
                              ),
                              decoration: InputDecoration(
                                hintStyle: TextStyles.smallLightAshColorFontStyle.copyWith(
                                  color: Theme.of(context).colorScheme.inverseSurface.withAlpha(150),
                                ),
                                filled: true,
                                fillColor: themeProvider.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                                contentPadding: const EdgeInsets.all(10),
                                enabledBorder: BorderBoxButtonDecorations.loginTextFieldStyle,
                                focusedBorder: BorderBoxButtonDecorations.loginTextFieldStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (provider.remarks.text.isEmpty || imagePaths.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Remarks and attachment are required'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return; // Stop execution if both are empty
                              }

                              ref.read(lmsProvider.notifier).saveClassWorkReplay(
                                    ref.read(encryptionProvider.notifier),
                                    provider.classWorkDetailsData.first.classworkid!,
                                    provider.classWorkDetailsData.first.stuimageattachmentid!,
                                    provider.classWorkDetailsData.first.classworkreplyid!,
                                    provider.classWorkDetailsData.first.fieldrequirement!,
                                    sendData,
                                  );

                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
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
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  if (provider.classWorkDetailsData[index].classworktypedesc?.toLowerCase() == 'mcq')
                    SizedBox(
                      height: 30,
                      width: 150,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            RouteDesign(
                              route: Theme07McqEnteryPage(
                                mcqscheduleid: '${provider.classWorkDetailsData[index].mcqscheduleid}',
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'MCQ Test',
                              style: TextStyles.fontStyle5.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardStaffAttachmentDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);

    final base64File = '${provider.lmsAttachmentDetailsData[index].imageBytes}';
    final fileBytes = base64Decode(base64File);

    final actualname = provider.lmsAttachmentDetailsData[index].actualname ?? '';
    final fileExtension = actualname.split('.').last.toLowerCase();

    log('File Name: $actualname');
    log('File Extension: $fileExtension');

    Widget fileDisplayWidget;

    if (['png', 'jpg', 'jpeg', 'gif'].contains(fileExtension)) {
      fileDisplayWidget = Image.memory(
        fileBytes,
        fit: BoxFit.cover,
        width: width - 100,
        height: 200,
      );
    } else if (fileExtension == 'pdf') {
      fileDisplayWidget = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Theme07PDFViewPage(
                pdfData: fileBytes,
                fileName: actualname,
              ),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              actualname,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else if (fileExtension == 'xls' || fileExtension == 'xlsx') {
      fileDisplayWidget = GestureDetector(
        onTap: () {
          showToast(
            'Excel viewing not supported. File downloaded.',
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.table_chart,
              color: Colors.green,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              actualname,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      fileDisplayWidget = Center(
        child: Text(
          'Unsupported file type',
          style: TextStyles.fontStyle3,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Material(
        elevation: 5,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppColors.theme07primaryColor,
                AppColors.theme07primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Attachment',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: fileDisplayWidget,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            title,
            style: TextStyles.fontStyle13,
          ),
        ),
        Expanded(
          child: Text(
            ':',
            style: TextStyles.fontStyle13,
          ),
        ),
        const SizedBox(width: 5),
        SizedBox(
          width: width / 2 - 60,
          child: Text(
            value.isEmpty ? '-' : value,
            style: TextStyles.fontStyle13,
          ),
        ),
      ],
    );
  }

  Widget cardStudentAttachmentDesign(int index) {
    final width = MediaQuery.of(context).size.width;
    final provider = ref.watch(lmsProvider);

    final base64File = '${provider.lmsStudentAttachmentDetailsData[index].imageBytes}';
    final fileBytes = base64Decode(base64File);
    final actualname = provider.lmsStudentAttachmentDetailsData[index].actualname ?? '';
    final fileExtension = actualname.split('.').last.toLowerCase();
    log('File Name: $actualname');
    log('File Extension: $fileExtension');
    Widget fileDisplayWidget;

    if (['png', 'jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
      // Image display
      fileDisplayWidget = Image.memory(
        fileBytes,
        fit: BoxFit.cover,
      );
    } else if (fileExtension == 'pdf') {
      fileDisplayWidget = GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Theme07PDFViewPage(
                pdfData: fileBytes,
                fileName: actualname,
              ),
            ),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
              size: 30,
            ),
            SizedBox(width: 12),
            Text(
              'Tap to view PDF',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    } else if (fileExtension == 'xls' || fileExtension == 'xlsx') {
      fileDisplayWidget = GestureDetector(
        onTap: () {
          showToast(
            'Excel viewing not supported. File downloaded.',
          );
        },
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.table_chart,
                color: Colors.green,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Tap to download Excel',
                style: TextStyles.fontStyle3,
              ),
            ],
          ),
        ),
      );
    } else {
      // Unsupported file type
      fileDisplayWidget = Center(
        child: Text(
          'Unsupported file type',
          style: TextStyles.fontStyle3,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Material(
        elevation: 5,
        shadowColor: AppColors.theme01secondaryColor4.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                AppColors.theme07primaryColor,
                AppColors.theme07primaryColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ExpansionTile(
              title: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      width: width - 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: fileDisplayWidget,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              collapsedIconColor: AppColors.theme02buttonColor2,
              iconColor: AppColors.theme02buttonColor2,
              children: [
                Divider(color: AppColors.theme01primaryColor.withOpacity(0.5)),
                _buildRow(
                  'Actual name :',
                  '${provider.lmsStudentAttachmentDetailsData[index].actualname}' == 'null'
                      ? '-'
                      : '''${provider.lmsStudentAttachmentDetailsData[index].actualname}''',
                  width,
                ),
                _buildRow(
                  'File name :',
                  '${provider.lmsStudentAttachmentDetailsData[index].filename}' == 'null'
                      ? '-'
                      : '''${provider.lmsStudentAttachmentDetailsData[index].filename}''',
                  width,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
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
      // toastHorizontalMargin: MediaQuery.of(context).size.width / 1,
    );
  }
}
