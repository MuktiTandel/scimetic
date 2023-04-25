import 'package:get/get.dart';
import 'package:scimetic/feature/reset_password/controller/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }

}