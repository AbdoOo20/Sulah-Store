class AppURL {
  static const String kBaseURL = "https://sulah.sa/api/";
  ///Auth
  static const String kRegisterURI = "auth/register";
  static const String kLoginURI = "auth/login";
  static const String kLogoutURI = "auth/logout";
  static const String kProfileURI = "auth/profile";
  static const String sendCodeURI = "auth/send-code";
  static const String confirmCodeURI = "auth/confirm-code";
  static const String kResetPasswordURI = "auth/reset-password";
  ///profile
  static const String kProfileUpdateURI = "auth/update/profile";
  static const String kDeleteAccountURI = "auth/delete/profile";
  static const String kUpdateStateAndNotificationURI = "auth/update/";

  ///Contact Us
  static const String contactUsURI = "stores/contact-us";
  ///home
  static const String kStatisticsURL = "stores/home/statistics";
  static const String kBestSellerURL = "stores/home/best-seller";
  ///orders
  static const String kOrdersURL = "stores/orders?status=";
  static const String kOneOrdersURL = "stores/orders/";
  static const String kUpdateOrdersStatusURL = "stores/orders/update-status/";
  ///rates
  static const String kProductRatesURL = "stores/product-rates";
  static const String kUserRatesURL = "stores/user-rates";
  ///Wallet
  static const String kWalletURI = "stores/wallet";
  static const String kProfileBalanceWithdrawalRequestURI = "stores/withdrawal-request";
  ///products
  static const String kGetAndCreateProductsURL = 'stores/products';
  static const String kUpdateAndDeleteProductsURL = 'stores/products/';
  static const String showProductURL = "stores/products/update-status/";
  static const String kDeleteImagesURL = "stores/products/delete-images/";
  static const String kCarsURL = "stores/cars";
  static const String kBrandsURL = "stores/brands";
  static const String kDepartmentsURL = "stores/departments";

}
