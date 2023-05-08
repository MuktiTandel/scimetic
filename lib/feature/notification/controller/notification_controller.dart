import 'package:get/get.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/notification/model/message_model.dart';

class NotificationController extends GetxController {

  List<MessageModel> messageList = [
    MessageModel(
        image: AppImages.andrewJohnson,
        name: AppStrings.andrewJohnson,
        time: 1
    ),
    MessageModel(
        image: AppImages.alisaSimmons,
        name: AppStrings.alisaSimmons,
        time: 1
    )
  ];


}