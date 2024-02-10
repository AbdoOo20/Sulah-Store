class DepartmentModel {
  String? message;
  int? code;
  List<Datum>? data;

  DepartmentModel({
    this.message,
    this.code,
    this.data,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) => DepartmentModel(
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? title;
  String? image;

  Datum({
    this.id,
    this.title,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };
}
