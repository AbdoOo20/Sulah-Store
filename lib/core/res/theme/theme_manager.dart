

import 'package:flutter/material.dart';
import 'package:sulah_store/core/res/theme/styles_manager.dart';
import 'package:sulah_store/core/res/theme/styles_manager.dart';
import 'package:sulah_store/core/res/theme/value_manager.dart';

import '../../resources/app_colors.dart';
import '../../resources/font_manager.dart';

ThemeData getAppTheme(){
  return ThemeData(
    //لالالالالالالالالالالالالالا

    //لالالالالالالالالالالالالالا
    //main color
    primaryColor: AppColors.main,
    disabledColor:AppColors.main,
    splashColor:AppColors.main,//ripple effect
    //TEXT HEME

    // INPUT DECORATION THEME

    //APP BAR THEME
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: AppColors.main,
        elevation: AppSize.s4,
        shadowColor: AppColors.main,
        titleTextStyle: getRegularStyle(color: AppColors.main,fontSize: FontSize.s16)
      ),

    //BUTTON THEME
      buttonTheme:  ButtonThemeData(
        ///StadiumBorder is 1/2 circle
        shape: StadiumBorder(
        ),
        buttonColor: AppColors.main,
        splashColor: AppColors.main,
        disabledColor: AppColors.main,
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: AppColors.main,

        ),
      )
    ),

    //CARED THEME
    cardTheme: const CardThemeData(
      color: AppColors.main,
      shadowColor: AppColors.main,
      elevation: AppSize.s4,
    )

  );
}