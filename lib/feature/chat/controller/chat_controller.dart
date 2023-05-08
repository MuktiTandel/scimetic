import 'package:get/get.dart';
import 'package:scimetic/core/const/app_images.dart';
import 'package:scimetic/core/const/app_strings.dart';
import 'package:scimetic/feature/chat/model/chat_model.dart';

class ChatController extends GetxController {

  List<ChatModel> chatList = [
    ChatModel(
        AppImages.group14,
        AppStrings.andrewJohnson,
        AppStrings.shortTaskDescription,
        4,
      0,
      AppImages.group6,
      AppImages.group7,
      "chat"
    ),
    ChatModel(
        AppImages.group6,
        AppStrings.workGroupChat,
        AppStrings.shortTaskDescription,
        4,
        5,
        AppImages.group7,
        AppImages.group8,
        "group"
    ),
    ChatModel(
        AppImages.group9,
        AppStrings.andrewJohnson,
        AppStrings.shortTaskDescription,
        20,
        0,
        AppImages.group6,
        AppImages.group7,
        "chat"
    ),
    ChatModel(
        AppImages.group10,
        AppStrings.andrewJohnson,
        AppStrings.shortTaskDescription,
        4,
        0,
        AppImages.group6,
        AppImages.group7,
        "chat"
    ),
    ChatModel(
        AppImages.group11,
        AppStrings.workGroupChat,
        AppStrings.shortTaskDescription,
        14,
        9,
        AppImages.group12,
        AppImages.group13,
        "group"
    ),

  ];

}