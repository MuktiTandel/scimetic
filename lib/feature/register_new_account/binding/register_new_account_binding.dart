import 'package:get/get.dart';
import 'package:scimetic/feature/register_new_account/controller/register_new_account_controller.dart';

class RegisterNewAccountBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<RegisterNewAccountController>(() => RegisterNewAccountController());
  }

}