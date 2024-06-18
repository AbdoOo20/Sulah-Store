import 'package:khedmaty_store/core/app_loader.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/core/res/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/presentation/component/animation/list_animator.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/branchEarningsThisMonthChart.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/branchOrderThisMonthChart.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/branchProductsChart.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/cardTitleOrder.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/listOfBestSiller.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/offer%20card.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/orderCard.dart';
import 'package:khedmaty_store/presentation/screens/home/home_sereen/widgets/productsCard.dart';
import 'package:provider/provider.dart';
import '../../../../core/resources/resources.dart';
import '../../../../core/routing/route.dart';
import '../../../component/custom_scaffold.dart';
import '../../../component/screen_state_layout.dart';
import '../../../component/svg_icon.dart';
import '../offers/offer screen.dart';
import '../orders/orders.dart';
import '../products/products.dart';
import 'homeViewModel.dart';
import 'widgets/app_bar_home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = PageController(initialPage: 0);

  Future<void> _loadData(BuildContext context) async {
    await Provider.of<HomeViewModel>(context, listen: false)
        .getBestSeller(context);
    await Provider.of<HomeViewModel>(context, listen: false)
        .getStatistics(context);
  }

  @override
  void initState() {
    super.initState();
    _loadData(context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: Consumer<HomeViewModel>(
      builder: (context, data, child) => RefreshIndicator(
        onRefresh: () async => await _loadData(context),
        child: ScreenStateLayout(
          isLoading:
              data.statisticsModel == null || data.bestSellerModel == null,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              top: kScreenPaddingNormal.h,
              right: kScreenPaddingNormal.w,
              left: kScreenPaddingNormal.w,
              bottom: kScreenPaddingNormal.w,
            ),
            child: Column(children: [
              const AppBarHome(),
              Expanded(
                child: ListAnimator(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 132.h,
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        controller: PageController(
                            initialPage: 1, viewportFraction: 0.9),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: BranchOrdersThisMonthChart(
                              controller: controller,
                              statisticsModel: data.statisticsModel,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: BranchEarningsThisMonthChart(
                              controller: controller,
                              statisticsModel: data.statisticsModel,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            child: BranchProductsChart(
                              controller: controller,
                              statisticsModel: data.statisticsModel,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            push(const Orders());
                          },
                          child: Stack(
                            children: [
                              const OrderCard(),
                              Positioned(
                                top: 15,
                                left: 15,
                                child: (data.statisticsModel?.data
                                                ?.newOrderCount !=
                                            null &&
                                        data.statisticsModel?.data
                                                ?.newOrderCount !=
                                            0)
                                    ? Container(
                                        height: 25.h,
                                        width: 25.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          color: AppColors.main,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${data.statisticsModel?.data?.newOrderCount ?? ""}',
                                            style: TextStyles()
                                                .getRegularStyle(
                                                    fontSize: 13.sp)
                                                .customColor(AppColors.white),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              push(const MyOffers());
                            },
                            child: const OfferCard()),
                        GestureDetector(
                            onTap: () {
                              push(const Products());
                            },
                            child: const ProductsCard()),
                      ],
                    ),
                    SizedBox(
                        child: CardTitleOrder(
                          statisticsModel: data.statisticsModel,
                        )),
                    Row(
                      children: [
                        SVGIcon(
                          Assets.bestSiller,
                          width: (20.w),
                          height: (20.h),
                        ),
                        SizedBox(width: 5.h),
                        Text(
                          LocaleKeys.bestSeller.tr(),
                          style: TextStyles()
                              .getTitleStyle(fontSize: 18.sp)
                              .customColor(AppColors.black),
                        ),
                      ],
                    ),
                    ListOfBestSeller(
                        topSalesProduct: data.bestSellerModel?.data)
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
