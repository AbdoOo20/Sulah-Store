import 'package:flutter/material.dart';
import '../../../../core/api_checker.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/product_rates_model.dart';
import '../../../../data/model/response/user_rates_model.dart';
import '../../../../data/repository/rates_repo.dart';

class RatesViewModel with ChangeNotifier {
  final RatesRepo ratesRepo;
  RatesViewModel({required this.ratesRepo});
  UserRatesModel? _userRatesModel;
  UserRatesModel? get userRatesModel => _userRatesModel;
  ProductRatesModel? _productRatesModel;
  ProductRatesModel? get productRatesModel => _productRatesModel;
  ///calling APIs Functions
  Future<ApiResponse> getUserRates (BuildContext context) async {
    _userRatesModel=null;
    ApiResponse responseModel = await ratesRepo.userRatesRepo();
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {

      _userRatesModel = UserRatesModel.fromJson(responseModel.response?.data);

    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }
  Future<ApiResponse> getProductRates (BuildContext context) async {
    _productRatesModel =null;
    ApiResponse responseModel = await ratesRepo.productRatesRepo();
    if (responseModel.response?.statusCode == 200) {
      _productRatesModel = ProductRatesModel.fromJson(responseModel.response?.data);
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }
}