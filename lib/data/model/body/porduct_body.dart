
import 'dart:io';

class ProductsBody {
  String? title;
  String? code;
  String? departmentId;
  File? mainImage;
  List<File>? images;
  String? description;
  String? price;
  String? unit;
  int? isOffer;
  int? isShow;
  String? offerType;
  int? type;
  String? offerValue;
  String? offerStartDate;
  String? offerEndDate;
  List<ProductListBody>? productList = [];
  ProductsBody({
    this.title,
    this.code,
    this.departmentId,
    this.images,
    this.description,
    this.type,
    this.isShow,
    this.mainImage,
    this.price,
    this.unit,
    this.productList,
    this.isOffer,
    this.offerType,
    this.offerValue,
    this.offerStartDate,
    this.offerEndDate,

    // this.additions,
  });

  factory ProductsBody.fromJson(Map<String, dynamic> json) => ProductsBody(
    title: json["title"],
    code: json["code"],
    isShow: json["is_show"],
    departmentId: json["department_id"],
    mainImage: json["main_image"],
    images: json["images_list"] == null ? [] : List<File>.from(json["images"]!.map((x) => x)),
    description: json["description"],
    price: json["price"],
    productList: json["product_list"] ==null ? [] : List<ProductListBody>.from(json["product_list"]!.map((x) => ProductListBody.fromJson(x))),
    // items: json["items"] ==null ? [] : List<Map<String, String>>.from(json["data"]!.map((x) => x)),
    unit: json["unit"],
    isOffer: json["have_offer"],
    offerType: json["offer_type"],
    offerValue: json["offer_value"],
    type: json["type"],
    offerStartDate: json["from_date"],
    offerEndDate: json["to_date"],

  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "code": code,
    "main_image": mainImage,
    "is_show": isShow,
    "department_id": departmentId,
    "product_list": productList== null ? [] : List<Map<String, dynamic>>.from(productList!.map((x) => x)),
    // "items": items== null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "images_list":  images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "description": description,
    "price": price,
    "unit": unit,
    "have_offer": isOffer,
    "offer_type": offerType,
    "offer_value": offerValue,
    "type": type,
    "from_date": offerStartDate,
    "to_date": offerEndDate,

  };
}


class ProductListBody {
  String? manufactureYear;
  String? brandId;
  String? carId;


  ProductListBody({
    this.manufactureYear,
    this.brandId,
    this.carId,

  });

  factory ProductListBody.fromJson(Map<String, dynamic> json) => ProductListBody(
    manufactureYear: json["manufacture_year"],
    brandId: json["brand_id"],
    carId: json["car_id"],
  );

  Map<String, dynamic> toJson() => {
    "manufacture_year": manufactureYear,
    "brand_id": brandId,
    "car_id": carId,
  };
}
