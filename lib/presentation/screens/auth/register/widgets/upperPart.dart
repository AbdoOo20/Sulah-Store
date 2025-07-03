import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';

import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../component/svg_icon.dart';

class UpperPart extends StatelessWidget {
  const UpperPart({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(
          top: kFormPaddingVertical.h,
          bottom: kFormPaddingHorizontal.h,
          right: kFormPaddingAllLarge * 2.4.w,
          left: kFormPaddingAllLarge * 2.4.w),
      margin: const EdgeInsets.only(bottom: kScreenPaddingLarge),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.second.withOpacity(.2)),
          color: AppColors.second.withOpacity(.1)),
      child: Row(
        children: [
           SVGIcon(
            Assets.punctuationMarks,
            width: 23.w,
            height: 24.h,
             color: AppColors.main,
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.tr(),
                  style: TextStyles()
                      .getTitleStyle(fontSize: 16.sp)
                      .customColor(AppColors.black),
                  softWrap: true,
                ),

                Text(
                  body.tr(),
                  style: TextStyles()
                      .getRegularStyle(fontSize: 14.sp)
                      .customColor(AppColors.darkGray),
                  softWrap: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
