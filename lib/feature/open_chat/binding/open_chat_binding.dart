import 'package:get/get.dart';
import 'package:scimetic/feature/open_chat/controller/open_chat_controller.dart';

class OpenChatBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => OpenChatController());
  }


}