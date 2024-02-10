import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/routing/route.dart';
import 'package:khedmaty_store/presentation/screens/setting/setting.dart';
import '../../../../core/api_checker.dart';
import '../../../../core/utils/showToast.dart';
import '../../../../data/model/body/RegisterBody.dart';
import '../../../../data/model/response/UserModel.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repository/SaveUserData.dart';
import '../../../../data/repository/profile_repo.dart';

class ModifyAccountViewModel with ChangeNotifier {
  final ProfileRepo profileRepo;
  final SaveUserData saveUserData;
  ModifyAccountViewModel( { required this.profileRepo,required this.saveUserData});

  ///variables
  bool _isLoading = false;
  UserModel? _userModel;
  ///getters
  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;
  ///calling APIs Functions

  Future<ApiResponse> modifyAccount(BuildContext context,RegisterBody registerBody) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await profileRepo.updateProfileRepo(registerBody);
    if (responseModel.response != null && responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _userModel = UserModel.fromJson(responseModel.response?.data);
      if(_userModel?.code == 200){
        await saveUserData.saveUserId("${_userModel?.data?.id}");
        await saveUserData.saveUserName("${_userModel?.data?.name}");
        await saveUserData.saveUserImage("${_userModel?.data?.logo}");
        await saveUserData.saveUserToken("${_userModel?.data?.token}");
        await saveUserData.saveUserEmail("${_userModel?.data?.email}");
        await saveUserData.saveUserPhone('${_userModel?.data?.phone}');
        await saveUserData.saveUserLat('${_userModel?.data?.latitude}' );
        await saveUserData.saveUserLong('${_userModel?.data?.longitude}' );
        await saveUserData.saveUserAddress('${_userModel?.data?.address}' );
       Navigator.pop(context);
      }else{
        ToastUtils.showToast(_userModel?.message ?? "");
      }
    } else {
      _isLoading = false;
      notifyListeners();
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}