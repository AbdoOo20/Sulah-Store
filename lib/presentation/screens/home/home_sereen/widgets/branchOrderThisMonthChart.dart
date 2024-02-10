import 'package:easy_localization/easy_localization.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/statistics_model.dart';
import '../../../../component/svg_icon.dart';

class BranchOrdersThisMonthChart extends StatefulWidget {
  const BranchOrdersThisMonthChart(
      {Key? key, required this.controller, required this.statisticsModel})
      : super(key: key);
  final PageController controller;
  final StatisticsModel? statisticsModel;

  @override
  State<BranchOrdersThisMonthChart> createState() => _FinancialChartState();
}

class _FinancialChartState extends State<BranchOrdersThisMonthChart> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 12.h, right: 12.w,top: 16.h),
        //height: 810.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: const Color(0xffFFEAB8)),
        child: Column(
          mainAxisSize:  MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.all(8.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        SVGIcon(
                          Assets.dateMonth,
                          width: (25.w),
                          height: (25.h),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'ordersThisMonth'.tr(),
                          style: TextStyles()
                              .getDisplayMediumStyle(fontSize: 13.sp)
                              .customColor(AppColors.black),
                        ),
                      ]),
                  (widget.statisticsModel?.data?.difference!=null)? Container(
                    decoration: BoxDecoration(
                      borderRadius : BorderRadius.all(Radius.circular(12.r)),
                      color : Color(0xffCEA135),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(widget.statisticsModel?.data?.difference??'0', textAlign: TextAlign.right,
                          style: TextStyles()
                              .getTitleStyle(fontSize: 12.sp)
                              .customColor(AppColors.white),),

                      ],
                    ),
                  ):SizedBox()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w,right: 10.w),
              child: Row(
                  children: [
                    Text(
                      widget.statisticsModel?.data?.orderCount.toString() ??'',
                      style: TextStyles()
                          .getTitleStyle(fontSize: 28.sp)
                          .customColor(AppColors.black),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      (widget.statisticsModel?.data?.orderCount!=null)?LocaleKeys.Korder.tr():'',
                      style: TextStyles()
                          .getRegularStyle(fontSize: 14.sp)
                          .customColor(AppColors.darkGray),
                    ),
                  ]),
            ),
            // SizedBox(height: 13.h),
            // SizedBox(
            //   height: 100.h,
            //   child:Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child:
            //     Consumer<HomeViewModel>(builder: (context, listData, child) {
            //       return
            //       SfSparkLineChart.custom(color: Colors.black45,axisLineColor: Colors.black12,
            //       axisLineWidth: .8.w,width: 3,
            //       trackball: SparkChartTrackball(color: AppColors.black,
            //           activationMode: SparkChartActivationMode.tap),
            //       labelDisplayMode: SparkChartLabelDisplayMode.none,
            //       xValueMapper: (int index) => listData.data[index].year,
            //       yValueMapper: (int index) => listData.data[index].sales,
            //       dataCount: listData.data.length,
            //     );})
            //   )
            // )
          ],
        ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
