import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:khedmaty_store/presentation/screens/home/offers/widgets/offer%20dialog.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_assets.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../../core/routing/route.dart';
import '../../../../component/svg_icon.dart';
import '../offer view model.dart';
import '../pay_web_view/pay_web_view.dart';

class OfferItem extends StatefulWidget {
  ProductOffer product;
  bool isOffer;

  OfferItem(this.product, this.isOffer, {Key? key}) : super(key: key);

  @override
  State<OfferItem> createState() => _OfferItemState();
}

class _OfferItemState extends State<OfferItem> {
  late OfferProvider offerProvider;

  @override
  Widget build(BuildContext context) {
    offerProvider = Provider.of(context);
    return Consumer<OfferProvider>(
      builder: (context, cart, child) {
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: AppColors.white),
              padding: EdgeInsets.only(
                  top: 12.h, bottom: 12.h, left: 8.w, right: 8.w),
              // margin: EdgeInsets.symmetric(vertical: 12),
              child: Column(
                children: [
                  Container(
                    color: AppColors.white,
                    padding: EdgeInsets.only(
                      top: 8.h,
                      bottom: 8.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 67.h,
                              width: 100.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: widget.product.image ?? '',
                                  placeholder: (context, url) => const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => SVGIcon(
                                    Assets.product,
                                    height: 70.h,
                                    width: 70.w,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    widget.product.title,
                                    style: TextStyles()
                                        .getTitleStyle(
                                          fontSize: 14.sp,
                                        )
                                        .customColor(AppColors.black),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                                SizedBox(
                                  height: 19.h,
                                ),
                                Row(
                                  children: [
                                    SVGIcon(
                                      Assets.price,
                                      height: 20.h,
                                      width: 22.w,
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                widget.product.price.toString(),
                                            style: TextStyles()
                                                .getTitleStyle(
                                                  fontSize: 18.sp,
                                                )
                                                .customColor(AppColors.black),
                                          ),
                                          TextSpan(
                                            text: LocaleKeys.sar.tr(),
                                            style: TextStyles()
                                                .getRegularStyle(
                                                  fontSize: 12.sp,
                                                )
                                                .customColor(AppColors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (widget.product.statusOrder == 'accepted')
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        LocaleKeys.acceptOffer.tr(),
                                        style: TextStyles()
                                            .getTitleStyle(
                                              fontSize: 10.sp,
                                            )
                                            .customColor(AppColors.green),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            LocaleKeys.payFrom.tr(),
                                            style: TextStyles()
                                                .getTitleStyle(
                                                  fontSize: 8.sp,
                                                )
                                                .customColor(AppColors.green),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              push(PayWebViewScreen(
                                                id: widget.product.orderID,
                                                link:
                                                    "https://checkout.tabby.ai/?sessionId=64a9a922-f489-4baa-a021-794a754d13ea&apiKey=pk_test_fa724f4b-c616-464d-82f9-4d0d18bbbabc&product=installments&merchantCode=Seuolasau",
                                              ));
                                            },
                                            child: Container(
                                              height: 30.h,
                                              width: 50.w,
                                              margin: EdgeInsets.all(4.r),
                                              padding: EdgeInsets.all(1.r),
                                              decoration: BoxDecoration(
                                                color: AppColors.grayLite,
                                                borderRadius:
                                                    BorderRadius.circular(8.h),
                                                border: Border.all(
                                                  width: 1.w,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              child: SVGIcon(
                                                Assets.imagesTaby,
                                                height: 40.h,
                                                width: 60.w,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              push(PayWebViewScreen(
                                                id: widget.product.orderID,
                                                link:
                                                    "https://sulah.sa/moyasar/",
                                              ));
                                            },
                                            child: Container(
                                              height: 30.h,
                                              width: 50.w,
                                              margin: EdgeInsets.all(4.r),
                                              padding: EdgeInsets.all(1.r),
                                              decoration: BoxDecoration(
                                                color: AppColors.grayLite,
                                                borderRadius:
                                                    BorderRadius.circular(8.h),
                                                border: Border.all(
                                                  width: 1.w,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              child: SVGIcon(
                                                Assets.imagesMada,
                                                height: 40.h,
                                                width: 60.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                        if (!widget.isOffer &&
                            widget.product.statusOrder != 'accepted')
                          IconButton(
                            onPressed: () {
                              offerDialog(
                                  context, offerProvider, widget.product);
                            },
                            icon: const Icon(Icons.add_circle,
                                color: AppColors.main),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
