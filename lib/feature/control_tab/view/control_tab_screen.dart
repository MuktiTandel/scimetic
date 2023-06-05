import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scimetic/feature/control_tab/controller/control_tab_controller.dart';

class ControlTabScreen extends StatelessWidget {
   ControlTabScreen({Key? key}) : super(key: key);

   final controller = Get.put(ControlTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
