import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sample/designs/font_styles.dart';
import 'package:sample/home/main_pages/lms/riverpod/lms_state.dart';

class PDFViewScreen extends ConsumerStatefulWidget {
  const PDFViewScreen({
    required this.pdfUrl,
    required this.imageBytes,
    super.key,
  });
  final String pdfUrl;
  final Uint8List imageBytes;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => PDFViewScreenState();
}

class PDFViewScreenState extends ConsumerState<PDFViewScreen> {
  static int refreshNum = 10;
  Stream<int> counterStream =
      Stream<int>.periodic(const Duration(seconds: 1), (x) => refreshNum);

  String? localFilePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    final file = await downloadFile(widget.pdfUrl);
    if (file != null) {
      setState(() {
        localFilePath = file.path;
        isLoading = false;
      });
    }
  }

  Future<File?> downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final file = File('${directory.path}/downloaded.pdf');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
    } catch (e) {
      print("Error downloading file: $e");
    }
    return null;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.watch(lmsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.imageBytes != ''
              ? PDFView(
                  pdfData: widget.imageBytes,
                  fitEachPage: true,
                  fitPolicy: FitPolicy.BOTH,
                  backgroundColor: Colors.grey[300],
                )
              : const Center(
                  child: Text(
                    'No PDF available',
                    style: TextStyles.fontStyle10,
                  ),
                ),
    );
  }
}
