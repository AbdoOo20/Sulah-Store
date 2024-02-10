import 'one_order_model.dart';

class OrdersModel {
  List<SingleOrder>? data;
  String? message;
  int? code;
  OrdersModel({
    this.data,
    this.message,
    this.code,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    data: json["data"] == null ? [] : List<SingleOrder>.from(json["data"]!.map((x) => SingleOrder.fromJson(x))),
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "code": code,
  };
}