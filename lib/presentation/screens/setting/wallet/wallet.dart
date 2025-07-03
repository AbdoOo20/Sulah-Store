import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/presentation/screens/setting/wallet/wallet_view_model.dart';
import 'package:sulah_store/presentation/screens/setting/wallet/widget/custom_cared_report.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../core/resources/locale_keys.g.dart';
import '../../../component/appbars/custom_app_bar.dart';
import '../../../component/screen_state_layout.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  void initState() {
    super.initState();
    _loadData(context);
  }

  Future<void> _loadData(BuildContext context) async {
    Provider.of<WalletViewModel>(context, listen: false).walletApi(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.wallet.tr(),
          color: AppColors.white,
          titleColor: AppColors.black,
        ),
        backgroundColor: AppColors.white,
        body: Consumer<WalletViewModel>(
            builder: (context, data, child) => RefreshIndicator(
                  onRefresh: () async => await _loadData(context),
                  child: ScreenStateLayout(
                      isLoading: data.walletModel == null,
                      isEmpty: data.walletModel?.data == null,
                      builder: (context) => Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            children: [
                              CustomCaredBalance(
                                  walletModel: data.walletModel),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 24.h, bottom: 16.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      LocaleKeys.balanceRecord.tr(),
                                      style: TextStyles()
                                          .getTitleStyle(fontSize: 14.sp)
                                          .customColor(AppColors.darkGray),
                                    ),
                                    Text(
                                      '${data.walletModel?.data?.wallet?.length ?? 0} ${LocaleKeys.orders1.tr()}',
                                      style: TextStyles()
                                          .getTitleStyle(fontSize: 14.sp)
                                          .customColor(AppColors.darkGray),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: data.walletModel?.data?.wallet?.length??0,
                                      itemBuilder: (context, index) {
                                        return CustomBodyCared(
                                          price: data.walletModel?.data
                                              ?.wallet?[index].total,
                                          id: data.walletModel?.data
                                              ?.wallet?[index].id,
                                          payment: data
                                                      .walletModel
                                                      ?.data
                                                      ?.wallet?[index]
                                                      .paymentMethod ==
                                                  'online' ? 'online'.tr():'cash'.tr(),
                                          date: data.walletModel?.data
                                              ?.wallet?[index].createdDate,
                                        );
                                      }))
                            ],
                          ))),
                )));
  }
}

class CustomBodyCared extends StatelessWidget {
  const CustomBodyCared({
    super.key,
    required this.id,
    required this.payment,
    required this.price,
    required this.date,
  });

  final int? id;
  final String? payment;
  final num? price;
  final String? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r), color: AppColors.redLight),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    //from api
                    '$price',
                    style: TextStyles()
                        .getTitleStyle(fontSize: 14.sp)
                        .customColor(AppColors.black),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'sar'.tr(),
                    style: TextStyles()
                        .getTitleStyle(fontSize: 11.sp)
                        .customColor(AppColors.black),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    //from api
                    date ?? '',
                    style: TextStyles()
                        .getRegularStyle(fontSize: 12.sp)
                        .customColor(AppColors.darkGray),
                  ),
                  SizedBox(width: 24.w),
                  Text(
                    '#$id',
                    style: TextStyles()
                        .getRegularStyle(fontSize: 12.sp)
                        .customColor(AppColors.darkGray),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Text(
              // '$payment payment'.tr(),
              payment ?? '',
              style: TextStyles().getTitleStyle(fontSize: 12.sp).customColor(
                  payment == 'cash' ? AppColors.black : AppColors.main),
            ),
          ),
        ],
      ),
    );
  }
}
