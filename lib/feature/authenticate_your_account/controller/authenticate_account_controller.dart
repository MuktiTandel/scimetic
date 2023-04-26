import 'package:get/get.dart';
import 'package:scimetic/core/const/app_const.dart';

class AuthenticateAccountController extends GetxController {

  String email = "";

  @override
  void onInit() {
    super.onInit();

    email = Get.arguments["email"];

    AppConst().debug('email => $email');
  }

  getEmail() {

    String first = email.split("@").first;
    String last = email.split("@").last;

    String firstLatter = first.substring(0, 2);
    String lastLatter = first.substring(first.length - 2, first.length);

    String middleLatter = first.substring(2, first.length - 2);

    String middle = middleLatter.replaceRange(0, middleLatter.length, "*" * middleLatter.length);

    String email_ = "$firstLatter$middle$lastLatter@$last";

    return email_;

  }
}