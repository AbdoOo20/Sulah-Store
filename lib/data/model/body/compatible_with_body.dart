class CompatibleWithBody {
  String? manufactureYear;
  String? brand;
  String? brandId;
  String? car;
  String? carId;


  CompatibleWithBody({
    this.manufactureYear,
    this.brandId,
    this.brand,
    this.carId,
    this.car,

  });

  factory CompatibleWithBody.fromJson(Map<String, dynamic> json) => CompatibleWithBody(
    manufactureYear: json["manufacture_year"],
    brandId: json["brand_id"],
    brand: json["brand"],
    carId: json["car_id"],
    car: json["car"],
  );

  Map<String, dynamic> toJson() => {
    "manufacture_year": manufactureYear,
    "brand_id": brandId,
    "brand": brand,
    "car_id": carId,
    "car": car,
  };
}
