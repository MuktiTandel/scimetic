import 'package:get/get.dart';
import 'package:scimetic/feature/authenticate_your_account/controller/authenticate_account_controller.dart';

class AuthenticateAccountBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AuthenticateAccountController>(() => AuthenticateAccountController());
  }


}