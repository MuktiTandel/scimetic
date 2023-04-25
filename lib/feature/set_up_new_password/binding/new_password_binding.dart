import 'package:get/get.dart';
import 'package:scimetic/feature/set_up_new_password/controller/new_password_controller.dart';

class NewPasswordBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<NewPasswordController>(() => NewPasswordController());
  }

}