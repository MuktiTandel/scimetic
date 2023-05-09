import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scimetic/core/const/app_const.dart';

class OpenChatController extends GetxController {

  final TextEditingController messageController = TextEditingController();

  RxBool emojiShowing = false.obs;

  Future selectFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if ( result != null ) {
      var file = result.files.first.path;
      AppConst().debug('file Path => $file');
    } else {
      AppConst().debug("File not select");
    }
  }

}