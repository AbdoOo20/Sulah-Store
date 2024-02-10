import 'package:dio/dio.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/RegisterBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class WalletRepo {
  final DioClient dioClient;
  WalletRepo({required this.dioClient});
  Future<ApiResponse> walletRepo() async {
    try {
      Response response = await dioClient.get(AppURL.kWalletURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> balanceWithdrawalRequestRepo(num value) async {
    try {
      Response response = await dioClient.post(
          AppURL.kProfileBalanceWithdrawalRequestURI, data: {"value": value} );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
