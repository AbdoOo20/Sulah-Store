import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/routing/route.dart';
import '../../../../../../data/repository/auth_repo.dart';
import '../../../../core/api_checker.dart';
import '../../../../core/utils/showToast.dart';
import '../../../../data/model/body/RegisterBody.dart';
import '../../../../data/model/response/UserModel.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repository/SaveUserData.dart';
import '../../../component/new/custom_dropdown_button.dart';
import '../../home/home_sereen/home.dart';

class RegisterViewModel with ChangeNotifier {
  final AuthRepo authRepo;
  final SaveUserData saveUserData;
  RegisterViewModel( { required this.authRepo,required this.saveUserData});
  ///variables
  DropdownItem? selectedBank;
  DropdownItem? selectedNationality;
  bool _isLoading = false;
  bool _isValidator = false;
  UserModel? _userModel;
  ///getters
  bool get isLoading => _isLoading;
  bool get isValidator => _isValidator;
  UserModel? get userModel => _userModel;
  ///setter
  set newValidator(bool value) {
    _isValidator=value;
    notifyListeners();
  }
  ///calling APIs Functions
  Future<ApiResponse> registerAPI(BuildContext context,RegisterBody registerBody) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await authRepo.registerRepo(registerBody);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _userModel = UserModel.fromJson(responseModel.response?.data);
      if(_userModel != null && _userModel?.code == 200){
        await saveUserData.saveUserId("${_userModel?.data?.id}");
        await saveUserData.saveUserName("${_userModel?.data?.name}");
        await saveUserData.saveUserImage("${_userModel?.data?.logo}");
        await saveUserData.saveUserToken("${_userModel?.data?.token}");
        await saveUserData.saveUserEmail("${_userModel?.data?.email}");
        await saveUserData.saveUserPhone('${_userModel?.data?.phone}');
        await saveUserData.saveUserLat('${_userModel?.data?.latitude}' );
        await saveUserData.saveUserLong('${_userModel?.data?.longitude}' );
        await saveUserData.saveUserAddress('${_userModel?.data?.address}' );
          ToastUtils.showToast('successfullyRegistered'.tr());
          pushAndRemoveUntil(const Home());
      }else{
        _isLoading = false;
        notifyListeners();
        ToastUtils.showToast(_userModel?.message ?? "");
      }
    }
    else {
      _isLoading = false;
      notifyListeners();
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }

}