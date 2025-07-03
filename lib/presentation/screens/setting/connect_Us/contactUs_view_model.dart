import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/data/repository/main_repo.dart';
import '../../../../../core/api_checker.dart';
import '../../../../../data/model/body/contact_UsBody.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../../../data/model/response/emptyModel.dart';
import '../../../../core/routing/route.dart';
import '../../../../core/utils/showToast.dart';
import '../../auth/login/login_screen.dart';

class ContactUsViewModel with ChangeNotifier {
  final MainRepo mainRepo;

  ContactUsViewModel({required this.mainRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ///calling APIs Functions
  EmptyModel? _emptyDataModel;

  Future<ApiResponse> contactUsApi(context, ContactUsBody contactUsBody) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await mainRepo.contactUs(contactUsBody);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _emptyDataModel = EmptyModel.fromJson(responseModel.response?.data);
      if (_emptyDataModel?.code == 200) {
        ToastUtils.showToast('sentSuccesfully'.tr());
        Navigator.pop(context);
      }
      if (_emptyDataModel?.code == 430) {
        pushAndRemoveUntil(const LoginScreen());
      } else {
        ToastUtils.showToast(_emptyDataModel?.message ?? '');
      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
}
