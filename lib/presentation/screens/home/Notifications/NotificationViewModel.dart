//
// import 'package:flutter/cupertino.dart';
// import '../../../../core/api_checker.dart';
// import '../../../../data/model/response/base/api_response.dart';
// import '../../../../data/model/response/notificationModel.dart';
// import '../../../../data/repository/auth_repo.dart';
//
// class NotificationViewModel with ChangeNotifier {
//   final AuthRepo authRepo;
//   NotificationViewModel({required this.authRepo});
//
//   ///var
//   NotificationModel? _notificationModel;
//   bool _isLoading = false;
//
//   /// getter
//   NotificationModel? get notificationModel => _notificationModel;
//   bool get isLoading => _isLoading;
//
//   Future<ApiResponse> getNotification(BuildContext context,) async {
//     _notificationModel =null;
//     // notifyListeners();
//     ApiResponse apiResponse = await authRepo.notificationListRepo();
//     if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
//       _notificationModel = NotificationModel.fromJson(apiResponse.response?.data);
//     } else {
//       ApiChecker.checkApi(context, apiResponse);
//     }
//     notifyListeners();
//     return apiResponse;
//   }
// }