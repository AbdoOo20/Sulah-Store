import 'package:flutter/material.dart';
import 'package:sulah_store/core/utils/showToast.dart';
import 'package:sulah_store/data/model/response/emptyModel.dart';
import '../data/model/response/base/api_response.dart';
import 'package:provider/provider.dart';

import '../data/repository/SaveUserData.dart';

class ApiChecker {
  static void checkApi(BuildContext context, ApiResponse apiResponse) {
    EmptyModel? emptyModel;
    // print("ooooo____${apiResponse.error.toString()}");
    // print("ooooo____${apiResponse.response?.statusCode}");
    // if(apiResponse.error is! String && apiResponse.error.errors[0].message == 'Unauthorized.') {
    if(apiResponse.response?.statusCode == 401) {
    // back to login and remove data
      Provider.of<SaveUserData>(context,listen: false).clearSharedData();
    }else if(apiResponse.response?.statusCode == 422) {
      emptyModel=apiResponse.response?.data;
      ToastUtils.showToast(emptyModel?.message??'');
      // Provider.of<SaveUserData>(context,listen: false).clearSharedData();
    }else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message;
      }
      print(_errorMessage);
      ToastUtils.showToast(_errorMessage);
     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_errorMessage, style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }
}