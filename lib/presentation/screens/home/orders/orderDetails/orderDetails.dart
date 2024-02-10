import 'package:khedmaty_store/core/app_loader.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/component/component.dart';
import 'package:khedmaty_store/presentation/screens/home/orders/orderDetails/widgets/caredTittle.dart';
import 'package:khedmaty_store/presentation/screens/home/orders/orderDetails/widgets/listOfProducts.dart';
import 'package:khedmaty_store/presentation/screens/home/orders/orderDetails/widgets/stateBare.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/one_order_model.dart';
import '../oreders_view_model.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key, this.id, this.singleOrder, required this.isFromOrders}) : super(key: key);
  final bool? isFromOrders;
  final int? id;
  final SingleOrder? singleOrder;
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  _getOneOrders(BuildContext context) async {
    Provider.of<OrdersViewModel>(context, listen: false).getOneOrdersApi(context, orderId: widget.id);
  }

  @override
  void initState() {
    _getOneOrders(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isAcceptLoading = context.watch<OrdersViewModel>().isAcceptLoading;
    bool isRefuseLoading = context.watch<OrdersViewModel>().isRefuseLoading;
    bool isLoading = context.watch<OrdersViewModel>().isLoading;
    return CustomScaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.orderDetails.tr(),
        color: Colors.transparent,
      ),
      body:Consumer<OrdersViewModel>(builder: (context, data, child) {
        return RefreshIndicator(onRefresh: () async => await _getOneOrders(context),
        child:ScreenStateLayout(
        isLoading: data.oneOrderModel == null,
        isEmpty: data.oneOrderModel?.data==null,
        builder: (context) => Padding(
                padding: EdgeInsets.only(
                    left: 16.w, right: 16.w, top: 12.h, bottom: 12.h),
                child: ListAnimator(
                  children: [
                    CustomCaredTittle(
                      data:  data.oneOrderModel
                  ),
                    ListProducts(
                      data: data.oneOrderModel
                    ),

                    data.oneOrderModel?.data?.status == "new"
                        ? Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                  isRounded: false,
                                  width: 111.w,
                                  color: AppColors.white,
                                  borderColor: AppColors.main,
                                  textColor: AppColors.black,
                                  loading: isRefuseLoading,
                                  loadingColor: AppColors.black,
                                  onTap: () {
                                    data.actionForOrdersApi(context, "refuse", data.oneOrderModel?.data?.id ?? -1);
                                  },
                                  title: LocaleKeys.refusal.tr(),
                                ),
                                CustomButton(
                                  color: AppColors.main,
                                  textColor: AppColors.white,
                                  width: 216.w,
                                  loading: isAcceptLoading,
                                  onTap: () {
                                    data.actionForOrdersApi(context, "accept", data.oneOrderModel?.data?.id ?? -1);
                                  },
                                  title: LocaleKeys.accept.tr(),
                                ),
                              ],
                            ),
                          )
                        :
                    isLoading?AppLoader(height: 39.h):GestureDetector(
                      onTap: () {
                        if (data.oneOrderModel?.data?.status != 'refuse') {
                          data.oneOrderModel?.data?.status == "accept"
                            ? Provider.of<OrdersViewModel>(context, listen: false).actionForOrdersApi(context, "do_shipping", data.oneOrderModel?.data?.id ?? -1)
                            :data.oneOrderModel?.data?.status == "do_shipping"
                            ? Provider.of<OrdersViewModel>(context, listen: false).actionForOrdersApi(context, "end_shipping", data.oneOrderModel?.data?.id ?? -1)
                            : data.oneOrderModel?.data?.status == "end_shipping"
                            ? Provider.of<OrdersViewModel>(context, listen: false).actionForOrdersApi(context, "ended", data.oneOrderModel?.data?.id ?? -1) : -1; }
                      },
                      child: CustomStateBare(
                        totalState: '4',
                        state: data.oneOrderModel?.data?.status == "accept" ? '2'
                             : data.oneOrderModel?.data?.status == "do_shipping" ? "4"
                             : data.oneOrderModel?.data?.status == "end_shipping" ? "6"
                             : data.oneOrderModel?.data?.status == "ended" ? "8"
                             : "8",
                        title: data.oneOrderModel?.data?.status == "accept" ? LocaleKeys.approved.tr() :
                        data.oneOrderModel?.data?.status == "do_shipping" ? LocaleKeys.chargingProgress.tr() :
                        data.oneOrderModel?.data?.status == "end_shipping" ? LocaleKeys.shippingDone.tr():
                        data.oneOrderModel?.data?.status == "ended" ? LocaleKeys.requestCompleted.tr() :
                        data.oneOrderModel?.data?.status == "refuse" ? LocaleKeys.requestRejected.tr() :
                        LocaleKeys.requestCompleted.tr(), ),
                    )
                  ],
                ),
              ),
        ),
        );
      })
    );
  }
}
