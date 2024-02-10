
class EmptyModel {
  dynamic data;
  String? message;
  int? code;

  EmptyModel({
    this.data,
    this.message,
    this.code,
  });

  factory EmptyModel.fromJson(Map<String, dynamic> json) => EmptyModel(
    data: json["data"],
    message: json["message"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "code": code,
  };
}
