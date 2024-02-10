import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/resources/locale_keys.g.dart';
import 'package:khedmaty_store/presentation/component/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../data/model/response/products_Model.dart';
import '../../../../../../injection.dart';
import '../../../../../component/inputs/new/customTextFormField.dart';
import '../../../../../component/svg_icon.dart';
import '../../products_view_model.dart';

class AddOffer extends StatefulWidget {
  const AddOffer({Key? key, this.productsModel, this.isEdite})
      : super(key: key);
  final OneProduct? productsModel;
  final bool? isEdite;

  @override
  State<AddOffer> createState() => _AddOfferState();
}

class _AddOfferState extends State<AddOffer> {
  ProductsViewModel productsViewModel = getIt();

  Future<void> _selectDate(BuildContext context,bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.main,
              ),
            ),
            child: child!,
          );},
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en');
      final String formattedDate = formatter.format(picked);

      setState(() {
        isStart? productsViewModel.startDateController.text = formattedDate :  productsViewModel.endDateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: AppColors.grayLite,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12.w,right: 12.w,top: 16.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    height: 48.h,
                    width: 157.w,
                    onTap: () => setState(() {
                      productsViewModel.typeOfferSelect = !productsViewModel.typeOfferSelect;
                    }),
                    borderColor: !productsViewModel.typeOfferSelect ? AppColors.main : AppColors.black,
                    title: LocaleKeys.value.tr(),
                    textColor: !productsViewModel.typeOfferSelect ? AppColors.white : AppColors.black,
                    color: !productsViewModel.typeOfferSelect ? AppColors.main : AppColors.white),
                CustomButton(
                    height: 48.h,
                    width: 157.w,
                    onTap: () => setState(() => productsViewModel.typeOfferSelect = !productsViewModel.typeOfferSelect),
                    title: LocaleKeys.rate.tr(),
                    borderColor: productsViewModel.typeOfferSelect ? AppColors.main : AppColors.black,
                    textColor: !productsViewModel.typeOfferSelect ? AppColors.black : AppColors.white,
                    color: productsViewModel.typeOfferSelect ? AppColors.main : AppColors.white),
              ],
            ),
        Padding(
          padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
          child: Column(
            children: [
              Container(
                height: 60.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormFiled(
                        height: 60.h,
                        hintText: "00",
                        textInputType: TextInputType.number,
                        backGroundColor: AppColors.white,
                        controller: productsViewModel.discountValueController,
                      ),
                    ),
                    Container(
                      width:51.w,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        color: AppColors.main,
                      ),
                      child: Center(
                          child: Text(productsViewModel.typeOfferSelect ? "%": LocaleKeys.rial.tr(),
                            style: TextStyles()
                                .getTitleStyle(fontSize: 14.sp)
                                .customColor(AppColors.white),
                          )
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h, right: 12.w, bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocaleKeys.startDate.tr(),
                      style: TextStyles()
                          .getDescriptionStyle(fontSize: 16.sp)
                          .customColor(AppColors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 70.w),
                      child: Text(
                        LocaleKeys.expiryDate.tr(),
                        style: TextStyles()
                            .getDescriptionStyle(fontSize: 16.sp)
                            .customColor(AppColors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _selectDate(context,true);
                    },
                    child: Container(
                     height: 45.h,
                      width: 151.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.white),
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0.r),
                        child: Row(
                          children: [
                            SVGIcon(
                              Assets.date,
                              color: Colors.grey,
                              width: (20.w),
                              height: (20.h),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              productsViewModel.startDateController.text.isEmpty?'selectDate'.tr():
                              productsViewModel.startDateController.text,
                              style: TextStyles()
                                  .getRegularStyle(fontSize: 14.sp)
                                  .customColor(AppColors.darkGray),
                            ),
                            // SizedBox(
                            //   width: 120.w,
                            // //  height: 57.h,
                            //   child: Center(
                            //     child: TextField(
                            //       controller: productsViewModel.startDateController,
                            //       readOnly: true,
                            //
                            //       decoration: InputDecoration(
                            //         disabledBorder: InputBorder.none,
                            //         focusedBorder: InputBorder.none,
                            //         border: InputBorder.none,
                            //         hintText: 'selectDate'.tr(),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context,false);
                    },
                    child: Container(
                     height: 45.h,
                      width: 151.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.white),
                      child: Padding(
                        padding:  EdgeInsets.only(right: 8.0.w),
                        child: Row(
                          children: [
                            SVGIcon(
                              Assets.date,
                              color: Colors.grey,
                              width: (20.w),
                              height: (20.h),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                                productsViewModel.endDateController.text.isEmpty?'selectDate'.tr():
                                productsViewModel.endDateController.text,
                              style: TextStyles()
                                  .getRegularStyle(fontSize: 14.sp)
                                  .customColor(AppColors.darkGray),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
          ],
        ),
      ),
    );
  }
}
