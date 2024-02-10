import 'package:dio/dio.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/contact_UsBody.dart';
import '../model/response/base/api_response.dart';

class MainRepo {
  final DioClient dioClient;
  MainRepo({required this.dioClient});

  Future<ApiResponse> contactUs(ContactUsBody contactUsBody) async {
    try {
      Response response = await dioClient.post(AppURL.contactUsURI,data: contactUsBody.toJson(),);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}