class WalletModel {
  int? code;
  Data? data;
  String? message;

  WalletModel({
    this.code,
    this.data,
    this.message,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
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
  num? total;
  List<Wallet>? wallet;

  Data({
    this.total,
    this.wallet,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    wallet: json["wallet"] == null ? [] : List<Wallet>.from(json["wallet"]!.map((x) => Wallet.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "wallet": wallet == null ? [] : List<dynamic>.from(wallet!.map((x) => x.toJson())),
  };
}

class Wallet {
  int? id;
  String? paymentMethod;
  num? total;
  String? createdDate;
  String? createdTime;

  Wallet({
    this.id,
    this.paymentMethod,
    this.total,
    this.createdDate,
    this.createdTime,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    paymentMethod: json["payment_method"],
    total: json["total"],
    createdDate: json["created_date"] ,
    createdTime: json["created_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "payment_method": paymentMethod,
    "total": total,
    "created_date": createdDate,
    "created_time": createdTime,
  };
}
