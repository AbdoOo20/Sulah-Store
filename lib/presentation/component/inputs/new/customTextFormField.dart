import 'package:flutter/services.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/app_colors.dart';
import '../../svg_icon.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
bool isValidPassword(String email){
  return
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);
  }
}
class CustomTextFormFiled extends StatefulWidget {
  final Widget? widget;
  final void Function()? onTap;
  final bool? enabled;
  final String? image;
  final Color? imageColor;
  final String? icon;
  final String? hintText;
  final double? hintSize;
  final double? height;
  final double? radius;
  final Color? hintColor;
  final Color? backGroundColor;
  final Color? borderColor;
  final double? borderWidth;

  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  const CustomTextFormFiled({
    Key? key,
    this.widget,
    this.image,
    this.imageColor,
    this.hintText,
    this.controller,
    this.textInputAction,
    this.textInputType,
    this.height,
    this.backGroundColor,
    this.borderColor,
    this.borderWidth,
    this.icon,
    this.radius,
    this.hintSize,
    this.hintColor,
    this.onTap,
    this.enabled,
  }) : super(key: key);

  @override
  State<CustomTextFormFiled> createState() => _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiled> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343.w,
      height: widget.height ?? 67.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: widget.enabled,
                    onTap: widget.onTap,
                    readOnly: widget.widget == null ? false : true,
                    autofocus: false,
                    // inputFormatters:widget.textInputType==TextInputType.phone? [
                    //   FilteringTextInputFormatter.digitsOnly,
                    //   LengthLimitingTextInputFormatter(9),
                    //   FilteringTextInputFormatter.deny(RegExp('^0+'))
                    // ]:[],
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorderColor, width: 1),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorderColor, width: 1),
                      ),
                      // border: Theme.of(context).inputDecorationTheme.border,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorderColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorderColor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                            color: AppColors.textFieldBorderColor, width: 1),
                      ),

                      filled: true,
                      fillColor: widget.backGroundColor /*disable background*/,
                      counterStyle: const TextStyle(color: AppColors.main),
                      // suffixText: widget.suffixText,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                      // icon: widget.icon == null
                      //     ? SizedBox()
                      //     : SVGIcon(
                      //         widget.icon ?? '',
                      //         //'assets/images/svg$image.svg',
                      //         width: (20.w),
                      //         height: (20.h),
                      //       ),
                      suffixIcon: widget.image == null
                          ? SizedBox()
                          : SVGIcon(
                              widget.image ?? '',
                              //'assets/images/svg$image.svg',
                              width: (20.w),
                              height: (20.h),
                              color: widget.imageColor,
                            ),
                      hintText: widget.hintText??'5xxxxxxxx',
                      hintStyle: TextStyles()
                          .getRegularStyle(fontSize: widget.hintSize ?? 14.sp)
                          .customColor(widget.hintColor ?? AppColors.black),
                    ),
                    controller: widget.controller,
                    textInputAction: widget.textInputAction,
                    keyboardType: widget.textInputType ?? TextInputType.text,
                    cursorColor: AppColors.main,
                    style: const TextStyle(
                        letterSpacing: 0.5, fontSize: 18, color: AppColors.black),
                    validator: (value) {
                      return null;
                      },
                    onSaved: (newValue) {},
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: widget.widget,
          ),
        ],
      ),
    );
  }
}
