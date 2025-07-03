import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/resources.dart';
import '../../../component/svg_icon.dart';

class CustomSettingCared extends StatelessWidget {
  const CustomSettingCared({
    super.key,
    this.name,
    //this.image,
  });

  final String? name;
  //final String? image;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              height: 56.h,
              width: 64.w,
              child:
              //image != '' && image != null ?
              SVGIcon(
                    Assets.imageIcon,
               // fit: BoxFit.fill,
                    height: 50.h,
                    width: 60.w,)
                  // : Image.asset(
                  //     Assets.icon,
                  //     fit: BoxFit.cover,
                  //   ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.hello.tr(),
                  style: TextStyles()
                      .getRegularStyle(fontSize: 12)
                      .customColor(AppColors.darkGray),
                ),
                Text(
                  name != '' && name != null ? name! : LocaleKeys.appName.tr(),
                  style: TextStyles()
                      .getTitleStyle(fontSize: 16)
                      .customColor(AppColors.semeBlack),
                )
              ],
            ),
          ],
        ),
        SVGIcon(
          Assets.edit,
          width: (48.w),
          height: (48.h),
        ),
      ],
    );
  }
}
