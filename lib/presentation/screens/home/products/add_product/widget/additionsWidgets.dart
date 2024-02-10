import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../../data/model/body/compatible_with_body.dart';
import '../../../../../../data/model/response/products_Model.dart';
import '../../../../../component/new/custom_dropdown_button.dart';
import '../../../../../component/svg_icon.dart';
import '../screen/compatible_with_provider.dart';

class AdditionsWidget extends StatefulWidget {
  const AdditionsWidget({Key? key, this.oneProduct, required this.isEdite})
      : super(key: key);
  final OneProduct? oneProduct;
  final bool isEdite;

  @override
  State<AdditionsWidget> createState() => _AdditionsWidgetState();
}

class _AdditionsWidgetState extends State<AdditionsWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompatibleWithViewModel>(
        builder: (context, addProduct, child) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.main05,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0.h),
                        child: SVGIcon(
                          Assets.store,
                          width: (20.w),
                          height: (20.h),
                          color: AppColors.main,
                        ),
                      ),
                      Text(
                        LocaleKeys.compatibleWith.tr(),
                        style: TextStyles()
                            .getTitleStyle(fontSize: 14.sp)
                            .customColor(AppColors.black),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                      CompatibleWithBody body = CompatibleWithBody();
                      body.car = addProduct.selectedCars?.title;
                      body.carId = addProduct.selectedCars?.id.toString();
                      body.brandId = addProduct.selectedBrands?.id.toString();
                      body.brand = addProduct.selectedBrands?.title;
                      body.manufactureYear = "2023";
                      Provider.of<CompatibleWithViewModel>(context,
                              listen: false)
                          .addAddition(body);
                    },
                    child: SVGIcon(
                      Assets.add,
                      width: (29.w),
                      height: (29.h),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: (((addProduct.compatibleWithBody.length ?? 0) * 170)).h,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: addProduct.compatibleWithBody.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 12.h, right: 6.w, left: 6.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 266.w,
                                          child: Container(
                                              height: 64.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                      width: 1.w,
                                                      color:
                                                          AppColors.grayLite)),
                                              child: CustomDropdownButton(
                                                width: 240.w,
                                                items: addProduct.brands,
                                                value: addProduct
                                                        .compatibleWithBody[
                                                            index]
                                                        ?.brand ??
                                                    LocaleKeys.company.tr(),
                                                onChanged:
                                                    (DropdownItem? newValue) {
                                                  setState(() {
                                                    addProduct
                                                            .compatibleWithBody[
                                                                index]
                                                            ?.brand =
                                                        newValue?.title;
                                                    addProduct
                                                            .compatibleWithBody[
                                                                index]
                                                            ?.brandId =
                                                        newValue?.id.toString();
                                                    // Provider.of<FilterViewModel>(context, listen: false).cateId=data.selectedCategory?.id;
                                                    // Provider.of<FilterViewModel>(context, listen: false).products(context);
                                                  });
                                                },
                                              ))),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.delete_forever_outlined),
                                        onPressed: () => _removecart(
                                            context,
                                            widget
                                                    .oneProduct
                                                    ?.productsAdditions?[index]
                                                    .id ??
                                                -1,
                                            index),
                                        // onPressed: () => addProduct.removeAdditionController(index),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 12.h,
                                      top: 12.h,
                                      right: 6.w,
                                      left: 6.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 152.w,
                                          child: Container(
                                              height: 64.h,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                      width: 1.w,
                                                      color:
                                                          AppColors.grayLite)),
                                              child: CustomDropdownButton(
                                                width: 300.w,
                                                items: addProduct.cars,
                                                value: addProduct
                                                        .compatibleWithBody[
                                                            index]
                                                        .car ??
                                                    LocaleKeys.car.tr(),
                                                onChanged:
                                                    (DropdownItem? newValue) {
                                                  setState(() {
                                                    addProduct
                                                        .compatibleWithBody?[
                                                            index]
                                                        .car = newValue?.title;
                                                    addProduct
                                                            .compatibleWithBody?[
                                                                index]
                                                            .carId =
                                                        newValue?.id.toString();
                                                    // addProduct.compatibleWithBody?[index].car = newValue?.title;
                                                    // addProduct.compatibleWithBody?[index].car = '${newValue?.id??''}';
                                                    // Provider.of<FilterViewModel>(context, listen: false).cateId=data.selectedCategory?.id;
                                                    // Provider.of<FilterViewModel>(context, listen: false).products(context);
                                                  });
                                                },
                                              ))),
                                      SizedBox(width: 12.w),
                                      GestureDetector(
                                        onTap: () {
                                          _selectYear(context, 1);
                                        },
                                        child: Container(
                                          height: 64.h,
                                          width: 152.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              color: AppColors.white,
                                              border: Border.all(
                                                  width: 1.w,
                                                  color: AppColors.grayLite)),
                                          child: Center(
                                            child: Text(
                                              addProduct
                                                      .compatibleWithBody?[index]
                                                      .manufactureYear ??
                                                  LocaleKeys.model.tr(),
                                              style: TextStyles()
                                                  .getRegularStyle(
                                                      fontSize: 14.sp)
                                                  .customColor(AppColors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void _removecart(context, int productId, int index) async {
    Provider.of<CompatibleWithViewModel>(context, listen: false)
        .removeAddition(index);
    // await Provider.of<ProductsViewModel>(context, listen: false)
    //     .removeItemAndImage(context, productId, 'product_items')
    //     .then((value) => value.response == null
    //         ? null
    //         : Provider.of<CompatibleWith>(context, listen: false)
    //             .removeAddition(index));
  }

  Future<void>_selectYear(BuildContext context,int index) async {
    DateTime? _selectedDate;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.model.tr()),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 120),
              lastDate: DateTime(DateTime.now().year ),
              // initialDate: _selectedDate,
              // save the selected date to _selectedDate DateTime variable.
              // It's used to set the previous selected date when
              // re-showing the dialog.
              selectedDate: _selectedDate!,
              onChanged: (DateTime dateTime) {
                _selectedDate=dateTime;
                // close the dialog when year is selected.
                Navigator.pop(context);
                final DateFormat formatter = DateFormat('yyyy', 'en');
                final String formattedDate = formatter.format(dateTime);
                Provider.of<CompatibleWithViewModel>(context, listen: false)
                    .compatibleWithBody?[index]
                    .manufactureYear = formattedDate;
                setState(() {});

                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.year,
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.main,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat('yyyy', 'en');
      final String formattedDate = formatter.format(picked);
      Provider.of<CompatibleWithViewModel>(context, listen: false)
          .compatibleWithBody?[index]
          .manufactureYear = formattedDate;
      setState(() {});
    }
  }
}
