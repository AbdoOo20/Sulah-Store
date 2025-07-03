import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_colors.dart';

class CustomStateBare extends StatelessWidget {
  const CustomStateBare({
    super.key, required this.state,this.title, required this.totalState,
  });
  final String state;
  final String totalState;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:  AppColors.grayTextField),
          ),
          Align(
            alignment: Alignment.centerRight,
            child:  Container(
              height: 56,
              width:totalState=='4'?
              state=='2'?MediaQuery.of(context).size.width/4:
              state=='4'?MediaQuery.of(context).size.width/2:
              state=='6'?MediaQuery.of(context).size.width*0.745:
              state=='8'?MediaQuery.of(context).size.width:
              MediaQuery.of(context).size.width
                  :
              state=='1'?MediaQuery.of(context).size.width*0.120:
              state=='2'?MediaQuery.of(context).size.width*0.245:
              state=='3'?MediaQuery.of(context).size.width*0.370:
              state=='4'?MediaQuery.of(context).size.width*0.495:
              state=='5'?MediaQuery.of(context).size.width*0.620:
              state=='6'?MediaQuery.of(context).size.width*0.745:
              state=='7'?MediaQuery.of(context).size.width*0.865:
              state=='8'?MediaQuery.of(context).size.width:
              MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color:title == LocaleKeys.driverCanceled.tr()||title == LocaleKeys.requestRejected.tr()||title == LocaleKeys.requestCancel.tr()?AppColors.errorColor:  AppColors.main),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Text(
              title ?? LocaleKeys.approved.tr(),
              style: TextStyles()
                  .getTitleStyle(fontSize: 12.sp)
                  .customColor(AppColors.white),
            ),
          ),Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                '$totalState/${totalState=='8'?state:((double.parse(state))/2).floor()}',
                style: TextStyles()
                    .getTitleStyle(fontSize: 12.sp)
                    .customColor(AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
