import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/app_assets.dart';
import 'package:sulah_store/core/resources/app_colors.dart';
import 'package:sulah_store/presentation/component/svg_icon.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/font_manager.dart';
import '../custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double textSize;
  final FontWeight fontWeight;
  final Color? textColor;

  const CustomTextButton({
    this.onPressed,
    required this.text,
    this.textColor,
    this.fontWeight = FontWeightManager.bold,
    this.textSize = FontSize.s16,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 48.h,
        width: 162.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkGray),
          borderRadius: BorderRadius.circular(12.sp)
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SVGIcon(Assets.logOut),
              SizedBox(width: 12.w),
              CustomText(
                text,
                color: textColor ??  Theme.of(context).primaryColor,
                fontSize: textSize.sp,
                fontWeight: fontWeight,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
