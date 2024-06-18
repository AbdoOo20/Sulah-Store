import 'package:khedmaty_store/data/datasource/remote/dio/dio_client.dart';
import 'package:khedmaty_store/data/model/body/RegisterBody.dart';
import 'package:khedmaty_store/presentation/screens/auth/register/RegisterViewModel.dart';
import 'package:khedmaty_store/presentation/screens/auth/forgetPassword/otp/otp_view_model.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/homeViewModel.dart';
import 'package:khedmaty_store/presentation/screens/home/offers/offer%20view%20model.dart';
import 'package:khedmaty_store/presentation/screens/home/orders/oreders_view_model.dart';
import 'package:khedmaty_store/presentation/screens/home/products/products_view_model.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:khedmaty_store/presentation/screens/setting/connect_Us/contactUs_view_model.dart';
import 'package:khedmaty_store/presentation/screens/setting/setting_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/network_info.dart';
import 'data/app_urls/app_url.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/model/body/porduct_body.dart';
import 'data/repository/SaveUserData.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/home_Repo.dart';
import 'data/repository/main_repo.dart';
import 'data/repository/orders_repo.dart';
import 'data/repository/products_repo.dart';
import 'data/repository/profile_repo.dart';
import 'data/repository/rates_repo.dart';
import 'data/repository/wallet_repo.dart';
import 'presentation/screens/auth/forgetPassword/newPassword/new_password_view_model.dart';
import 'presentation/screens/auth/login/LoginViewModel.dart';
import 'presentation/screens/home/products/add_product/add_product_view_model.dart';
import 'presentation/screens/home/products/add_product/screen/compatible_with_provider.dart';
import 'presentation/screens/setting/modifyAccount/modify_account_view_model.dart';
import 'presentation/screens/setting/ratings/rates_view_model.dart';
import 'presentation/screens/setting/wallet/wallet_view_model.dart';


final getIt = GetIt.instance;

Future<void> init() async {
  // Core
  getIt.registerLazySingleton(() => NetworkInfo(getIt()));
  getIt.registerLazySingleton(() => DioClient(AppURL.kBaseURL, getIt(), loggingInterceptor: getIt(), sharedPreferences: getIt()));

  /// Providers
  getIt.registerLazySingleton(() => LoginViewModel(authRepo: getIt(), saveUserData: getIt(),));
  getIt.registerLazySingleton(() => ProductsViewModel(productsRepo: getIt(),homeRepo: getIt()));
  getIt.registerLazySingleton(() => ContactUsViewModel(mainRepo: getIt(),));
  getIt.registerLazySingleton(() => SettingViewModel(saveUserData: getIt(),profileRepo: getIt(),authRepo:getIt() ));
  getIt.registerLazySingleton(() => OrdersViewModel(saveUserData: getIt(), ordersRepo: getIt()));
  getIt.registerLazySingleton(() => HomeViewModel(homeRepo: getIt(), saveUserData: getIt(),));
  getIt.registerLazySingleton(() => RegisterViewModel(authRepo: getIt(),saveUserData: getIt()));
  getIt.registerLazySingleton(() => OtpViewModel(authRepo: getIt(),registerBody: getIt()));
  getIt.registerLazySingleton(() => WalletViewModel(walletRepo: getIt()));
  getIt.registerLazySingleton(() => ModifyAccountViewModel(profileRepo: getIt(), saveUserData: getIt()));
  getIt.registerLazySingleton(() => NewPasswordViewModel(authRepo: getIt(), saveUserData: getIt()));
  getIt.registerLazySingleton(() => AddProductViewModel( productsRepo: getIt()));
  getIt.registerLazySingleton(() => RatesViewModel( ratesRepo: getIt()));
  getIt.registerLazySingleton(() => CompatibleWithViewModel());
  getIt.registerLazySingleton(() => OfferProvider());
  /// Repository
  getIt.registerLazySingleton(() => SaveUserData(sharedPreferences: getIt(), dioClient: getIt()));
  getIt.registerLazySingleton(() => AuthRepo(dioClient: getIt(), saveUserData: getIt()));
  getIt.registerLazySingleton(() => ProfileRepo(dioClient: getIt(), saveUserData: getIt()));
  getIt.registerLazySingleton(() => ProductsRepo(dioClient: getIt()));
  getIt.registerLazySingleton(() => OrdersRepo(saveUserData: getIt(), dioClient: getIt()));
  getIt.registerLazySingleton(() => HomeRepo(dioClient: getIt()));
  getIt.registerLazySingleton(() => MainRepo( dioClient: getIt()));
  getIt.registerLazySingleton(() => RatesRepo( dioClient: getIt()));
  getIt.registerLazySingleton(() => WalletRepo( dioClient: getIt()));

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => LoggingInterceptor());
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton(() => RegisterBody());
  getIt.registerLazySingleton(() => ProductsBody());
}
