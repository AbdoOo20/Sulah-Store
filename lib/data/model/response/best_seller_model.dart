class BestSellerModel {
  int? code;
  List<TopSalesProduct>? data;
  String? message;

  BestSellerModel({
    this.code,
    this.data,
    this.message,
  });

  factory BestSellerModel.fromJson(Map<String, dynamic> json) => BestSellerModel(
    code: json["code"],
    data: json["data"] == null ? [] : List<TopSalesProduct>.from(json["data"]!.map((x) => TopSalesProduct.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class TopSalesProduct {
  int? id;
  String? title;
  String? description;
  String? mainImage;
  String? code;
  String? type;
  num? oldPrice;
  num? price;
  num? salesCount;
  num? rate;
  int? isShow;
  int? storeId;
  User? user;
  int? departmentId;
  Department? department;
  List<Images>? images;
  ProductsOffers? productsOffers;
  List<ProductsAddition>? productsAdditions;
  int? isFavourite;

  TopSalesProduct({
    this.id,
    this.title,
    this.description,
    this.mainImage,
    this.code,
    this.type,
    this.oldPrice,
    this.price,
    this.salesCount,
    this.rate,
    this.isShow,
    this.storeId,
    this.user,
    this.departmentId,
    this.department,
    this.images,
    this.productsOffers,
    this.productsAdditions,
    this.isFavourite,
  });

  factory TopSalesProduct.fromJson(Map<String, dynamic> json) => TopSalesProduct(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    mainImage: json["main_image"],
    code: json["code"],
    type: json["type"],
    oldPrice: json["old_price"],
    price: json["price"],
    salesCount: json["sales_count"],
    rate: json["rate"],
    isShow: json["is_show"],
    storeId: json["store_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    departmentId: json["department_id"],
    department: json["department"] == null ? null : Department.fromJson(json["department"]),
    images: json["images "] == null ? [] : List<Images>.from(json["images "]!.map((x) => Images.fromJson(x))),
    productsOffers: json["products_offers"] == null ? null : ProductsOffers.fromJson(json["products_offers"]),
    productsAdditions: json["products_additions"] == null ? [] : List<ProductsAddition>.from(json["products_additions"]!.map((x) => ProductsAddition.fromJson(x))),
    isFavourite: json["is_favourite"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "main_image": mainImage,
    "code": code,
    "type": type,
    "old_price": oldPrice,
    "price": price,
    "sales_count": salesCount,
    "rate": rate,
    "is_show": isShow,
    "store_id": storeId,
    "user": user?.toJson(),
    "department_id": departmentId,
    "department": department?.toJson(),
    "images ": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "products_offers": productsOffers?.toJson(),
    "products_additions": productsAdditions == null ? [] : List<dynamic>.from(productsAdditions!.map((x) => x.toJson())),
    "is_favourite": isFavourite,
  };
}

class Department {
  int? id;
  String? title;
  String? image;

  Department({
    this.id,
    this.title,
    this.image,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    title:json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title":title,
    "image": image,
  };
}


class Images {
  int? id;
  String? images;

  Images({
    this.id,
    this.images,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
    id: json["id"],
    images: json["images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": images,
  };
}

class ProductsAddition {
  int? id;
  String? manufactureYear;
  int? brandId;
  Department? brand;
  int? carId;
  Car? car;

  ProductsAddition({
    this.id,
    this.manufactureYear,
    this.brandId,
    this.brand,
    this.carId,
    this.car,
  });

  factory ProductsAddition.fromJson(Map<String, dynamic> json) => ProductsAddition(
    id: json["id"],
    manufactureYear: json["manufacture_year"],
    brandId: json["brand_id"],
    brand: json["brand"] == null ? null : Department.fromJson(json["brand"]),
    carId: json["car_id"],
    car: json["car"] == null ? null : Car.fromJson(json["car"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "manufacture_year": manufactureYear,
    "brand_id": brandId,
    "brand": brand?.toJson(),
    "car_id": carId,
    "car": car?.toJson(),
  };
}

class Car {
  int? id;
  String? title;

  Car({
    this.id,
    this.title,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}


class ProductsOffers {
  int? id;
  String? type;
  num? value;
  DateTime? fromDate;
  DateTime? toDate;

  ProductsOffers({
    this.id,
    this.type,
    this.value,
    this.fromDate,
    this.toDate,
  });

  factory ProductsOffers.fromJson(Map<String, dynamic> json) => ProductsOffers(
    id: json["id"],
    type: json["type"],
    value: json["value"],
    fromDate: json["from_date"] == null ? null : DateTime.parse(json["from_date"]),
    toDate: json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "value": value,
    "from_date": "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
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

