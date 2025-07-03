import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';

import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../component/svg_icon.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({Key? key, this.height, required this.hint, required this.sectionItem, required this.icon}) : super(key: key);
  final double? height;
  final String hint ;
  final String icon ;
final List<String> sectionItem;
  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String? dropdownValue ;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(right: kScreenPaddingNormal.w, left: kScreenPaddingNormal.w),
      height: widget.height ?? 64.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.grayTextField, width: .1),
          color: AppColors.main10),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
height: widget.height??64.h,
          // alignedDropdown: true,
          child: DropdownButton<String>(
            isExpanded: true,

             value: dropdownValue,
            style: TextStyles()
                .getRegularStyle(fontSize: 14.sp)
                .customColor(AppColors.black),
          hint: Text(
              // Localization.local(widget.hint),
             widget.hint.tr(),
              style: TextStyles()
                  .getRegularStyle(fontSize: 14.sp)
                  .customColor(AppColors.black),
            ),
            borderRadius: BorderRadius.circular(12.r),
            icon: Row(
              children: [
                SVGIcon(
                  Assets.arrows,
                  height: 3.5.h,
                  width: 7.w,
                ),SizedBox(width: 16.w),
                SVGIcon(

                  widget.icon,
                  height: 20.h,
                  width: 20.w,
                ),

              ],
            ),
            items:
                widget.sectionItem.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                onTap: () {
                  setState(() {});
                },
                value: value,
                child: Text(
                  value,
                  style: TextStyles()
                      .getRegularStyle(fontSize: 14.sp)
                      .customColor(AppColors.black),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
        ),
      ),
    );
  }
}
