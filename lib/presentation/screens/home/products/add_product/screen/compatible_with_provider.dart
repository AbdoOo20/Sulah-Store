import 'package:flutter/material.dart';
import 'package:khedmaty_store/injection.dart';

import '../../../../../../core/api_checker.dart';

import '../../../../../../core/utils/showToast.dart';
import '../../../../../../data/model/body/compatible_with_body.dart';
import '../../../../../../data/model/response/base/api_response.dart';
import '../../../../../../data/model/response/brands_model.dart';
import '../../../../../../data/model/response/cars_model.dart';
import '../../../../../../data/model/response/products_Model.dart';
import '../../../../../../data/repository/products_repo.dart';
import '../../../../../component/new/custom_dropdown_button.dart';
import '../widget/additionsWidgets.dart';

class CompatibleWithViewModel with ChangeNotifier {
  ProductsRepo productsRepo = getIt();
  BrandsModel? _brandsModel;
  CarsModel? _carsModel;

  CarsModel? get carsModel => _carsModel;

  BrandsModel? get brandsModel => _brandsModel;
  List<DropdownItem> cars = [];
  List<DropdownItem> brands = [];
  List<CompatibleWithBody> compatibleWithBody = [];
  DropdownItem? selectedBrands;
  DropdownItem? selectedCars;
  String? manufactureYear;

  CompatibleWithViewModel();

  void addAddition(CompatibleWithBody oneCompatibleWithBody) {
    compatibleWithBody.add(oneCompatibleWithBody);
    notifyListeners();
  }

  void removeAddition(int index) {
    compatibleWithBody.removeAt(index);
    notifyListeners();
  }

  Future<ApiResponse> getBrands(BuildContext context) async {
    _brandsModel = null;
    brands = [];
    ApiResponse apiResponse = await productsRepo.getBrandsRepo();
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _brandsModel = BrandsModel.fromJson(apiResponse.response?.data);
      if (_brandsModel?.code == 200 && _brandsModel?.data != null) {
        if (_brandsModel?.data?.isNotEmpty ?? false) {
          for (int i = 0; i < _brandsModel!.data!.length; i++) {
            brands.add(DropdownItem(
                id: _brandsModel!.data![i].id,
                title: _brandsModel!.data![i].title));
          }
        }
      } else {
        ToastUtils.showToast(_brandsModel?.message ?? '');
      }
    } else {
      if (context.mounted) ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  Future<ApiResponse> getCars(BuildContext context) async {
    _carsModel = null;
    cars = [];
    ApiResponse apiResponse = await productsRepo.getCarsRepo();
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _carsModel = CarsModel.fromJson(apiResponse.response?.data);
      if (_carsModel?.code == 200 && _carsModel?.data != null) {
        if (_carsModel?.data?.isNotEmpty ?? false) {
          for (int i = 0; i < _carsModel!.data!.length; i++) {
            cars.add(DropdownItem(
                id: _carsModel!.data![i].id,
                title: _carsModel!.data![i].title));
          }
        }
      } else {
        ToastUtils.showToast(_carsModel?.message ?? '');
      }
    } else {
      if (context.mounted) ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  buildCompatibleWith(bool isEdite, OneProduct? oneProduct) {
    return Column(
      children: [
        AdditionsWidget(
          isEdite: isEdite,
          oneProduct: oneProduct,
        ),
      ],
    );
  }
}
