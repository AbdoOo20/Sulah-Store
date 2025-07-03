import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';

import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/statistics_model.dart';

class CardTitleOrder extends StatelessWidget {
  const CardTitleOrder({Key? key, required this.statisticsModel}) : super(key: key);
final StatisticsModel? statisticsModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.white,
      shadowColor: AppColors.main10,
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.newOrders.tr(),
                  style: TextStyles()
                      .getRegularStyle(
                      fontSize: 12.sp)
                      .customColor(AppColors.black),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  statisticsModel?.data
                      ?.newOrderCount
                      .toString() ??
                      "",
                  style: TextStyles()
                      .getTitleStyle(
                      fontSize: 12.sp)
                      .customColor(AppColors.main),
                ),
                SizedBox(width: 4.w),
                (statisticsModel?.data
                    ?.newOrderCount !=
                    null)
                    ? Text(
                  LocaleKeys.Korder.tr(),
                  style: TextStyles()
                      .getRegularStyle(
                      fontSize: 12.sp)
                      .customColor(
                      AppColors.black),
                )
                    : const SizedBox(),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Text(
                  LocaleKeys.currentOrders.tr(),
                  style: TextStyles()
                      .getRegularStyle(
                      fontSize: 12.sp)
                      .customColor(AppColors.black),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  statisticsModel?.data
                      ?.currentOrderCount
                      .toString() ??
                      '',
                  style: TextStyles()
                      .getTitleStyle(
                      fontSize: 12.sp)
                      .customColor(AppColors.main),
                ),
                SizedBox(width: 4.w),
                (statisticsModel?.data
                    ?.currentOrderCount !=
                    null)
                    ? Text(
                  LocaleKeys.Korder.tr(),
                  style: TextStyles()
                      .getRegularStyle(
                      fontSize: 12.sp)
                      .customColor(
                      AppColors.black),
                )
                    : const SizedBox(),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Text(
                  LocaleKeys.completedOrders.tr(),
                  style: TextStyles()
                      .getRegularStyle(
                      fontSize: 12.sp)
                      .customColor(AppColors.black),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  statisticsModel?.data
                      ?.completeOrderCount
                      .toString() ??
                      '',
                  style: TextStyles()
                      .getTitleStyle(
                      fontSize: 12.sp)
                      .customColor(AppColors.main),
                ),
                SizedBox(width: 4.w),
                (statisticsModel?.data
                    ?.completeOrderCount !=
                    null)
                    ? Text(
                  LocaleKeys.Korder.tr(),
                  style: TextStyles()
                      .getRegularStyle(
                      fontSize: 12.sp)
                      .customColor(
                      AppColors.black),
                )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
