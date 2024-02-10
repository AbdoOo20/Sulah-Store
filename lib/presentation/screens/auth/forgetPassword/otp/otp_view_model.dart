import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../core/routing/route.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/model/body/RegisterBody.dart';
import '../../../../../data/model/response/UserModel.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../../../data/model/response/send_code_model.dart';
import '../../../../../data/repository/auth_repo.dart';
import '../../register/RegisterViewModel.dart';
import '../newPassword/new_password_screen.dart';
import 'otp_screen.dart';

class OtpViewModel with ChangeNotifier {
  final AuthRepo authRepo;
  final RegisterBody registerBody;
  OtpViewModel({required this.registerBody, required this.authRepo});

  ///variables
  bool _isLoading = false;
  bool _loading = false;
  String? _validationMSG;
  UserModel? _userModel;
  SendCodeModel? _sendCodeModel;
  ///getters
  bool get isLoading => _isLoading;
  bool get loading => _loading;

  String? get validationMSG => _validationMSG;



  ///setters

  set validationMsg(String msg) {
    _validationMSG = msg;
    notifyListeners();
  }
  String removeLeadingZeroFromString(String input) {
    if (input.isEmpty) {
      return input;
    }
    if (input[0] == '0') {
      input = input.substring(1);
    }
    return input;
  }
  Future<bool> sendOTPFirebase(BuildContext context,String phone,String from) async {

    String modifiedPhone = removeLeadingZeroFromString(phone);
    _loading=true;
    notifyListeners();
    bool successfully = false;
    ApiResponse responseModel = await authRepo.sendCode(modifiedPhone);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isLoading = false;
      _sendCodeModel = SendCodeModel.fromJson(responseModel.response?.data);

      if (_sendCodeModel != null && _sendCodeModel?.code == 200) {
        successfully = true;
        _loading = false;
        notifyListeners();
        push( OtpScreen(phone: phone,from: from,));
      }
    } else {
      _loading = false;
    }
    _loading = false;
    notifyListeners();
    return successfully;
  }
  Future<bool> verifyOTPFirebase(String smsCode,String phone,BuildContext context,String from) async {
    String modifiedPhone = removeLeadingZeroFromString(phone);
    _isLoading = true;
    notifyListeners();
    try{
      ApiResponse responseModel = await authRepo.verfiycode(modifiedPhone,smsCode);
      if (responseModel.response != null &&
          responseModel.response?.statusCode == 200) {
        _isLoading = false;
        _userModel = UserModel.fromJson(responseModel.response?.data);
        if (_userModel != null && _userModel?.code == 200) {
          _loading = false;
          notifyListeners();
          await authRepo.saveUserData.saveUserId("${_userModel?.data?.id}");
          await authRepo.saveUserData.saveUserName("${_userModel?.data?.name}");
          await authRepo.saveUserData.saveUserImage("${_userModel?.data?.logo}");
          await authRepo.saveUserData.saveUserToken("${_userModel?.data?.token}");
          await authRepo.saveUserData.saveUserEmail("${_userModel?.data?.email}");
          await authRepo.saveUserData.saveUserPhone('${_userModel?.data?.phone}');
          await authRepo.saveUserData.saveUserLat('${_userModel?.data?.latitude}' );
          await authRepo.saveUserData.saveUserLong('${_userModel?.data?.longitude}' );
          await authRepo.saveUserData.saveUserAddress('${_userModel?.data?.address}' );
          if (from == 'register') {
                      await Provider.of<RegisterViewModel>(context, listen: false).registerAPI(context, registerBody);
                     }else{
                       push( NewPassword(phone: modifiedPhone));
                     }

        }
      } else {
        _loading = false;
        ToastUtils.showToast(_userModel!.message!);
      }
      _isLoading = false;
      notifyListeners();
      return true;
    }catch(e){
      _isLoading = false;
      ToastUtils.showToast(LocaleKeys.codeIsWrong.tr());
      notifyListeners();
      return false;
    }
  }
}
