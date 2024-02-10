import 'package:country_code_picker/country_localizations.dart';
import 'package:easy_localization/easy_localization.dart' as el;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khedmaty_store/presentation/firebase_notification/notification_services.dart';

import 'core/res/theme/theme.dart';
import 'main.dart';
import 'presentation/screens/splash/splash.dart';
BuildContext? appContext;
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // NotificationServices notificationServices = NotificationServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // notificationServices.requestNotificationPermission();
    // notificationServices.requestPermission();
    // notificationServices.forgroundMessage();
    // notificationServices.firebaseInit(context);
    // notificationServices.setupInteractMessage(context);
    // notificationServices.getDeviceToken().then((value){
    //   if (kDebugMode) {
    //     print('device token');
    //     print(value);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,]);
    return MaterialApp(
      // theme: ThemeData(brightness: Brightness.dark),
      // theme: ThemeData(brightness: Brightness.light),
      color:Theme.of(context).scaffoldBackgroundColor,
      localizationsDelegates: [
        CountryLocalizations.delegate, ...context.localizationDelegates,
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // locale: supportedLocales[0],
      title: 'سيولة',
      // theme: appTheme,
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigator,
      home: const Splash(),
    );
  }
}

