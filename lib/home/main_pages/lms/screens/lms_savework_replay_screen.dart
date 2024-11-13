import 'dart:async';
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
// import 'package:sample/home/riverpod/main_state.dart';

class LmsSaveWorkReplayDetailsDataPage extends ConsumerStatefulWidget {
  const LmsSaveWorkReplayDetailsDataPage({
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

  // String imagepath = '';

  // Future<void> _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.any,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       imagepath = '${result.files.first.path}';
  //       // if (imagepath != '') {
  //       //   imagepath = '';
  //       // }
  //     });
  //   }
  // }

  List<String> imagePaths = [];
  List<Uint8List> imageBytes = [];

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        imagePaths = result.files.map((file) => file.path!).toList();
        imageBytes = imagePaths.map((path) {
          return File(path).readAsBytesSync();
        }).toList();
      });
    }
  }

  // List<String> imagePaths = [];

  // // String imagepath = '';
  // Uint8List? imageBytes;

  // Future<void> _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.any,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       imagepath = '${result.files.first.path}';

  //       if (imagepath.isNotEmpty) {
  //         imageBytes = File(imagepath).readAsBytesSync();
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider = ref.watch(lmsProvider);
    // log('imagebyte >>> ${imageBytes}');
    // log('imagepath >>> ${imagepath}');
    ref.listen(lmsProvider, (previous, next) {
      if (next is LmsStateError) {
        _showToast(context, next.errorMessage, AppColors.redColor);
      } else if (next is LmsStateSuccessful) {
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
                  // Stack(
                  //   children: <Widget>[
                  //     if (imagepath == '')
                  //       GestureDetector(
                  //         onTap: _pickFile,
                  //         child: const SizedBox(
                  //           width: 110,
                  //           child: Card(
                  //             shape: RoundedRectangleBorder(
                  //               side: BorderSide(color: Colors.grey),
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(12)),
                  //             ),
                  //             child: SizedBox(
                  //               width: 300,
                  //               height: 100,
                  //               child: Center(
                  //                 child: Icon(
                  //                   Icons.add,
                  //                   size: 50,
                  //                   color: Colors.grey,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     if (imagepath != '')
                  //       Center(
                  //         child: Stack(
                  //           children: <Widget>[
                  //             ClipRRect(
                  //               borderRadius: BorderRadius.circular(12),
                  //               child: SizedBox(
                  //                 width: 200,
                  //                 height: 200,
                  //                 child: imagepath.endsWith('.pdf')
                  //                     ? const Icon(
                  //                         Icons.picture_as_pdf,
                  //                         color: Colors.red,
                  //                         size: 50,
                  //                       )
                  //                     : imagepath.endsWith('.xlsx') ||
                  //                             imagepath.endsWith('.xls')
                  //                         ? const Icon(
                  //                             Icons.explicit_outlined,
                  //                             color: Colors.blue,
                  //                             size: 50,
                  //                           )
                  //                         : Image.file(
                  //                             File(imagepath),
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     Positioned(
                  //       left: 65,
                  //       top: 65,
                  //       child: Row(
                  //         children: [
                  //           PopupMenuButton(
                  //             shape: const RoundedRectangleBorder(
                  //               borderRadius:
                  //                   BorderRadius.all(Radius.circular(12)),
                  //             ),
                  //             child: SizedBox(
                  //               height: 40,
                  //               width: 40,
                  //               child: Card(
                  //                 shape: RoundedRectangleBorder(
                  //                   side: const BorderSide(color: Colors.grey),
                  //                   borderRadius: BorderRadius.circular(30),
                  //                 ),
                  //                 color: Colors.blue,
                  //                 child: const Padding(
                  //                   padding: EdgeInsets.all(8),
                  //                   child: Icon(
                  //                     Icons.edit,
                  //                     size: 16,
                  //                     color: Colors.white,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             onSelected: (value) {
                  //               _pickFile();
                  //             },
                  //             itemBuilder: (BuildContext context) =>
                  //                 // ignore: strict_raw_type
                  //                 <PopupMenuEntry>[
                  //               PopupMenuItem(
                  //                 child: Row(
                  //                   children: [
                  //                     const Icon(
                  //                       Icons.photo_library,
                  //                       color: Colors.blue,
                  //                     ),
                  //                     Expanded(
                  //                       child: TextButton(
                  //                         onPressed: () {
                  //                           Navigator.pop(context);
                  //                           _pickFile();
                  //                         },
                  //                         child: const Text(
                  //                           'Add File',
                  //                           style: TextStyle(fontSize: 16),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
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
                          children: imagePaths.map((imagePaths) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: imagePaths.endsWith('.pdf')
                                    ? const Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 50,
                                      )
                                    : imagePaths.endsWith('.xlsx') ||
                                            imagePaths.endsWith('.xls')
                                        ? const Icon(
                                            Icons.insert_drive_file,
                                            color: Colors.blue,
                                            size: 50,
                                          )
                                        : Image.file(
                                            File(imagePaths),
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
                                imageBytes.first,
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
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



// import 'dart:io';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';

// class FilePickerExample extends StatefulWidget {
//   @override
//   _FilePickerExampleState createState() => _FilePickerExampleState();
// }

// class _FilePickerExampleState extends State<FilePickerExample> {
//   List<String> imagePaths = [];

//   Future<void> _pickFiles() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       allowMultiple: true, // Allow multiple files
//     );

//     if (result != null) {
//       setState(() {
//         imagePaths = result.paths.whereType<String>().toList();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Multiple File Picker'),
//       ),
//       body: Center(
//         child: Stack(
//           children: <Widget>[
//             if (imagePaths.isEmpty)
//               GestureDetector(
//                 onTap: _pickFiles,
//                 child: const SizedBox(
//                   width: 110,
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       side: BorderSide(color: Colors.grey),
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                     ),
//                     child: SizedBox(
//                       width: 300,
//                       height: 100,
//                       child: Center(
//                         child: Icon(
//                           Icons.add,
//                           size: 50,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             else
//               Wrap(
//                 spacing: 10,
//                 runSpacing: 10,
//                 children: imagePaths.map((imagePath) {
//                   return ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: SizedBox(
//                       width: 100,
//                       height: 100,
//                       child: imagePath.endsWith('.pdf')
//                           ? const Icon(
//                               Icons.picture_as_pdf,
//                               color: Colors.red,
//                               size: 50,
//                             )
//                           : imagePath.endsWith('.xlsx') ||
//                                   imagePath.endsWith('.xls')
//                               ? const Icon(
//                                   Icons.insert_drive_file,
//                                   color: Colors.blue,
//                                   size: 50,
//                                 )
//                               : Image.file(
//                                   File(imagePath),
//                                   fit: BoxFit.cover,
//                                 ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             Positioned(
//               left: 65,
//               top: 65,
//               child: Row(
//                 children: [
//                   PopupMenuButton(
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                     ),
//                     child: SizedBox(
//                       height: 40,
//                       width: 40,
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           side: const BorderSide(color: Colors.grey),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         color: Colors.blue,
//                         child: const Padding(
//                           padding: EdgeInsets.all(8),
//                           child: Icon(
//                             Icons.edit,
//                             size: 16,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     onSelected: (value) {
//                       _pickFiles();
//                     },
//                     itemBuilder: (BuildContext context) => <PopupMenuEntry>[
//                       PopupMenuItem(
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.photo_library,
//                               color: Colors.blue,
//                             ),
//                             Expanded(
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   _pickFiles();
//                                 },
//                                 child: const Text(
//                                   'Add Files',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

