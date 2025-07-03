import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/helper/socialMediaHelper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/resources/resources.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../data/model/response/one_order_model.dart';
import '../../../../../component/svg_icon.dart';

class CustomCaredTittle extends StatelessWidget {
  const CustomCaredTittle({
    super.key,
    required this.data,
  });

  final OneOrderModel? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: AppColors.main05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SVGIcon(
                Assets.id,
                height: 20.h,
                width: 20.w,
                color: AppColors.main,
              ),
              SizedBox(width: 8.w),
              Text(
                '#${data?.data?.id ?? ''}',
                style: TextStyles()
                    .getTitleStyle(fontSize: 18.sp)
                    .customColor(AppColors.main),
              ),
            ],
          ),
          Row(
            children: [
              SVGIcon(
                Assets.date,
                height: 20.h,
                width: 20.w,
                color: AppColors.main,
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.orderTime.tr(),
                      style: TextStyles()
                          .getRegularStyle(fontSize: 12.sp)
                          .customColor(AppColors.darkGray),
                    ),
                    Text(
                      data?.data?.createdAt ?? '',
                      style: TextStyles()
                          .getRegularStyle(fontSize: 14.sp)
                          .customColor(AppColors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: InkWell(
              onTap: () {
                double lat = 0.0;
                double lang = 0.0;
                lat = double.parse(
                    data?.data?.latitude.toString() ?? "0.0");
                lang = double.parse(
                    data?.data?.longitude.toString() ?? "0.0");
                SocialMediaHelper().openGoogleMap(lat, lang);
              },
              child: Row(children: [
                SVGIcon(
                  Assets.locationIcon,
                  height: 20.h,
                  width: 20.w,
                  color: AppColors.main,
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'deliveryAddress'.tr(),
                      style: TextStyles()
                          .getRegularStyle(fontSize: 12.sp)
                          .customColor(AppColors.darkGray),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(data?.data?.address ?? '',
                          style: TextStyles()
                              .getRegularStyle(fontSize: 14.sp)
                              .customColor(AppColors.black),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SVGIcon(
                      Assets.walletIcon,
                      height: 20.h,
                      width: 20.w,
                      color: AppColors.main,
                    ),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'paymentMethod'.tr(),
                          style: TextStyles()
                              .getRegularStyle(fontSize: 12.sp)
                              .customColor(AppColors.darkGray),
                        ),
                        Text(
                          data?.data?.paymentMethod ?? '',
                          style: TextStyles()
                              .getRegularStyle(fontSize: 14.sp)
                              .customColor(AppColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              SVGIcon(
                Assets.comments,
                height: 20.h,
                width: 20.w,
                color: AppColors.main,
              ),
              SizedBox(width: 8.w),
              Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.comments.tr(),
                      style: TextStyles()
                          .getRegularStyle(fontSize: 12.sp)
                          .customColor(AppColors.darkGray),
                    ),
                    SizedBox(
                      height: 30.h,
                      width: 270.w,
                      child: Text(
                        data?.data?.notes ?? 'notes'.tr(),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles()
                            .getRegularStyle(fontSize: 14.sp)
                            .customColor(AppColors.black),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
