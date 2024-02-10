import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/porduct_body.dart';
import '../model/response/base/api_response.dart';
import 'SaveUserData.dart';

class ProductsRepo {
  final DioClient dioClient;

  ProductsRepo({required this.dioClient});

  Future<ApiResponse> getProductsRepo(String pageNumber,String isPagination) async {
    try {
      Response response = await dioClient
          .get("${AppURL.kGetAndCreateProductsURL}?pagination=$isPagination&limit_per_page=$pageNumber");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getDepartmentsRepo() async {
    try {
      Response response = await dioClient
          .get(AppURL.kDepartmentsURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getCarsRepo() async {
    try {
      Response response = await dioClient
          .get(AppURL.kCarsURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getBrandsRepo() async {
    try {
      Response response = await dioClient
          .get(AppURL.kBrandsURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }











  Future<ApiResponse> deleteProductRepo(int productId) async {
    try {
      Response response = await dioClient.delete(
        AppURL.kUpdateAndDeleteProductsURL + productId.toString(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> createProductsRepo(ProductsBody productsBody,
      bool? isEdite, String? productId, List<PickedFile> images) async {
    try {
      List<MultipartFile> imagesPart = [];
      for (PickedFile file in images) {
        if (isEdite == true) {
          if (file.path.startsWith('http')) {
            ///do not put in imagesPart
          } else {
            imagesPart.add(await MultipartFile.fromFile(file!.path));
          }
        } else {
          imagesPart.add(await MultipartFile.fromFile(file!.path));
        }
      }

      print('jkljkl${images.length}');
      print('bbbbbbbbb${isEdite}');
      print('jkljkl${imagesPart.length}');
      Map<String, dynamic> data = {
        "title": productsBody.title,
        "code": '1231',
        "department_id": productsBody.departmentId,
        "description": productsBody.description,
        "price": productsBody.price,
        "images_list": imagesPart,
        "type": productsBody.type,
        "is_show": '1',
        "have_offer": productsBody.isOffer,
        "offer_type": productsBody.offerType,
        "offer_value": productsBody.offerValue,
        "from_date": productsBody.offerStartDate,
        "to_date": productsBody.offerEndDate,
       if (isEdite == true) "_method": 'PUT',
        if (isEdite == true) "main_image": productsBody.mainImage == null ? null : await MultipartFile.fromFile(productsBody.mainImage!.path),
      };
      if (productsBody.productList?.isNotEmpty??false) {
          for(int i=0;i<(productsBody.productList?.length??0);i++){
            data.addAll({"product_list[$i][brand_id]":"${productsBody.productList?[i].brandId}"});
            data.addAll({"product_list[$i][car_id]":"${productsBody.productList?[i].carId}"});
            data.addAll({"product_list[$i][manufacture_year]":"${productsBody.productList?[i].manufactureYear}"});
          }
      }
      FormData formData = FormData.fromMap(data);
      Response response = await dioClient.post(
          isEdite == false ? AppURL.kGetAndCreateProductsURL
              : '${AppURL.kUpdateAndDeleteProductsURL}$productId',
          data: formData);
      print('sssssssssss${response}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('ssssssssss22${e}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> showProductRepo(num productId) async {
    try {
      Response response = await dioClient.post(
        '${AppURL.showProductURL}$productId',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addAndRemoveItemAndImageRepo(
      num productId, String type) async {
    try {
      Response response = await dioClient.get(
        '${AppURL.kDeleteImagesURL}$productId',
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
