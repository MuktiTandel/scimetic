import 'package:kd_api_call/kd_api_call.dart';
import 'package:scimetic/core/const/app_const.dart';
import 'package:scimetic/core/services/api_path.dart';
import 'package:scimetic/feature/register_new_account/model/create_user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

  http.Response? apiResponse;

  Future createUser(CreateUserModel userModel) async {

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
              url: ApiPath.baseUrl + ApiPath.register,
            requestType: HTTPRequestType.POST,
            headers: {
             "Content-Type" : "application/json"
            },
            parameter: {
                "firstName" : userModel.firstName,
                "lastName" : userModel.lastName,
                "email" : userModel.email,
                "password" : userModel.password,
                "connection" : "Username-Password-Authentication"
            },
          );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      AppConst().debug("Api response => ${apiResponse!.body}");

      if ( apiResponse!.statusCode == 200 ) {
        return true;
      } else {
        return false;
      }

    } catch (e) {

      AppConst().debug(e.toString());

    }

  }

  Future sendVerificationCode({required String email}) async {

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
        url: ApiPath.baseUrl + ApiPath.verificationCode,
        requestType: HTTPRequestType.POST,
        headers: {
          "Content-Type" : "application/json"
        },
        parameter: {
          "email" : email,
        },
      );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      AppConst().debug("Api response => ${apiResponse!.body}");

      if ( apiResponse!.statusCode == 200 ) {
        return true;
      } else {
        return false;
      }

    } catch (e) {

      AppConst().debug(e.toString());

    }

  }

  Future verifyAccount({required String email, required int code}) async {

    try {

      APIRequestInfo apiRequestInfo = APIRequestInfo(
        url: ApiPath.baseUrl + ApiPath.verifyAccount,
        requestType: HTTPRequestType.POST,
        headers: {
          "Content-Type" : "application/json"
        },
        parameter: {
          "email" : email,
          "code" : code
        },
      );

      apiResponse = await ApiCall.instance.callService(requestInfo: apiRequestInfo);

      AppConst().debug("Api response => ${apiResponse!.body}");

      if ( apiResponse!.statusCode == 200 ) {
        return true;
      } else {
        return false;
      }

    } catch (e) {

      AppConst().debug(e.toString());

    }
  }

}