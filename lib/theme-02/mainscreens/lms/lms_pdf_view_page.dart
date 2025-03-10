
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/designs/navigation_style.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';
import 'package:sample/theme-02/mainscreens/lms/lms_attachment_screen.dart';

class Theme02PDFViewPage extends StatefulWidget {
  const Theme02PDFViewPage({
    required this.pdfData,
    required this.fileName,
    super.key,
  });

  final Uint8List pdfData;
  final String fileName;

  @override
  State<Theme02PDFViewPage> createState() => _Theme02PDFViewPageState();
}

class _Theme02PDFViewPageState extends State<Theme02PDFViewPage> {
  PDFViewController? _pdfController;
  int _currentPage = 0;
  int _totalPages = 0;
  Set<int> _readPages = {}; // To track read pages
  bool _isPageRead = false; // Track if the current page is read or not

  // Function to show page selection dialog
  void _selectPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController pageController = TextEditingController();
        return AlertDialog(
          title: const Text('Enter Page Number'),
          content: TextField(
            controller: pageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Page number'),
            onChanged: (value) {
              setState(() {});
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                int pageNumber = int.tryParse(pageController.text) ?? 1;
                if (pageNumber > 0 && pageNumber <= _totalPages) {
                  _pdfController
                      ?.setPage(pageNumber - 1); // Navigate to the page
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid page number!')),
                  );
                }
              },
              child: const Text('Go'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.theme02primaryColor,
                  AppColors.theme02secondaryColor1,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
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
          title: Text(
            widget.fileName,
            style: TextStyles.fontStyle4,
          ),
          centerTitle: true,
          actions: [
            // Search button in the AppBar
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                _selectPage(
                    context); // Show the page selection dialog when clicked
              },
            ),
            // Show page number in AppBar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                '${_currentPage + 1} / $_totalPages',
                style: TextStyles.fontStyle4.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // PDFView widget displaying the PDF file
          PDFView(
            pdfData: widget.pdfData,
            onRender: (pages) {
              setState(() {
                _totalPages = pages ?? 0;
              });
            },
            onViewCreated: (PDFViewController controller) {
              _pdfController = controller;
            },
            onPageChanged: (int? currentPage, int? totalPages) {
              setState(() {
                _currentPage = currentPage ?? 0;
                _isPageRead =
                    _readPages.contains(_currentPage); // Update the read status
              });
            },
            onError: (error) {
              debugPrint(error.toString());
            },
            onPageError: (page, error) {
              debugPrint("Page $page error: $error");
            },
          ),

          // Show "Marked as Read" if the page is read
          Positioned(
            bottom: 80,
            right: 20,
            child: _isPageRead
                ? Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Read ✅',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),

      // Floating Action Button to mark page as read
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_isPageRead) {
              _readPages.remove(_currentPage); // Mark as not read
              _isPageRead = false;
            } else {
              _readPages.add(_currentPage); // Mark as read
              _isPageRead = true;
            }
          });
        },
        backgroundColor: _isPageRead ? Colors.green : Colors.blue,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}

// >>>>>>>>>>>>>>>>>>>>>>>
// voice pdf try
//
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/services.dart';
//
// class Theme02PDFViewPage extends StatefulWidget {
//   const Theme02PDFViewPage({super.key});
//
//   @override
//   State<Theme02PDFViewPage> createState() => _Theme02PDFViewPageState();
// }
//
// class _Theme02PDFViewPageState extends State<Theme02PDFViewPage> {
//   FlutterTts flutterTts = FlutterTts();
//   String _extractedText = "No text extracted";
//   Uint8List? _pdfData;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupTTS();
//   }
//
//   void _setupTTS() async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setSpeechRate(0.5);
//     await flutterTts.setPitch(1.0);
//   }
//
//   Future<void> _pickPDF() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );
//
//     if (result != null) {
//       setState(() {
//         _pdfData = result.files.first.bytes;
//       });
//       _extractText();
//     }
//   }
//
//   Future<void> _extractText() async {
//     if (_pdfData == null) return;
//
//     try {
//       PdfDocument document = PdfDocument(inputBytes: _pdfData);
//       String text = PdfTextExtractor(document).extractText();
//       document.dispose();
//
//       setState(() {
//         _extractedText = text.isNotEmpty ? text : "No readable text found.";
//       });
//     } catch (e) {
//       setState(() {
//         _extractedText = "Failed to extract text: $e";
//       });
//     }
//   }
//
//   Future<void> _readText() async {
//     if (_extractedText.isNotEmpty) {
//       await flutterTts.speak(_extractedText);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("PDF Text Reader")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ElevatedButton(
//               onPressed: _pickPDF,
//               child: const Text("Pick a PDF File"),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   _extractedText,
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _readText,
//         child: const Icon(Icons.volume_up),
//       ),
//     );
//   }
// }

// >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
