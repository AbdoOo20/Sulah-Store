import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/showToast.dart';
import '../../../../../data/app_urls/app_url.dart';
import '../../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../injection.dart';

class ProductOffer {
  int id;
  int orderID;
  int amount;
  int price;
  int totalPrice;
  String title;
  String image;
  String name;
  String statusOrder;
  String paymentStatus;
  int priceOrder;

  ProductOffer({
    required this.id,
    required this.orderID,
    required this.amount,
    required this.totalPrice,
    required this.price,
    required this.title,
    required this.image,
    required this.name,
    required this.statusOrder,
    required this.priceOrder,
    required this.paymentStatus,
  });

  factory ProductOffer.fromJson(Map<String, dynamic> json) => ProductOffer(
        id: json["id"],
        orderID: json["my_order"] == null ? 0 : json["my_order"]['offer_product_id'],
        amount: json["amount"],
        price: json["price"],
        totalPrice: json["total_price"],
        title: json['product_title'],
        image: "https://sulah.sa/storage/${json['product_image']}",
        name: json['user_name'],
        statusOrder:
            json['my_order'] == null ? 'waiting' : json['my_order']['status'],
        priceOrder: json['my_order'] == null ? 0 : json['my_order']['price'],
        paymentStatus:
            json['my_order'] == null ? '' : json['my_order']['payment_status'],
      );
}

class OfferProvider with ChangeNotifier {
  bool isLoading = false;
  late DioClient dioClient;
  List<ProductOffer> offers = [];
  TextEditingController priceController = TextEditingController();

  Future<void> getOffers(BuildContext context) async {
    isLoading = true;
    offers = [];
    dioClient = getIt();
    Response response =
        await dioClient.get("${AppURL.kBaseURL}${AppURL.kOfferURL}");
    if (response.statusCode == 200) {
      response.data['data'].forEach((e) {
        log(e.toString());
        log('---------------------------------------------------------');
        offers.add(ProductOffer.fromJson(e));
      });
    } else {
      isLoading = false;
      ToastUtils.showToast(response.data['message']);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> addOfferToOrder(int price, int id, int amount) async {
    dioClient = getIt();
    isLoading = true;
    notifyListeners();
    log(price.toString());
    Map<String, dynamic> data = {
      'price': price,
      'amount': amount,
      'id': id,
    };
    Response response = await dioClient.post(
      "${AppURL.kBaseURL}${AppURL.kAddOfferURL}",
      data: data,
    );
    if (response.statusCode == 200) {
      ToastUtils.showToast(response.data['message']);
      priceController.clear();
      isLoading = false;
      notifyListeners();
    } else {
      ToastUtils.showToast(response.data['message']);
      priceController.clear();
      isLoading = false;
      notifyListeners();
    }
  }
}
