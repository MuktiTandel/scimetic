import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/feature/reports/controller/reports_controller.dart';

class ReportScreen extends StatelessWidget {
   ReportScreen({Key? key}) : super(key: key);

   final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
    );
  }
}
