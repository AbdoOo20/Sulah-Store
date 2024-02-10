import 'dart:io';

import 'package:dio/dio.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/acceptOrderBody.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';
class OrdersRepo {
  final DioClient dioClient;
  final SaveUserData saveUserData;
  OrdersRepo({required this.saveUserData, required this.dioClient});
  Future<ApiResponse> ordersRepo(String type) async {
    try {
      Response response = await dioClient
          .get("${AppURL.kOrdersURL}$type");

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> oneOrdersRepo({num? orderId}) async {
    try {
      Response response = await dioClient.get(
          "${AppURL.kOneOrdersURL}$orderId");

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> actionForOrdersRepo(AcceptOrderBody acceptOrderBody,int id) async {
    try {
      Response response = await dioClient.post(
        '${AppURL.kUpdateOrdersStatusURL}$id',
        data:acceptOrderBody,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
