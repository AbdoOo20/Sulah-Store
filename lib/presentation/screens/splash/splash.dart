import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/injection.dart';
import 'package:sulah_store/presentation/screens/home/home_sereen/home.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/app_assets.dart';
import '../../../core/routing/route.dart';
import '../../../data/repository/SaveUserData.dart';
import '../auth/Intro/introScreen.dart';
import '../auth/login/LoginViewModel.dart';
import '../auth/login/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
   SaveUserData sharedPreferences=getIt();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      sharedPreferences.saveLang(context.locale.toString());
      pushAndRemoveUntil(IntroScreen());
     if (Provider.of<LoginViewModel>(context, listen: false).saveUserData.getUserToken()=='') {
        if (Provider.of<LoginViewModel>(context, listen: false).saveUserData.getIsIntroShow()) {
          pushAndRemoveUntil(const LoginScreen());
        }else{
          pushAndRemoveUntil(IntroScreen());
        }
      }else{
        pushAndRemoveUntil(const Home());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.splash),
            fit: BoxFit.cover
          ),
        ),
      ),
    );
  }
}
