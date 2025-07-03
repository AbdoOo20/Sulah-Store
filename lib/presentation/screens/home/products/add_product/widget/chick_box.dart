
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/resources.dart';

class ChickBoxWidget extends StatelessWidget {
  const ChickBoxWidget({
    super.key,
    required bool isChecked,
  }) : _isChecked = isChecked;

  final bool _isChecked;
// bool _isChecked =false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24.h,
          width: 24.w,
          decoration: BoxDecoration(
              border: Border.all(
                color:  AppColors.main,
                width: 1.w,
              ), color: _isChecked ? AppColors.main : AppColors.white,
              borderRadius: BorderRadius.circular(4)),
          child: Center(
            child: Icon(
              Icons.done,
              color: _isChecked ? AppColors.white : AppColors.white,
              size: 20.r,
            ),
          ),
        ),
        SizedBox(width: 8.0.w),
        Text(
          LocaleKeys.addashow.tr(),
          style: TextStyles()
              .getDescriptionStyle(fontSize: 16.sp)
              .customColor(AppColors.black),
        ),
      ],
    );
  }
}