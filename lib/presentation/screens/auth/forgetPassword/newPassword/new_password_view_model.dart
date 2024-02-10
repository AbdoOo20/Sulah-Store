import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/routing/route.dart';
import '../../../../../../data/repository/auth_repo.dart';
import '../../../../../core/api_checker.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/model/response/UserModel.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../../../data/repository/SaveUserData.dart';
import '../../../home/home_sereen/home.dart';

class NewPasswordViewModel with ChangeNotifier {
  final AuthRepo authRepo;
  final SaveUserData saveUserData;
  NewPasswordViewModel( { required this.authRepo,required this.saveUserData});

  ///variables
  bool _isLoading = false;
  UserModel? _userModel;
  ///getters
  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;
  ///calling APIs Functions
  Future<ApiResponse> resetPassword(BuildContext context,String newPassword,String confirmPassword) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await authRepo.resetPasswordRepo(newPassword,confirmPassword);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _userModel = UserModel.fromJson(responseModel.response?.data);
      if(_userModel != null && _userModel?.code == 200){
        ToastUtils.showToast('successfullyResetPassword'.tr());
        pushAndRemoveUntil(const Home());
      }else{
        ToastUtils.showToast(_userModel?.message ?? "");
      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

}