import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';

import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../component/svg_icon.dart';

class ProductsCard extends StatelessWidget {
  const ProductsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
       height: 120.h,
       width: 120.h,
      child: Card(
        // margin: EdgeInsets.only(
        //     bottom: kScreenPaddingNormal.h,
        //     top: kScreenPaddingNormal.h),

        elevation: 3,

        color: AppColors.white,
        shadowColor: AppColors.main10,
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(16.r)),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            SVGIcon(
              Assets.products,
              width: 48.w,
              height: 48.h,
            ),
            SizedBox(height: 12.h),
            Text(
              LocaleKeys.products.tr(),
              style: TextStyles()
                  .getTitleStyle(
                  fontSize: 16.sp)
                  .customColor(
                  AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}
