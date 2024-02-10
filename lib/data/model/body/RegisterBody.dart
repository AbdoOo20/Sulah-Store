import 'dart:io';

class RegisterBody {
  String? phone;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? title;
  String? longitude;
  String? bankId;
  String? latitude;
  String? iban;
  String? address;
  String? departmentId;
  String? userCategoryId;
  String? registerFrom;
  File? workingDocument;
  String? endDateDocument;
  String? countryCode;
  File? image;
  RegisterBody({
    this.phone,
    this.email,
    this.password,
    this.title,
    this.userCategoryId,
    this.passwordConfirmation,
    this.longitude,
    this.latitude,
    this.countryCode='+200',
    this.bankId,
    this.registerFrom,
    this.iban,
    this.address,
    this.departmentId,
    this.workingDocument,
    this.endDateDocument,
    this.image,
  });

  factory RegisterBody.fromJson(Map<String, dynamic> json) => RegisterBody(
    phone: json["phone"],
    email: json["email"],
    registerFrom: json["register_from"],
    userCategoryId: json["user_category_id"],
    countryCode: json["country_code"],
    password: json["password"],
    title: json["name"],
    passwordConfirmation: json["password_confirmation"],
    longitude: json["longitude"],
    latitude: json["latitude"],
    address: json["address"],
    bankId: json["bank_id"],
    iban: json["iban"],
    departmentId: json["department_id"],
    workingDocument: json["commercial_register"],
    endDateDocument: json["end_date_document"],
    image: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
    "register_from": registerFrom,
    "user_category_id": userCategoryId,
    "country_code": countryCode,
    "password": password,
    "name": title,
    "longitude": longitude,
    "latitude": latitude,
    "password_confirmation": passwordConfirmation,
    "address": address,
    "bank_id": bankId,
    "iban": iban,
    "department_id": departmentId,
    "commercial_register": workingDocument,
    "end_date_document": endDateDocument,
    "logo": image,
  };
}
