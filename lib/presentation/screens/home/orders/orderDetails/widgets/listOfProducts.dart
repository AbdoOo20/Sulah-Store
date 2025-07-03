import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import '../../../../../../../core/res/text_styles.dart';
import '../../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../../data/model/response/one_order_model.dart';
import '../../../../../component/mySeparator.dart';

class ListProducts extends StatelessWidget {
  const ListProducts({Key? key, this.data}) : super(key: key);
  final OneOrderModel? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8.h, bottom: 8.h, left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r), color: AppColors.grayLite,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.products.tr(),
            style: TextStyles().getTitleStyle(
              fontSize: 12.sp,
            ).customColor(AppColors.text),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          ConstrainedBox(
              constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.width, minHeight: 56.0.h),
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data?.data?.orderDetails?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 56.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  data?.data?.orderDetails?[index].product?.title??'',
                                  style: TextStyles().getTitleStyle(
                                    fontSize: 12.sp,
                                  ).customColor(AppColors.black),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'x',
                                    style: TextStyles().getRegularStyle(fontSize: 12.sp,).customColor(AppColors.text),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    '${data?.data?.orderDetails?[index].amount}',
                                    style: TextStyles().getTitleStyle(fontSize: 14.sp,).customColor(AppColors.text),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    data?.data?.orderDetails?[index].totalPrice.toString()??'',
                                    style: TextStyles().getTitleStyle(
                                      fontSize: 16.sp,
                                    ).customColor(AppColors.black),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    LocaleKeys.sar.tr(),
                                    style: TextStyles().getTitleStyle(
                                      fontSize: 12.sp,
                                    ).customColor(AppColors.text),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const MySeparator(
                          height: .2,
                          color: AppColors.green,
                        ),
                      ],
                    );
                  })
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: 200.w,
                  child: Text(
                   LocaleKeys.theTotal.tr(),
                    style: TextStyles().getTitleStyle(
                      fontSize: 12.sp,
                    ).customColor(AppColors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
              ),
              Row(
                children: [
                  Text(
                    data?.data?.total.toString()??'',
                    style: TextStyles().getTitleStyle(
                      fontSize: 16.sp,
                    ).customColor(AppColors.main),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    LocaleKeys.sar.tr(),
                    style: TextStyles().getTitleStyle(
                      fontSize: 12.sp,
                    ).customColor(AppColors.main),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
