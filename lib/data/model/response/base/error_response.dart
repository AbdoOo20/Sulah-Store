/// errors : [{"code":"l_name","message":"The last name field is required."},{"code":"password","message":"The password field is required."}]

class ErrorResponse {
  List<Errors>? _errors;
  List<Errors>? get errors => _errors;

  ErrorResponse({
      required List<Errors> errors}){
    _errors = errors;
}

  ErrorResponse.fromJson(dynamic json) {
    if (json["errors"] != null) {
      _errors = [];
      json["errors"].forEach((v) {
        _errors?.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_errors != null) {
      map["errors"] = _errors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  String? _code;
  String? _message;

  String? get code => _code;
  String? get message => _message;

  Errors({
      String? code,
      String? message}){
    _code = code;
    _message = message;
}

  Errors.fromJson(dynamic json) {
    _code = json["code"];
    _message = json["message"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    map["message"] = _message;
    return map;
  }

}



/// {
/// "code": 422,
/// "data": [ "" ,""],
/// "message": ""}

// To parse this JSON data, do
//
//     final error422Response = error422ResponseFromJson(jsonString);
class Error422Response {
  int? code;
  Data? data;
  String? message;

  Error422Response({
    this.code,
    this.data,
    this.message,
  });

  factory Error422Response.fromJson(Map<String, dynamic> json) => Error422Response(
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
  List<String>? phone;

  Data({
    this.phone,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phone: json["phone"] == null ? [] : List<String>.from(json["phone"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "phone": phone == null ? [] : List<dynamic>.from(phone!.map((x) => x)),
  };
}

