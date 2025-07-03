import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/app_colors.dart';
import '../../svg_icon.dart';

class CustomTextFormFiledPassword extends StatefulWidget {
  final Widget? widget;
  final String? image;
  final String? hintText;
  final double? height;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? imageColor;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  const CustomTextFormFiledPassword({
    Key? key,
    this.widget,
     this.image,
    this.hintText,
    this.controller,
    this.textInputAction,
    this.textInputType,
    this.height,
    this.backGroundColor,
    this.borderColor,
    this.imageColor,
  }) : super(key: key);

  @override
  State<CustomTextFormFiledPassword> createState() =>
      _CustomTextFormFiledState();
}

class _CustomTextFormFiledState extends State<CustomTextFormFiledPassword> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height ?? 64,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp("^[\u0000-\u007F]+\$"))
                  ],
                  readOnly: widget.widget == null ? false : true,
                  autofocus: false,
                  obscureText: _showPassword,
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

                    // labelStyle: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(color: widget.isDark?AppColors.black:AppColors.black),
                    // suffixStyle: Theme.of(context).inputDecorationTheme.suffixStyle?.copyWith(color: widget.isDark?AppColors.black:AppColors.black),
                    filled: true,
                    fillColor: widget.backGroundColor /*disable background*/,
                    counterStyle: const TextStyle(color: AppColors.main),
                    // suffixText: widget.suffixText,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                    suffixIcon:widget.image==null?SizedBox(): SVGIcon(
                      widget.image??'',
                      //'assets/images/svg$image.svg',
                      width: (20),
                      height: (20),
                      color: widget.imageColor,
                    ),
                    hintText: widget.hintText?.tr(),
                    hintStyle: TextStyles()
                        .getRegularStyle(fontSize: 14)
                        .customColor(AppColors.black),
                    prefixIcon: IconButton(
                      icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.main),
                      onPressed: () {
                        _togglePasswordVisibility();
                      },
                    ),
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
          Container(
            child: widget.widget,
          ),
        ],
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
