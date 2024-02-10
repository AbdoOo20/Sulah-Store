import 'package:khedmaty_store/data/model/response/base/notificationModel.dart';
import 'package:khedmaty_store/presentation/screens/home/Notifications/Notifications.dart';
import 'package:dio/dio.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class HomeRepo {
  final DioClient dioClient;
  HomeRepo({required this.dioClient});

  Future<ApiResponse>statisticsRepo() async {
    try {
      Response response = await dioClient.get(AppURL.kStatisticsURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> bestSellerRepo() async {
    try {
      Response response = await dioClient.get(AppURL.kBestSellerURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}