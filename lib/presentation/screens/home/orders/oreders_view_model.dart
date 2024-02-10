import 'package:easy_localization/easy_localization.dart';
import 'package:khedmaty_store/data/model/response/one_order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/api_checker.dart';
import '../../../../core/routing/route.dart';
import '../../../../core/utils/showToast.dart';
import '../../../../data/model/body/acceptOrderBody.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/emptyModel.dart';
import '../../../../data/model/response/orders_model.dart';
import '../../../../data/repository/SaveUserData.dart';
import '../../../../data/repository/orders_repo.dart';
import '../../auth/login/login_screen.dart';

class OrdersViewModel with ChangeNotifier {
  final OrdersRepo ordersRepo;
  final SaveUserData saveUserData;

  OrdersViewModel({required this.saveUserData, required this.ordersRepo});
  String type = 'new';
  bool _isLoading = false;
  bool _loading = false;
  bool _isAcceptLoading = false;
  bool _isRefuseLoading = false;
  bool _isActionOrderLoading = false;
  bool _isActionOneOrderLoading = false;
  int indexOrderTaped = 0;


  bool get isLoading => _isLoading;

  bool get loading => _loading;

  bool get isAcceptLoading => _isAcceptLoading;

  bool get isRefuseLoading => _isRefuseLoading;

  bool get isActionOrderLoading => _isActionOrderLoading;

  bool get isActionOneOrderLoading => _isActionOneOrderLoading;

  ///calling APIs Functions
  OrdersModel? _ordersModel;
  OneOrderModel? _oneOrderModel;
  EmptyModel? _emptyModel;

  OrdersModel? get ordersModel => _ordersModel;

  OneOrderModel? get oneOrderModel => _oneOrderModel;

  ///calling action For Orders API Functions
  Future<ApiResponse> getOrdersApi(BuildContext context) async {
    _ordersModel = null;
    ApiResponse responseModel = await ordersRepo.ordersRepo(type);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _ordersModel = OrdersModel.fromJson(responseModel.response?.data);
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> getOneOrdersApi(BuildContext context, {num? orderId}) async {
    _oneOrderModel = null;
    ApiResponse responseModel = await ordersRepo.oneOrdersRepo(orderId: orderId);
    if (responseModel.response != null &&responseModel.response?.statusCode == 200) {
      _oneOrderModel = OneOrderModel.fromJson(responseModel.response?.data);
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> actionForOrdersApi(BuildContext context, String actionType, int orderId,) async {
    _isAcceptLoading = actionType == 'accepted' ? true : false;
    _isRefuseLoading = actionType == 'refused' ? true : false;
    _isLoading = true;
    notifyListeners();
    AcceptOrderBody acceptOrderBody = AcceptOrderBody();
    acceptOrderBody.status = actionType;
    ApiResponse responseModel =
        await ordersRepo.actionForOrdersRepo(acceptOrderBody, orderId);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
        await getOneOrdersApi(context, orderId: orderId);
        await getOrdersApi(context);
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isAcceptLoading = false;
    _isRefuseLoading = false;
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
