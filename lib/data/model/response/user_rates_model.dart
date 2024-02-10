class UserRatesModel {
  int? code;
  List<Datum>? data;
  String? message;

  UserRatesModel({
    this.code,
    this.data,
    this.message,
  });

  factory UserRatesModel.fromJson(Map<String, dynamic> json) => UserRatesModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  int? id;
  num? rate;
  int? fromUserId;
  User? fromUser;
  int? toUserId;
  User? toUser;
  String? comment;

  Datum({
    this.id,
    this.rate,
    this.fromUserId,
    this.fromUser,
    this.toUserId,
    this.toUser,
    this.comment,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    rate: json["rate"],
    fromUserId: json["from_user_id"],
    fromUser: json["from_user"] == null ? null : User.fromJson(json["from_user"]),
    toUserId: json["to_user_id"],
    toUser: json["to_user"] == null ? null : User.fromJson(json["to_user"]),
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rate": rate,
    "from_user_id": fromUserId,
    "from_user": fromUser?.toJson(),
    "to_user_id": toUserId,
    "to_user": toUser?.toJson(),
    "comment": comment,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  num? rate;
  String? phoneCode;
  String? address;
  num? latitude;
  num? longitude;
  String? logo;
  String? commercialRegister;
  int? userCategoryId;
  dynamic userCategory;
  num? notificationStatus;
  int? isVerified;
  num? status;
  String? registerFrom;
  int? isBlock;
  String? token;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.rate,
    this.phoneCode,
    this.address,
    this.latitude,
    this.longitude,
    this.logo,
    this.commercialRegister,
    this.userCategoryId,
    this.userCategory,
    this.notificationStatus,
    this.isVerified,
    this.status,
    this.registerFrom,
    this.isBlock,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    type: json["type"],
    rate: json["rate"],
    phoneCode: json["phone_code"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    logo: json["logo"],
    commercialRegister: json["commercial_register"],
    userCategoryId: json["user_category_id"],
    userCategory: json["user_category"],
    notificationStatus: json["notification_status"],
    isVerified: json["is_verified"],
    status: json["status"],
    registerFrom: json["register_from"],
    isBlock: json["is_block"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "type": type,
    "rate": rate,
    "phone_code": phoneCode,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "logo": logo,
    "commercial_register": commercialRegister,
    "user_category_id": userCategoryId,
    "user_category": userCategory,
    "notification_status": notificationStatus,
    "is_verified": isVerified,
    "status": status,
    "register_from": registerFrom,
    "is_block": isBlock,
    "token": token,
  };
}
