import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/res/text_styles.dart';
import '../../../../core/resources/resources.dart';
import 'oreders_view_model.dart';
import 'widget/custom_botton.dart';
import 'widget/custom_list_view.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  _loadData(BuildContext context) async {
    await Provider.of<OrdersViewModel>(context, listen: false).getOrdersApi(context);
  }

  @override
  void initState() {
    Provider.of<OrdersViewModel>(context, listen: false).type='new';
    _loadData(context);
    super.initState();
  }

  final Color colorMain10 = AppColors.textFieldColor;

  final Color colorMain = AppColors.main;
  final controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        appBar: CustomAppBar(
          titleWidget: Text(
            LocaleKeys.orders.tr(),
            style: TextStyles()
                .getTitleStyle(fontSize: 16.sp)
                .customColor(AppColors.black),
          ),
          color: Colors.transparent,
        ),
        body: Consumer<OrdersViewModel>(builder: (context, ordersData, child) {
          return RefreshIndicator(
            onRefresh: () async => await _loadData(context),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(right: 16.w, left: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomOrdersButton(
                      buttonIconTitle: ordersData.ordersModel?.data?.length.toString()??'0',
                      onTap: () async {
                        setState(() {
                          ordersData.indexOrderTaped = 0;
                          Provider.of<OrdersViewModel>(context, listen: false).type = 'new';
                        });
                        controller.animateToPage(ordersData.indexOrderTaped,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut);
                        _loadData(context);
                      },
                      textColor: ordersData.indexOrderTaped == 0
                          ? AppColors.white
                          : AppColors.black,
                      color: ordersData.indexOrderTaped == 0
                          ? colorMain
                          : colorMain10,
                      label: 'new'.tr(),
                      borderColor: ordersData.indexOrderTaped == 0
                          ? colorMain
                          : AppColors.grayLite,
                    ),
                    CustomOrdersButton(
                      onTap: () async {
                        setState(() {
                          ordersData.indexOrderTaped = 1;
                          Provider.of<OrdersViewModel>(context, listen: false).type = 'current';
                        });
                        controller.animateToPage(ordersData.indexOrderTaped,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut);
                        _loadData(context);
                      },
                      label: 'present'.tr(),
                      // width: 108.67.w,
                      textColor: ordersData.indexOrderTaped == 1
                          ? AppColors.white
                          : AppColors.black,
                      color: ordersData.indexOrderTaped == 1
                          ? colorMain
                          : colorMain10,
                      borderColor: ordersData.indexOrderTaped == 1
                          ? colorMain
                          : AppColors.grayLite,
                    ),
                    CustomOrdersButton(
                      onTap: () async {
                        setState(() {
                          ordersData.indexOrderTaped = 2;
                          Provider.of<OrdersViewModel>(context, listen: false).type = 'complete';
                        });
                        controller.animateToPage(ordersData.indexOrderTaped,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut);
                        _loadData(context);
                      },
                      label: 'completed'.tr(),
                      // width: 108.67.w,
                      textColor: ordersData.indexOrderTaped == 2
                          ? AppColors.white
                          : AppColors.black,
                      color: ordersData.indexOrderTaped == 2
                          ? colorMain
                          : colorMain10,
                      borderColor: ordersData.indexOrderTaped == 2
                          ? colorMain
                          : AppColors.grayLite,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ScreenStateLayout(
                    isLoading:  ordersData.ordersModel?.data==null,
                      isEmpty:  ordersData.ordersModel?.data?.isEmpty??true,
                      builder: (context) =>Padding(
                          padding: EdgeInsets.only(right: 16.w, left: 16.w),
                          child: CustomListView(
                            ordersModel: ordersData.ordersModel,
                            type: 'new',
                          ),
                        )),
                      ScreenStateLayout(
                      isLoading:  ordersData.ordersModel?.data==null,
                      isEmpty:  ordersData.ordersModel?.data?.isEmpty??true,
                      builder: (context) =>Padding(
                      padding: EdgeInsets.only(right: 16.w, left: 16.w),
                      child: CustomListView(
                        ordersModel: ordersData.ordersModel,
                        type: 'current',
                      ),
                    )),
                      ScreenStateLayout(
                      isLoading:  ordersData.ordersModel?.data==null,
                      isEmpty:  ordersData.ordersModel?.data?.isEmpty??true,
                      builder: (context) =>Padding(
                          padding: EdgeInsets.only(
                              right: 16.w, left: 16.w),
                          child: CustomListView(
                            ordersModel: ordersData.ordersModel,
                            type: 'complete',
                          ),
                        ))
                  ],
                ),
              ),
            ]),
          );
        }));
  }
}
