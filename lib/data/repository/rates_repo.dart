import 'package:dio/dio.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/RegisterBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class RatesRepo {
  final DioClient dioClient;
  RatesRepo({required this.dioClient});
  Future<ApiResponse> userRatesRepo() async {
    try {
      Response response = await dioClient.get(AppURL.kUserRatesURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> productRatesRepo() async {
    try {
      Response response = await dioClient.get(AppURL.kProductRatesURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
