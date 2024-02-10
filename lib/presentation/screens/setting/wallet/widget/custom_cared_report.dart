import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/wallet_model.dart';
import '../../../../component/svg_icon.dart';
import '../wallet_view_model.dart';

class CustomCaredBalance extends StatelessWidget {
  const CustomCaredBalance({super.key, required this.walletModel,});
final  WalletModel? walletModel;

  @override
  Widget build(BuildContext context) {
    bool isLoadingRequest = Provider.of<WalletViewModel>(context, listen: true).isLoadingRequest;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: EdgeInsets.all(16.h),
        width: 304.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SVGIcon(Assets.money),
                SizedBox(width: 8.w),
                Text(
                  LocaleKeys.totalBalance.tr(),
                  style:
                      TextStyles().getRegularStyle().customColor(Colors.black),
                )
              ],
            ),
            //take from api

            SizedBox(height: 16.h),

            Text(
              overflow: TextOverflow.ellipsis,
            // totalBalance,
              '${double.parse((walletModel?.data?.total??0).toString()).toPrecision(1)}' ,
              style: TextStyles()
                  .getTitleStyle(fontSize: 32.sp)
                  .customColor(AppColors.black),
              maxLines: 2,
              softWrap: false,
            ),
            SizedBox(height: 7.h),
            Text(
              LocaleKeys.rial.tr(),
              style: TextStyles()
                  .getRegularStyle(fontSize: 14.sp)
                  .customColor(AppColors.black),
            ),
            SizedBox(height: 20.h),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // Column(crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //   Text(
              //     LocaleKeys.profitsCanWithdrawn.tr(),
              //     style: TextStyles()
              //         .getRegularStyle(fontSize: 12.sp)
              //         .customColor(AppColors.black),
              //     maxLines: 1,
              //   ),
              //   Row(children: [
              //     Text(
              //       '${double.parse((walletModel?.data?.canWithdraw??0).toString()).toPrecision(1)}',
              //       style: TextStyles()
              //           .getTitleStyle(fontSize: 14.sp)
              //           .customColor(AppColors.main),
              //       maxLines: 1,
              //     ),SizedBox(width: 5.w,),
              //     Text(
              //       LocaleKeys.rial.tr(),
              //       style: TextStyles()
              //           .getRegularStyle(fontSize: 12.sp)
              //           .customColor(AppColors.black),
              //       maxLines: 1,
              //     ),
              //   ],)
              // ],),
              InkWell(
                onTap:isLoadingRequest?(){}: (){
                  Provider.of<WalletViewModel>(context, listen: false).walletRequest(context,walletModel?.data?.total??0);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 38.h,
                  width: 110.w,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r),border: Border.all(width: 1.w,color: AppColors.main),),
                  child: Center(
                    child:isLoadingRequest?SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(color: AppColors.main,strokeWidth:3)) :Text(
                      LocaleKeys.balanceWithdrawalRequest.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyles()
                          .getTitleStyle(fontSize: 12.sp)
                          .customColor(AppColors.main),
                      maxLines: 1,
                    ),
                  ),),
              )
            ],)
          ],
        ),
      ),
    );
  }
}
