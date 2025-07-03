import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/values_manager.dart';
import '../component.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback _onTap;
  final Widget? _child;
  final String? _title;
  final Color? _color;
  final Color? borderColor;
  final Color? _textColor;
  final double? _width;
  final double? _height;
  final double? _fontSize;
  final double? _borderRadius;
  final bool _isRounded;
  final bool _isOutlined;
  final bool _widerPadding;
  final bool _loading;
  final Color? _loadingColor;

  const CustomButton({
    super.key,
    required VoidCallback onTap,
    Widget? child,
    String? title,
    Color? color,
    Color? loadingColor,
    Color? textColor,
    double? borderRadius,
    double? width,
    double? fontSize,
    double? height,
    bool isRounded = true,
    bool isOutlined = false,
    bool widerPadding = false,
    bool loading = false,
    this.borderColor,
  })  : _onTap = onTap,
        _child = child,
        _title = title,
        _color = color,
        _loadingColor = loadingColor,
        _textColor = textColor,
        _width = width,
        _fontSize = fontSize,
        _borderRadius = borderRadius,
        _height = height,
        _isRounded = isRounded,
        _isOutlined = isOutlined,
        _widerPadding = widerPadding,
        _loading = loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width ?? deviceWidth,
      height: (_height ?? 56).h,
      child: TapEffect(
        isClickable: !_loading,
        onClick: _loading ? null : _onTap,
        child: MaterialButton(
          height: _height,
          color: _isOutlined
              ? Colors.transparent
              : (_color ?? Theme.of(context).primaryColor),
          highlightElevation: 0,
          onPressed: _loading ? () {} : _onTap,
          padding: !_widerPadding
              ? EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w)
              : EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          elevation: 0,
          shape: _isRounded
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kFormRadiusSmall.r),
                  side: BorderSide(
                    color: borderColor ?? Colors.transparent,
                    width: 1.5.w,
                  ))
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_borderRadius ?? 10),
                  side: BorderSide(
                    color: borderColor ?? Theme.of(context).primaryColor,
                    width: 1.0.w,
                  ),
                ),
          child: _loading
              ? LoadingSpinner(
                  size: (_height != null ? _height! - 15 : 20).h,
                  color: _loadingColor ?? Theme.of(context).cardColor)
              : _title != null
                  ? Center(
                      child: Text(
                        _title!,
                        style: TextStyles()
                            .getTitleStyle(fontSize: _fontSize ?? 14)
                            .customColor(_textColor ?? Colors.white),
                      ),
                    )
                  : _child ?? const SizedBox(),
        ),
      ),
    );
  }
}
