import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/app_colors.dart';
import 'package:sulah_store/core/resources/locale_keys.g.dart';
import 'package:sulah_store/presentation/component/component.dart';
import 'package:sulah_store/presentation/screens/setting/ratings/widget/rate_par.dart';
import 'package:provider/provider.dart';

import '../../../../core/res/text_styles.dart';
import 'rates_view_model.dart';

class Ratings extends StatefulWidget {
  const Ratings({Key? key}) : super(key: key);

  @override
  State<Ratings> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  @override
  void initState() {
    super.initState();
    _loadData(context);
  }

  Future<void> _loadData(BuildContext context) async {
    await Provider.of<RatesViewModel>(context, listen: false).getProductRates(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.ratings.tr(),
          color: Colors.white,
        ),
        body:RefreshIndicator(
        onRefresh: () async => await _loadData(context),
    child: Consumer<RatesViewModel>(
    builder: (context, rate, child) => ScreenStateLayout(
        isLoading:  rate.productRatesModel?.data==null,
        isEmpty:  rate.productRatesModel?.data?.isEmpty??true,
        builder: (context) =>Container(
          color: AppColors.white,
          child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              shrinkWrap: true,
              itemCount: rate.productRatesModel?.data?.length??0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(bottom:12.h),
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
                      borderRadius: BorderRadius
                          .circular(12.r),
                      color: AppColors.productScreenColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 72.h,
                            width: 72.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.grayLite),
                            child: CommonNetworkImage(
                              fit: BoxFit.fill,
                              imageUrl: rate.productRatesModel?.data?[index].users?.logo ?? '',
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                rate.productRatesModel?.data?[index].users?.name ?? '',
                                style: TextStyles()
                                    .getTitleStyle(fontSize: 14.sp)
                                    .customColor(AppColors.black),
                              ),
                              Text(
                                rate.productRatesModel?.data?[index].createdAt ?? '',
                                style: TextStyles()
                                    .getRegularStyle(fontSize: 12.sp)
                                    .customColor(AppColors.darkGray),
                              ),
                              RateWidget(
                                itemSize: 20,
                                iconSize: 16.r,
                                initialRating: rate.productRatesModel?.data?[index].rate ?? 0,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        rate.productRatesModel?.data?[index].comment ?? '',
                        style: TextStyles()
                            .getRegularStyle(fontSize: 14.sp)
                            .customColor(AppColors.black),
                      ),
                    ],
                  ),
                );
              }),
        )))));
  }
}
