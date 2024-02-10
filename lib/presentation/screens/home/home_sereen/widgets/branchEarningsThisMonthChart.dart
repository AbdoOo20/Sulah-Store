import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/statistics_model.dart';
import '../../../../component/svg_icon.dart';

class BranchEarningsThisMonthChart extends StatefulWidget {
  const BranchEarningsThisMonthChart({Key? key, required this.controller, required this.statisticsModel}) : super(key: key);
  final PageController controller;
  final StatisticsModel? statisticsModel;
  @override
  State<BranchEarningsThisMonthChart> createState() => _EarningsThisMonthChartState();
}
class _EarningsThisMonthChartState extends State<BranchEarningsThisMonthChart> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(
            right: 12.h, left: 12.w,top:16.h),
        // height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: const Color(0xffCCCFFF)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        SVGIcon(
                          Assets.earningsThisMonth,
                          width: (25.w),
                          height: (25.h),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'earningsThisMonth'.tr(),
                          style: TextStyles()
                              .getDisplayMediumStyle(fontSize: 13.sp)
                              .customColor(AppColors.black),
                        ),
                      ]),
                  (widget.statisticsModel?.data?.differenceValue!=null)? Container(
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.all(Radius.circular(12.r)),
                      color : const Color.fromRGBO(113, 117, 174, 1),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('${widget.statisticsModel?.data?.differenceValue ?? 0}', textAlign: TextAlign.right,
                          style: TextStyles()
                              .getTitleStyle(fontSize: 12.sp)
                              .customColor(AppColors.white),),

                      ],
                    ),
                  ):const SizedBox()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w,right: 10.w),
              child: Row(
                  children: [
                    Text(
                      widget.statisticsModel?.data?.orderValues.toString() ?? '',
                      style: TextStyles()
                          .getTitleStyle(fontSize: 28.sp)
                          .customColor(AppColors.black),
                    ),
                    SizedBox(width: 8.w),
                     Text((widget.statisticsModel?.data?.orderValues!=null)?
                      LocaleKeys.rial.tr():'',
                      style: TextStyles()
                          .getRegularStyle(fontSize: 14.sp)
                          .customColor(AppColors.darkGray),
                    ),
                  ]),
            ),
          ],
        )
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);

  final String month;
  final double sales;
}