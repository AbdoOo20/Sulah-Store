import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/routing/route.dart';
import 'package:khedmaty_store/data/repository/auth_repo.dart';
import 'package:khedmaty_store/presentation/screens/auth/login/login_screen.dart';
import '../../../../core/api_checker.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repository/SaveUserData.dart';
import '../../../../data/repository/setting_repo.dart';
import '../../../core/utils/showToast.dart';
import '../../../data/model/response/emptyModel.dart';
import '../../../data/model/response/profile_model.dart';
import '../../../data/model/response/setting_model.dart';
import '../../../data/repository/profile_repo.dart';

class SettingViewModel with ChangeNotifier {
  final AuthRepo authRepo;
  final ProfileRepo profileRepo;
  final SaveUserData saveUserData;
  SettingViewModel({required this.saveUserData,required this.profileRepo,required this.authRepo});
  bool _isDeleteProLoading = false;
  bool _isLogOutLoading = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool get isDeleteProLoading => _isDeleteProLoading;
  bool get isLogOutLoading => _isLogOutLoading;
  EmptyModel? _emptyModel;
  EmptyModel? get emptyModel => _emptyModel;
  ProfileModel? _profileModel;
  ProfileModel? get profileModel => _profileModel;
  ///calling APIs Functions
  // Future<ApiResponse> getSettingApi (BuildContext context) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   ApiResponse responseModel = await settingRepo.settingRepo();
  //   if (responseModel.response != null &&
  //       responseModel.response?.statusCode == 200) {
  //     _isLoading = false;
  //
  //     _settingModel = SettingModel.fromJson(responseModel.response?.data);
  //
  //     notifyListeners();
  //   } else {
  //     _isLoading = false;
  //     ApiChecker.checkApi(context, responseModel);
  //   }
  //   notifyListeners();
  //   return responseModel;
  // }
  Future<ApiResponse> getProfile (BuildContext context) async {
    _profileModel =null;
    ApiResponse responseModel = await profileRepo.profileRepo();
    if (responseModel.response?.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(responseModel.response?.data);
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }
  Future<ApiResponse> updateAndNotification(BuildContext context,String type) async {
    _profileModel =null;
    notifyListeners();
    ApiResponse responseModel = await profileRepo.updateAvailableRepo(type);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _emptyModel = EmptyModel.fromJson(responseModel.response?.data);
      if (_emptyModel?.code == 200) {
       await getProfile(context);
      }
      else if (_emptyModel?.code == 401) {
        pushAndRemoveUntil(const LoginScreen());
      }else{
       ToastUtils.showToast(_emptyModel?.message??'');
     }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }
  Future<ApiResponse> logOut(BuildContext context) async {
    _isLogOutLoading =true;
    saveUserData.clearSharedData();
    notifyListeners();
    ApiResponse responseModel = await authRepo.logOutRepo();
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
          _emptyModel = EmptyModel.fromJson(responseModel.response?.data);
      if (_emptyModel?.code == 200) {
        ToastUtils.showToast(LocaleKeys.successfullyLoggedOut.tr());
        saveUserData.clearSharedData();
      }else if (_emptyModel?.code == 430) {
        pushAndRemoveUntil(LoginScreen());
      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isLogOutLoading = false;
    notifyListeners();
    return responseModel;
  }
  Future<ApiResponse> deleteAccount(BuildContext context) async {
    _isDeleteProLoading =true;
    notifyListeners();
    ApiResponse responseModel = await profileRepo.deleteAccountRepo();
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _emptyModel = EmptyModel.fromJson(responseModel.response?.data);
      if (_emptyModel?.code == 200) {
        ToastUtils.showToast('accountDeletedSuccessfully'.tr());
        saveUserData.clearSharedData();
      } if (_emptyModel?.code == 430) {
        pushAndRemoveUntil(LoginScreen());
      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isDeleteProLoading = false;
    notifyListeners();
    return responseModel;
  }
}