import 'package:sulah_store/core/routing/route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/api_checker.dart';
import '../../../../core/utils/showToast.dart';
import '../../../../data/model/body/LoginBody.dart';
import '../../../../data/model/response/UserModel.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/repository/SaveUserData.dart';
import '../../../../data/repository/auth_repo.dart';
import '../../../../injection.dart';
import '../../home/home_sereen/home.dart';
import '../forgetPassword/otp/otp_view_model.dart';

class LoginViewModel with ChangeNotifier {
  final AuthRepo authRepo;
  final SaveUserData saveUserData;
  LoginViewModel({required this.saveUserData, required this.authRepo});

  ///variables
  bool _isLoading = false;
  UserModel? _userModel;

  ///getters
  bool get isLoading => _isLoading;

  UserModel? get userModel => _userModel;

  ///calling APIs Functions
  String removeLeadingZeroFromString(String input) {
    if (input.isEmpty) {
      return input;
    }
    if (input[0] == '0') {
      input = input.substring(1);
    }
    return input;
  }
  Future<ApiResponse> login(String phone, String password, BuildContext context) async {
    _isLoading = true;
    String modifiedPhone = removeLeadingZeroFromString(phone);
    notifyListeners();
    final LoginBody body = LoginBody(phone: modifiedPhone, password: password);
    ApiResponse responseModel = await authRepo.loginRepo(body);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _userModel = UserModel.fromJson(responseModel.response?.data);
      if (_userModel != null && _userModel?.code == 200) {
          await saveUserData.saveUserId("${_userModel?.data?.id}");
          await saveUserData.saveUserName("${_userModel?.data?.name}");
          await saveUserData.saveUserImage("${_userModel?.data?.logo}");
          await saveUserData.saveUserToken("${_userModel?.data?.token}");
          await saveUserData.saveUserEmail("${_userModel?.data?.email}");
          await saveUserData.saveUserPhone('${_userModel?.data?.phone}');
          await saveUserData.saveUserLat('${_userModel?.data?.latitude}' );
          await saveUserData.saveUserLong('${_userModel?.data?.longitude}' );
          await saveUserData.saveUserAddress('${_userModel?.data?.address}' );
          // await saveUserData.saveUserDepartmentId('${_userModel?.data?.department?.id}' );
          // await saveUserData.saveUserDepartmentTitle('${_userModel?.data?.department?.title}');
          // await Provider.of<OtpViewModel>(context, listen: false).updateFCMToken();
          ToastUtils.showToast('loggedInSuccessfully'.tr());
          pushAndRemoveUntil(const Home());
      } else {
        ToastUtils.showToast(_userModel?.message ?? "");
      }
    } else {
      ApiChecker.checkApi(context, responseModel);

    }
    print('eeeeeeeeeeeeeeeeee${saveUserData.getUserToken()}');
    print('eeeeeeeeeeeeeeeeee${saveUserData.getLang()}');
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
  // bool isLoggedIn() {
  //   return saveUserData.isLoggedIn();
  // }
}
