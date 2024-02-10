// import 'package:delivery_point_provider/data/model/response/departments_model.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../../../core/api_checker.dart';
// import '../../../../../../data/model/response/categories_model.dart';
// import '../../../../../../data/model/response/base/api_response.dart';
// import '../../../../../../data/repository/auth_repo.dart';
//
//
// class CityWidgetViewModel with ChangeNotifier {
//   final AuthRepo authRepo;
//   CityWidgetViewModel({required this.authRepo});
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   CityModel? _cityModel;
//   CityModel? get cityModel => _cityModel;
//
//   Future<ApiResponse> getCityList (BuildContext context) async {
//     _isLoading = true;
//      //notifyListeners();
//     ApiResponse apiResponse = await authRepo.cityRepo();
//     if (apiResponse.response != null &&
//         apiResponse.response?.statusCode == 200) {
//       _isLoading = false;
//       _cityModel = CityModel.fromJson(apiResponse.response?.data);
//       notifyListeners();
//     } else {
//       _isLoading = false;
//       ApiChecker.checkApi(context, apiResponse);
//     }
//     notifyListeners();
//     return apiResponse;
//   }
// }