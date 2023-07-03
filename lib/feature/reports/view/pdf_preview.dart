import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:scimetic/feature/reports/controller/reports_controller.dart';

class PdfPreviewPage extends StatelessWidget {
   PdfPreviewPage({Key? key}) : super(key: key);

   final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => controller.makePdf(
            companyName: "testing",
          batchId: "10123",
          createdBy: "test"
        ),
      ),
    );
  }
}
