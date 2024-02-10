import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/api_checker.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/model/response/base/api_response.dart';
import '../../../../../data/model/response/departments_model.dart';
import '../../../../../data/model/response/products_Model.dart';
import '../../../../../data/repository/products_repo.dart';
import '../../../../component/new/custom_dropdown_button.dart';

class AddProductViewModel with ChangeNotifier {
  final ProductsRepo productsRepo;

  AddProductViewModel({required this.productsRepo});

  String? stockTimeTitle;
  String? makeTimeTitle;
  List<PickedFile> images = [];
  List<DropdownItem> departments = [];
  DropdownItem ? selectedDepartments;

initSelectedDepartments(int? id,String? title){
  DropdownItem ? departments=DropdownItem();
  departments.title=title;
  departments.id=id;
  selectedDepartments=departments;
}
  ///variables
  bool loading = false;

  DepartmentModel? _departmentModel;
  ///getters
  DepartmentModel? get departmentModel => _departmentModel;
  void init(OneProduct? product) {
    images = [];
    if (product != null) {
      // images.add(PickedFile(product.mainImage!));
      if (product.images != null) {
        for (ImageModel model in product.images!) {
          images.add(PickedFile(model.images!));
        }
      }
    }
    Future.delayed(Duration(seconds: 3)).then((value) {
      print("sssss===>${images.length}");
      notifyListeners();
    });
  }


  /// have offer
  bool typeOfferSelect = false;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();

  ///calling action For Orders API Functions
  Future<ApiResponse> getDepartments(BuildContext context) async {
    _departmentModel = null;
    ApiResponse apiResponse = await productsRepo.getDepartmentsRepo();
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
      _departmentModel = DepartmentModel.fromJson(apiResponse.response?.data);
      if (_departmentModel?.code == 200 && _departmentModel?.data != null) {
        if (_departmentModel?.data?.isNotEmpty ?? false) {
          for (int i = 0; i < _departmentModel!.data!.length; i++) {
            departments.add(DropdownItem(id: _departmentModel!.data![i].id,
                title: _departmentModel!.data![i].title));
          }

        }

      } else {
        ToastUtils.showToast(_departmentModel?.message ?? '');
      }
    } else {
      if (context.mounted) ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> removeItemAndImage(
      BuildContext context, num productId, String type) async {
    ApiResponse apiResponse =
        await productsRepo.addAndRemoveItemAndImageRepo(productId, type);
    if (apiResponse.response != null &&
        apiResponse.response?.statusCode == 200) {
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }

  update() {
    notifyListeners();
  }

  void addImage(PickedFile file) {
    images.add(file);
    notifyListeners();
  }
}
