import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../../data/model/response/cars_model.dart';

///  model
class DropdownOption {
  List<CarModel>? data;

  DropdownOption({
    this.data,
  });

  factory DropdownOption.fromJson(Map<String, dynamic> json) => DropdownOption(
        data: json["data"] == null
            ? []
            : List<CarModel>.from(
                json["data"]!.map((x) => CarModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

/// CustomDropdownButton
class CustomDropdownButtonCar extends StatefulWidget {
  final List<CarModel> items;
  final String? value;
  final double? width;
  final Color? textColor;
  final Function(CarModel?) onChanged;

  CustomDropdownButtonCar({
    required this.items,
    required this.value,
    required this.onChanged,
    this.textColor,
    this.width,
  });

  @override
  _CustomDropdownButtonCarState createState() =>
      _CustomDropdownButtonCarState();
}

class _CustomDropdownButtonCarState extends State<CustomDropdownButtonCar> {
  @override
  CarModel? selectedCity;

  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<CarModel>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                widget.value ?? LocaleKeys.selectItem,
                style: TextStyles().getRegularStyle(fontSize: 12).customColor(
                    widget.textColor == null
                        ? AppColors.black
                        : widget.textColor!),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((CarModel item) => DropdownMenuItem<CarModel>(
                  value: item,
                  child: Text(
                    item.title ?? "",
                    style: TextStyles()
                        .getRegularStyle(fontSize: 14)
                        .customColor(AppColors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedCity,
        onChanged: widget.onChanged,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          iconSize: 14,
          iconEnabledColor: AppColors.black,
          iconDisabledColor: Colors.deepPurple,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200.h,
          width: widget.width ?? 300.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

/// example for hot to use
//
// DropdownItem? selectedCity;
//
// CustomDropdownButton(
// items: [DropdownItem(id: 1,title: 'الرياض'), DropdownItem(id: 22,title: 'المدينه')],
// value: selectedCity?.title ?? "Select Item",
// onChanged: (DropdownItem? newValue) {
// setState(() {
// selectedCity = newValue;
// });
// },)
