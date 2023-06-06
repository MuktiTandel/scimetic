import 'dart:convert';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/elements/custom_snack.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/core/utils/store_data.dart';
import 'package:http/http.dart' as http;
import 'package:scimetic/feature/temperature_control/model/switch_model.dart';

class ApiService {

  http.Response? apiResponse;

  String token = "";

  StoreData storeData = StoreData();

  SwitchModel switchModel = SwitchModel();

  List<String> switchList = [];

  Future getSwitchData() async {

    token =  storeData.getString(StoreData.accessToken)!;

    if ( token.isNotEmpty ) {
      try {

        APIRequestInfo apiRequestInfo = APIRequestInfo(
            url: '${ApiPath.baseUrl}${ApiPath.switches}',
            requestType: HTTPRequestType.GET,
            headers: {
              "Authorization" : 'Bearer $token',
            }
        );

        apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

        AppConst().debug("Api response => ${apiResponse!.statusCode}");

        dynamic data = jsonDecode(apiResponse!.body);

        if ( apiResponse!.statusCode == 200 ) {

          switchModel = SwitchModel.fromJson(data);

          if ( switchModel.devices!.isNotEmpty ) {

            switchList.clear();

            for (var element in switchModel.devices!) {
              switchList.add(element.serialNumber!);
            }
          }

          AppConst().debug("switches list length => ${switchList.length}");


          return true;

        } else {

            showSnack(
                width: 200.w,
                title: data["message"]
            );

          return false;
        }

      } catch (e) {

        AppConst().debug(e.toString());

      }
    }

  }

}