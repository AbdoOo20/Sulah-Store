import 'package:dio/dio.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/RegisterBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class ProfileRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;
  ProfileRepo({required this.dioClient, required this.saveUserData});
  Future<ApiResponse> updateProfileRepo(RegisterBody registerBody) async {
    try {
      Response response = await dioClient.post(
          AppURL.kProfileUpdateURI, data: FormData.fromMap({
        // "phone": registerBody.phone,
        "email": registerBody.email,
        "phone":  registerBody.phone,
        "name":  registerBody.title,
        "longitude":  registerBody.longitude,
        "latitude": registerBody.latitude,
        "address": registerBody.address,
        // "department_id":  registerBody.departmentId,
        // "working_document":  registerBody.workingDocument == null ? null : await MultipartFile.fromFile(registerBody.workingDocument!.path),
        // "end_date_document":  registerBody.endDateDocument,
        "logo": registerBody.image == null ? null : await MultipartFile.fromFile(registerBody.image!.path),
      })
        // data:,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> updateAvailableRepo(String type) async {
    try {
      Response response = await dioClient.post(
          AppURL.kUpdateStateAndNotificationURI+type
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> walletRepo() async {
    try {
      Response response = await dioClient.get(AppURL.kWalletURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> profileRepo() async {
    try {
      Response response = await dioClient.get(AppURL.kProfileURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> balanceWithdrawalRequestRepo() async {
    try {
      Response response = await dioClient.post(AppURL.kProfileBalanceWithdrawalRequestURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> deleteAccountRepo() async {
    try {
      Response response = await dioClient.delete(AppURL.kDeleteAccountURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
