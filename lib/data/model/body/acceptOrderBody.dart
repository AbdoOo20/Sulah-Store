class AcceptOrderBody {

  String? status;

  AcceptOrderBody({
       this.status,
  });

  factory AcceptOrderBody.fromJson(Map<String, dynamic> json) => AcceptOrderBody(

    status: json["status"],
  );

  Map<String, dynamic> toJson() => {

    "status": status,
  };
}
