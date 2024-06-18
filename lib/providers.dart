import 'package:khedmaty_store/presentation/screens/auth/register/RegisterViewModel.dart';
import 'package:khedmaty_store/presentation/screens/auth/forgetPassword/otp/otp_view_model.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/homeViewModel.dart';
import 'package:khedmaty_store/presentation/screens/home/offers/offer%20view%20model.dart';
import 'package:khedmaty_store/presentation/screens/home/products/products_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:khedmaty_store/presentation/screens/setting/connect_Us/contactUs_view_model.dart';
import 'package:khedmaty_store/presentation/screens/setting/ratings/rates_view_model.dart';
import 'package:khedmaty_store/presentation/screens/setting/setting_view_model.dart';
import 'package:provider/provider.dart';
import 'injection.dart';
import 'presentation/screens/auth/forgetPassword/newPassword/new_password_view_model.dart';
import 'presentation/screens/auth/login/LoginViewModel.dart';
import 'presentation/screens/home/orders/oreders_view_model.dart';
import 'presentation/screens/home/products/add_product/add_product_view_model.dart';
import 'presentation/screens/home/products/add_product/screen/compatible_with_provider.dart';
import 'presentation/screens/setting/modifyAccount/modify_account_view_model.dart';
import 'presentation/screens/setting/wallet/wallet_view_model.dart';

class GenerateMultiProvider extends StatelessWidget {
  final Widget child;

  const GenerateMultiProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<LoginViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<RegisterViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ProductsViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ContactUsViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<HomeViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<OrdersViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<SettingViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<OtpViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<WalletViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<ModifyAccountViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<NewPasswordViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<AddProductViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<RatesViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<CompatibleWithViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<OfferProvider>()),
      ],
      child: child,
    );
  }
}
