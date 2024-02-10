import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/api_checker.dart';
import '../../../../core/routing/route.dart';
import '../../../../core/utils/showToast.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/emptyModel.dart';
import '../../../../data/model/response/wallet_model.dart';
import '../../../../data/repository/wallet_repo.dart';
import '../../auth/login/login_screen.dart';

class WalletViewModel with ChangeNotifier {
  final WalletRepo walletRepo;

  WalletViewModel({required this.walletRepo});

  bool _isLoadingRequest = false;

  bool get isLoadingRequest => _isLoadingRequest;
  EmptyModel? _emptyModel;
  WalletModel? _walletModel;

  ///calling APIs Functions
  WalletModel? get walletModel => _walletModel;
  Future<ApiResponse> walletApi(BuildContext context) async {
    _walletModel = null;
    ApiResponse responseModel = await walletRepo.walletRepo();
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _walletModel = WalletModel.fromJson(responseModel.response?.data);
    } else {
      notifyListeners();
      ApiChecker.checkApi(context, responseModel);
    }
    notifyListeners();
    return responseModel;
  }

  Future<ApiResponse> walletRequest(BuildContext context,num value) async {
    _isLoadingRequest = true;
    notifyListeners();
    ApiResponse responseModel = await walletRepo.balanceWithdrawalRequestRepo(value);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _emptyModel = EmptyModel.fromJson(responseModel.response?.data);
      if (_emptyModel?.code == 200) {
        ToastUtils.showToast('RequestSuccessfullySend'.tr());
      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoadingRequest = false;
    notifyListeners();
    return responseModel;
  }
}
