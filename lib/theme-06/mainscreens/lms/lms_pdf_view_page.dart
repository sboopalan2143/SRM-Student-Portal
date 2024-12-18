import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sample/designs/colors.dart';
import 'package:sample/designs/font_styles.dart';

class Theme06PDFViewPage extends StatelessWidget {
  const Theme06PDFViewPage({
    required this.pdfData,
    required this.fileName,
    super.key,
  });
  final Uint8List pdfData;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/wave.svg',
              fit: BoxFit.fill,
              width: double.infinity,
              color: AppColors.theme01primaryColor,
              colorBlendMode: BlendMode.srcOut,
            ),
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
                fileName,
                style: TextStyles.buttonStyle01theme4,
              ),
              centerTitle: true,
            ),
          ],
        ),
      ),
      body: PDFView(
        onPageChanged: (int? currentPage, int? totalPages) {},
        onError: (error) {},
        onPageError: (page, error) {},
        pdfData: pdfData,
      ),
    );
  }
}
