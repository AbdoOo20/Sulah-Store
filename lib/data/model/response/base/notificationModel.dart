
class NotificationsModel {
  String? message;
  int? code;
  List<Datum>? data;

  NotificationsModel({
    this.message,
    this.code,
    this.data,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
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
  int? orderId;
  String? title;
  String? message;
  String? action;
  bool? isRead;
  DateTime? notificationDate;

  Datum({
    this.id,
    this.orderId,
    this.title,
    this.message,
    this.action,
    this.isRead,
    this.notificationDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    orderId: json["order_id"],
    title: json["title"],
    message: json["message"],
    action: json["action"],
    isRead: json["is_read"],
    notificationDate: json["notification_date"] == null ? null : DateTime.parse(json["notification_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "title": title,
    "message": message,
    "action": action,
    "is_read": isRead,
    "notification_date": "${notificationDate!.year.toString().padLeft(4, '0')}-${notificationDate!.month.toString().padLeft(2, '0')}-${notificationDate!.day.toString().padLeft(2, '0')}",
  };
}
