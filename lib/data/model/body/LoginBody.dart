class LoginBody {
  String? phone;
  String? password;

  LoginBody({
    this.phone,
    this.password,
  });

  factory LoginBody.fromJson(Map<String, dynamic> json) => LoginBody(
    phone: json["phone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "password": password,
  };
}
