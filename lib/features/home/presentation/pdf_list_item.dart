import 'package:domi_labs/features/home/domain/pdf_file.dart';
import 'package:domi_labs/routing/routes.dart';
import 'package:domi_labs/styling/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PDFListItem extends StatelessWidget {
  final PdfData pdfData;

  const PDFListItem({
    super.key,
    required this.pdfData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.pdfView, extra: pdfData.file),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/icons/pdf_icon.png",
              height: 30,
              width: 30,
              fit: BoxFit.fill,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pdfData.name, style: AppTextStyle.whiteRegular12),
                  const SizedBox(height: 4),
                  Text('Opened ${pdfData.date}',
                      style: AppTextStyle.whiteRegular12
                          .copyWith(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
