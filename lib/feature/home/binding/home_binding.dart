import 'package:get/get.dart';
import 'package:scimetic/feature/home/controller/home_controller.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }

}