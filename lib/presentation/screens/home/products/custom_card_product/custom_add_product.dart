import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/resources/locale_keys.g.dart';
import 'package:khedmaty_store/presentation/component/svg_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
      height: 65.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.grayTextField,
            width: .5.w,
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SVGIcon(
                  Assets.product,
                  color: AppColors.main,
                  width: 25.w,
                  height: 25.h,
                ),
                 SizedBox(
                  width: 10.w,
                ),
                Text(
                  LocaleKeys.addproduct.tr(),
                  style: TextStyles()
                      .getTitleStyle(fontSize: 12.sp)
                      .customColor(AppColors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
