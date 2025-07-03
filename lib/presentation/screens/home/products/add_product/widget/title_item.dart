import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/resources.dart';
import '../../../../../component/svg_icon.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({Key? key, required this.image, required this.title})
      : super(key: key);
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0.w),
          child: SVGIcon(
            image,
            width: (20.w),
            height: (20.h),
            color: AppColors.main,
          ),
        ),
        Text(
          title.tr(),
          style: TextStyles()
              .getTitleStyle(fontSize: 14.sp)
              .customColor(AppColors.black),
        ),
      ],
    );
  }
}
