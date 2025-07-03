import 'package:sulah_store/data/model/body/porduct_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/presentation/screens/auth/login/login_screen.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/api_checker.dart';
import '../../../../core/routing/route.dart';
import '../../../../core/utils/showToast.dart';
import '../../../../data/model/response/base/api_response.dart';
import '../../../../data/model/response/emptyModel.dart';
import '../../../../data/model/response/products_Model.dart';
import '../../../../data/repository/home_Repo.dart';
import '../../../../data/repository/products_repo.dart';
import '../../../../injection.dart';
import 'add_product/add_product_view_model.dart';

class ProductsViewModel with ChangeNotifier {
  final ProductsRepo productsRepo;
  final HomeRepo homeRepo;

  ProductsViewModel({required this.productsRepo, required this.homeRepo});
  ///variables
  AddProductViewModel addProductViewModel = getIt();

  ProductsModel? _productsModel;
  bool _isLoading = false;
  bool loading = false;
  bool _isDeleteProductLoading = false;
  EmptyModel? _emptyModel;

  ///getters


  ProductsModel? get productsModel => _productsModel;

  bool get isLoading => _isLoading;



  bool get isDeleteProductLoading => _isDeleteProductLoading;


  /// have offer
  bool typeOfferSelect = false;
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();

  ///calling action For Orders API Functions
  Future<ApiResponse> getProducts(BuildContext context, pageNumber) async {
    _productsModel=null;
    ApiResponse apiResponse = await productsRepo.getProductsRepo(pageNumber ?? '','of');
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      _productsModel = ProductsModel.fromJson(apiResponse.response?.data);
    } else {
      if (context.mounted) {
        ApiChecker.checkApi(context, apiResponse);
      }
    }
    notifyListeners();
    return apiResponse;
  }
  Future<ApiResponse> deleteProduct(int productId, BuildContext context) async {
    _isDeleteProductLoading = true;
    notifyListeners();
    ApiResponse responseModel = await productsRepo.deleteProductRepo(productId);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _emptyModel = EmptyModel.fromJson(responseModel.response?.data);
      if (_emptyModel?.code == 200) {
        ToastUtils.showToast('sectionSuccessfullyDeleted'.tr());
        await getProducts(context, "");
        Navigator.pop(context);
      } else if (_emptyModel?.code == 430) {
        pushAndRemoveUntil(const LoginScreen());
      } else {
        ToastUtils.showToast(_emptyModel?.message.toString() ?? '');
      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isDeleteProductLoading = false;
    notifyListeners();
    return responseModel;
  }
  Future<ApiResponse> createProduct(
      BuildContext context,
      ProductsBody createProductsBody,
      bool? isEdite,
      String? productId,
      List<PickedFile> images) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse responseModel = await productsRepo.createProductsRepo(
        createProductsBody, isEdite, productId, images);
    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _emptyModel = EmptyModel.fromJson(responseModel.response?.data);
      if (_emptyModel?.code == 200) {
        images = [];
        startDateController.text = "";
        endDateController.text = "";
        discountValueController.text = "";
        ToastUtils.showToast(isEdite == false
            ? 'theProductHasBeenSuccessfullyAdded'.tr()
            : 'theProductHasBeenModifiedSuccessfully'.tr());
        await getProducts(context, '');
      } else {
        ToastUtils.showToast(_emptyModel?.message.toString() ?? '');
      }
      if (isEdite == false) {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } else {
      ApiChecker.checkApi(context, responseModel);
    }
    _isLoading = false;
    notifyListeners();
    return responseModel;
  }
  Future<ApiResponse> showProducts(BuildContext context, num productId) async {
    ApiResponse apiResponse = await productsRepo.showProductRepo(productId);
    if (apiResponse.response != null && apiResponse.response?.statusCode == 200) {
      getProducts(context,'');
      Navigator.pop(context);
    } else {
      ApiChecker.checkApi(context, apiResponse);
    }
    notifyListeners();
    return apiResponse;
  }
  update() {
    notifyListeners();
  }
}
