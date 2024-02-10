import 'package:cached_network_image/cached_network_image.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/statistics_model.dart';
import '../../../../component/svg_icon.dart';

class BranchProductsChart extends StatefulWidget {
  const BranchProductsChart(
      {Key? key, required this.controller, required this.statisticsModel})
      : super(key: key);
  final PageController controller;
  final StatisticsModel? statisticsModel;

  @override
  State<BranchProductsChart> createState() => _FinancialChartState();
}

class _FinancialChartState extends State<BranchProductsChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
       // height: 200.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            color: const Color(0xffD2E4BF)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: [
                        SVGIcon(
                          Assets.productsCard,
                          width: (25.w),
                          height: (25.h),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          LocaleKeys.products.tr(),
                          style: TextStyles()
                              .getDisplayMediumStyle(fontSize: 13.sp)
                              .customColor(AppColors.black),
                        ),
                      ]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Row(
                  children: [
                    Text(
                      (widget.statisticsModel?.data?.productCount!=null)? '${widget.statisticsModel?.data?.productCount}':'',
                      style: TextStyles()
                          .getTitleStyle(fontSize: 28.sp)
                          .customColor(AppColors.black),
                    ),
                    SizedBox(width: 8.w),
                    (widget.statisticsModel?.data?.productCount !=0)?Text(
                      (widget.statisticsModel?.data?.productCount!=null)? LocaleKeys.project.tr():'',
                      style: TextStyles()
                          .getRegularStyle(fontSize: 14.sp)
                          .customColor(AppColors.darkGray),
                    ):SizedBox(),
                  ]),
            ),
            // SizedBox(height: 16.h),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10,right: 10),
            //   child: Text(
            //     LocaleKeys.bestSeller.tr(),
            //     style: TextStyles()
            //         .getRegularStyle(fontSize: 14.sp)
            //         .customColor(AppColors.black),
            //   ),
            // ),
            // SizedBox(height: 12.h),
            // SizedBox(height: 50.h,
            //   child: ListView.builder(
            //   scrollDirection: Axis.horizontal,
            //   itemCount:widget.branchData?.topSalesProducts?.length,
            //   itemBuilder: (context, index) {return
            //     Container(margin: EdgeInsets.symmetric(horizontal: 4.w),
            //     padding: EdgeInsets.all( 9.w),
            //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r),color:Colors.white30),
            //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         SizedBox(width:30,height: 30,
            //           child: ClipRRect(
            //             borderRadius:
            //             BorderRadius.circular(36.r),
            //             child: CachedNetworkImage(
            //               fit: BoxFit.fill,
            //               imageUrl: widget.branchData?.topSalesProducts?[index].image ??"",
            //               errorWidget: (context, url, error) =>
            //                   SVGIcon(
            //                     Assets.productsCard,
            //                     height: 36.h,
            //                     width: 36.w,
            //                   ),
            //             ),
            //           ),
            //         ),
            //         SizedBox(width: 8.w,),
            //         Text(
            //           widget.branchData?.topSalesProducts?[index].title ??'',
            //           style: TextStyles()
            //               .getRegularStyle(fontSize: 12.sp)
            //               .customColor(AppColors.black),
            //           overflow: TextOverflow.fade,
            //         ),],),);}),
           // )
          ],
        ));
  }
}
