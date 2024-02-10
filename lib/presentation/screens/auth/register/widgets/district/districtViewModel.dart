// import 'package:delivery_point_provider/data/model/response/district_Model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../../core/api_checker.dart';
// import '../../../../../../data/model/response/base/api_response.dart';
// import '../../../../../../data/repository/auth_repo.dart';
// import '../../RegisterViewModel.dart';
//
//
// class DistrictWidgetViewModel with ChangeNotifier {
//   final AuthRepo authRepo;
//   DistrictWidgetViewModel({required this.authRepo});
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   DistrictModel? _districtModel;
//   DistrictModel? get districtModel => _districtModel;
//
//   Future<ApiResponse> getDistrictList (BuildContext context) async {
//     String? cityId = Provider.of<RegisterViewModel>(context,listen: false).registerBody?.cityId;
//     _isLoading = true;
//     //notifyListeners();
//     ApiResponse apiResponse = await authRepo.districtRepo(cityId ?? "");
//     if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
//       _isLoading = false;
//       _districtModel = DistrictModel.fromJson(apiResponse.response?.data);
//       notifyListeners();
//     } else {
//       _isLoading = false;
//       ApiChecker.checkApi(context, apiResponse);
//     }
//     notifyListeners();
//     return apiResponse;
//   }
// }