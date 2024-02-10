class StatisticsModel {
  int? code;
  Data? data;
  String? message;

  StatisticsModel({
    this.code,
    this.data,
    this.message,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) => StatisticsModel(
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  int? orderCount;
  String? difference;
  num? orderValues;
  String? differenceValue;
  num? productCount;
  num? newOrderCount;
  num? currentOrderCount;
  num? completeOrderCount;

  Data({
    this.orderCount,
    this.difference,
    this.orderValues,
    this.differenceValue,
    this.productCount,
    this.newOrderCount,
    this.currentOrderCount,
    this.completeOrderCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderCount: json["order_count"],
    difference: json["difference"],
    orderValues: json["order_values"],
    differenceValue: json["differenceValue"],
    productCount: json["product_count"],
    newOrderCount: json["new_order_count"],
    currentOrderCount: json["current_order_count"],
    completeOrderCount: json["complete_order_count"],
  );

  Map<String, dynamic> toJson() => {
    "order_count": orderCount,
    "difference": difference,
    "order_values": orderValues,
    "differenceValue": differenceValue,
    "product_count": productCount,
    "new_order_count": newOrderCount,
    "current_order_count": currentOrderCount,
    "complete_order_count": completeOrderCount,
  };
}
