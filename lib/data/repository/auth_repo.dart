import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../presentation/firebase_notification/notification_services.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/LoginBody.dart';
import '../model/body/RegisterBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class AuthRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;
  AuthRepo({required this.dioClient, required this.saveUserData});

  Future<ApiResponse> sendCode(String phone) async {
    try {
      Response response = await dioClient.post(
        AppURL.sendCodeURI,
        data: {"country_code": "+20", "phone": phone},
      );
      // saveUserData.userData(response);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> verfiycode(String phone,String code) async {
    try {
      Response response = await dioClient.post(
        AppURL.confirmCodeURI,
        data: {
          "country_code": "+20",
          "code": code,
          "phone": phone},
      );
      // saveUserData.userData(response);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> loginRepo(LoginBody loginBody) async {
    try {
      Response response = await dioClient.post(
        AppURL.kLoginURI,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> resetPasswordRepo(String newPassword,String confirmPassword) async {
    try {
      Response response = await dioClient.post(
        AppURL.kResetPasswordURI,
        data:  FormData.fromMap({
        "new_password": newPassword,
        "confirm_password": confirmPassword
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> registerRepo(RegisterBody registerBody) async {
    try {
      Response response = await dioClient.post(
        AppURL.kRegisterURI, data: FormData.fromMap({
        "phone": registerBody.phone,
        "email": registerBody.email,
        "password":  registerBody.password,
        "name":  registerBody.title,
        "longitude":  registerBody.longitude,
        "latitude": registerBody.latitude,
        "address": registerBody.address,
        "password_confirmation": registerBody.passwordConfirmation,
        "department_id":  registerBody.departmentId,
        "user_category_id":  registerBody.userCategoryId,
        "country_code":  registerBody.countryCode,
        "commercial_register":  registerBody.workingDocument == null ? null : await MultipartFile.fromFile(registerBody.workingDocument!.path),
        "end_date_document":  registerBody.endDateDocument,
        "register_from":  registerBody.registerFrom,
        "logo": registerBody.image == null ? null : await MultipartFile.fromFile(registerBody.image!.path),
      })
       // data:,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  // Future<ApiResponse> notificationListRepo() async {
  //   try {
  //     Response response = await dioClient.get(AppURL.kGetNotificationsURI);
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
  Future<ApiResponse> logOutRepo() async {
    try {
      TargetPlatform deviceType = getDeviceType();/// for software_type
      // String? fcmToken = await NotificationServices().getDeviceToken();
      Response response = await dioClient.post(AppURL.kLogoutURI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  TargetPlatform getDeviceType() {/// for software_type
    return defaultTargetPlatform;
  }
}
