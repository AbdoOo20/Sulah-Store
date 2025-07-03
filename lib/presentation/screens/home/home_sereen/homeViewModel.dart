import 'package:sulah_store/data/repository/home_Repo.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/api_checker.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/best_seller_model.dart';
import '../../../../data/model/response/statistics_model.dart';
import '../../../../data/repository/SaveUserData.dart';

class HomeViewModel with ChangeNotifier {
  final HomeRepo homeRepo;
  final SaveUserData saveUserData;

  HomeViewModel({required this.homeRepo, required this.saveUserData});

  ///variables
  BestSellerModel? _bestSellerModel;
  StatisticsModel? _statisticsModel;
  ///getters
  BestSellerModel? get bestSellerModel => _bestSellerModel;
  StatisticsModel? get statisticsModel => _statisticsModel;




  Future<ApiResponse> getStatistics(BuildContext context) async {


    ApiResponse apiResponse = await homeRepo.statisticsRepo();
    _statisticsModel=null;
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _statisticsModel = StatisticsModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> getBestSeller(BuildContext context) async {
    _bestSellerModel=null;
    ApiResponse apiResponse = await homeRepo.bestSellerRepo();
    if (apiResponse.response != null &&apiResponse.response?.statusCode == 200) {
      _bestSellerModel = BestSellerModel.fromJson(apiResponse.response?.data);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }
}
