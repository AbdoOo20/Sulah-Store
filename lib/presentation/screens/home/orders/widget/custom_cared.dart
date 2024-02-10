import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/routing/route.dart';
import 'package:khedmaty_store/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../data/model/response/one_order_model.dart';
import '../../../../component/svg_icon.dart';

import '../orderDetails/orderDetails.dart';
import '../oreders_view_model.dart';

class CustomCared extends StatefulWidget {
  const CustomCared({
    super.key,
    required this.hasAcceptBut,
    this.data,
    required this.type,
  });

  final SingleOrder? data;
  final bool? hasAcceptBut;
  final String? type;

  @override
  State<CustomCared> createState() => _CustomCaredState();
}

class _CustomCaredState extends State<CustomCared> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color:(widget.type=='complete')? AppColors.grayLite:AppColors.textFieldColor,border: Border.all(width: 1.w,color: AppColors.grayLite)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SVGIcon(
                    Assets.id,
                    height: 20.h,
                    width: 20.w,
                    color: (widget.type=='new'||widget.type=='current')?AppColors.main:AppColors.darkGray,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '${widget.data?.id}' ?? '',
                    style: TextStyles()
                        .getTitleStyle(fontSize: 16.sp)
                        .customColor(AppColors.black),
                  ),
                ],
              ),

              InkWell(
                onTap: () {
                  push(OrderDetailsScreen(id:  widget.data?.id??-1,singleOrder: widget.data,isFromOrders: true,));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleKeys.details.tr(),
                      style:TextStyles()
                          .getRegularStyle(fontSize: 14.sp)
                          .customColor(AppColors.main)
                      // TextStyle(
                      //    decoration: TextDecoration.underline,
                      //   decorationStyle: TextDecorationStyle.solid,
                      //   decorationThickness: 2,
                      //   fontSize: 14.sp,
                      //   color: AppColors.main,
                      //   fontWeight: FontWeight.w400,
                      // ),
                    ),
                    SizedBox(width: 8.w),
                    SVGIcon(
                      Assets.line,
                      height: 20.h,
                      width: 20.w,
                     color: AppColors.main,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SVGIcon(
                    Assets.date,
                    height: 20.h,
                    width: 20.w,
                    color: (widget.type=='new'||widget.type=='current')?AppColors.main:AppColors.darkGray,
                  ),
                  SizedBox(width: 8.w),
                  Padding(
                    padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                    child: Text(
                      '${widget.data?.createdAt}',
                      style: TextStyles()
                          .getRegularStyle(fontSize: 14.sp)
                          .customColor(AppColors.darkGray),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SVGIcon(
                    Assets.person,
                    height: 20.h,
                    width: 20.w,
                    color: (widget.type=='new'||widget.type=='current')?AppColors.main:AppColors.darkGray,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.data?.user?.name?? '' ,
                    style: TextStyles()
                        .getRegularStyle(fontSize: 14.sp)
                        .customColor(AppColors.darkGray),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SVGIcon(
                    Assets.mobile,
                    height: 20.h,
                    width: 20.w,
                    color: (widget.type=='new'||widget.type=='current')?AppColors.main:AppColors.darkGray,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    widget.data?.user?.phone??'',
                    style: TextStyles()
                        .getRegularStyle(fontSize: 14.sp)
                        .customColor(AppColors.darkGray),
                  ),
                ],
              ),
            ],
          ),
          if (widget.hasAcceptBut == true)
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    isRounded: false,
                    width: 111.w,
                    height: 52,
                    color: AppColors.main10,
                    borderColor: AppColors.black,
                    textColor: AppColors.black,
                    onTap: () {
                      Provider.of<OrdersViewModel>(context, listen: false).actionForOrdersApi(context, "refused", widget.data?.id ?? -1);
                    },
                    title: LocaleKeys.refusal.tr(),
                  ),
                  CustomButton(
                    height: 52,
                    color: AppColors.main,
                    textColor: AppColors.white,
                    width: 188.w,//in:accepted,refused,on_progress,progress_done
                    onTap: () {
                      Provider.of<OrdersViewModel>(context, listen: false).actionForOrdersApi(context, "accepted", widget.data?.id ?? -1);
                    },
                    title: LocaleKeys.accept.tr(),
                  ),
                ],
              ),
            )
          else const SizedBox(),
        ],
      ),
    );
  }
}
