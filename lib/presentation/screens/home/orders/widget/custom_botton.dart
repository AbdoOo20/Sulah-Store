import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/component/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/resources.dart';


class CustomOrdersButton extends StatelessWidget {
  const CustomOrdersButton({
    Key? key,
    required this.onTap,
    required this.label,
    required this.color,
    this.textColor,
    this.height,
    this.buttonIconTitle, this.borderColor,
  }) : super(key: key);
  final Function() onTap;
  final String label;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final String? buttonIconTitle;

  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 53.h,
      width: 105.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent
      ),
      child: Stack(
        children: [
          CustomButton(borderColor: borderColor,
            color: color,
            height: 53.h,fontSize: 14,
            onTap:onTap,title:label.tr() ,textColor: textColor??AppColors.black,),
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 7.w,right: 7.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 16.w,
                height: 16.h,
                child: buttonIconTitle!=null?CircleAvatar(
                  backgroundColor:AppColors.main ,
                  child: Center(
                    child: Text(
                      buttonIconTitle??'',
                      style: TextStyles()
                          .getRegularStyle(fontSize: 10.sp)
                          .customColor(AppColors.white),
                    ),
                  ),
                ):const SizedBox()
              ),
            ),
          ),
        ],
      ),
    );
  }
}
