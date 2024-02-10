import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/routing/route.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/resources.dart';
import '../../../../../data/model/response/products_Model.dart';
import '../../../../component/svg_icon.dart';
import '../add_product/widget/detailsCared.dart';
import '../products_view_model.dart';
import '../add_product/add_products.dart';

class EditBottomSheet extends StatefulWidget {
  const EditBottomSheet({Key? key, required this.oneProduct, required this.index}) : super(key: key);
  final OneProduct? oneProduct;
  // final String isShow;
  final int index;
  // final num productId;
  @override
  State<EditBottomSheet> createState() => _EditBottomSheetState();
}

class _EditBottomSheetState extends State<EditBottomSheet> {

  void _onDelete(context) async {
    await Provider.of<ProductsViewModel>(context, listen: false).deleteProduct(widget.oneProduct?.id ?? -1, context);
  }
  void _onSubmit(context)  {
    Provider.of<ProductsViewModel>(context,listen: false).showProducts(context, widget.oneProduct?.id??-1);
  }
  // bool eye = false;
  @override
  void initState() {
    super.initState();
    // bool eye = widget.oneProduct?.isAvailable ??false;
  }
  @override
  Widget build(BuildContext context) {
    bool isDeleteCatLoading = context.watch<ProductsViewModel>().isDeleteProductLoading;
    return Padding(
      padding:  EdgeInsets.all(16.r),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            DetailsCared(oneProduct: widget.oneProduct),
            SizedBox(height: 12.h,),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
            widget.oneProduct?.description??'',
            style: TextStyles()
                      .getRegularStyle(fontSize: 12.sp)
                      .customColor(AppColors.darkGray),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,textAlign: TextAlign.start,
                ),
              ],
            ),
            SizedBox(height: 12.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      SVGIcon(
                        Assets.price,
                        height: 20.h,
                        width: 20.w,
                        color: AppColors.main,
                      ),
                      Text(
                       ' ${widget.oneProduct?.price} '??'',
                        style: TextStyles()
                            .getTitleStyle(fontSize: 18.sp)
                            .customColor(AppColors.black),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'sar'.tr(),
                        style: TextStyles()
                            .getDescriptionStyle(fontSize: 14.sp)
                            .customColor(AppColors.black),
                      ),
                    ],
                  ),
                ),
                widget.oneProduct?.productsOffers != null ?
                Row(
                  children: [
                    SizedBox(width: 50.w,
                      child: Text(
                        "${ widget.oneProduct?.oldPrice}"'${LocaleKeys.sar.tr()}',
                        style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12.sp)
                            .customColor(AppColors.grayTextField),
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      height: 26.h,
                      // width: 71.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              LocaleKeys.discount.tr(),
                              style: TextStyles()
                                  .getDescriptionStyle(fontSize: 14.sp)
                                  .customColor(AppColors.white),
                            ),
                            Text(widget.oneProduct?.productsOffers?.type == "percentage" ? "${widget.oneProduct?.productsOffers?.value} % " : "${widget.oneProduct?.productsOffers?.value}${LocaleKeys.rial.tr()}"
                              ,overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyles()
                                  .getDescriptionStyle(fontSize: 14.sp)
                                  .customColor(AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ):const SizedBox()
              ],
            ),
           Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      _onDelete(context);
                    },
        
                    child:isDeleteCatLoading?SizedBox(
                      height: 56.h,
                      width: 110.w,
                      child: Center(
                        child: SizedBox(
                          height: 18.h,
                          width: 18.w,
                          child: const CircularProgressIndicator(color: AppColors.main,strokeWidth: 2.5,),
                        ),
                      ),
                    ):
                    SizedBox(
                      height: 56.h,
                      width: 110.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: .8.h,
                            width: 109.w,
                            color: AppColors.grayTextField,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 13, bottom: 13, right: 20, left: 20),
                            child: Row(
                              children: [
                                SVGIcon(
                                  Assets.delet,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  LocaleKeys.delete.tr(),
                                  style: TextStyles()
                                      .getRegularStyle(fontSize: 14.sp)
                                      .customColor(AppColors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      push(AddProducts(oneProducts: widget.oneProduct,isEdite: true,));
                    },
                    child: Container(
                      height: 56.h,
                      width: 109.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
        
                        children: [
                          Container(
                            height: .8.h,
                            width: 109.w,
                            color: AppColors.grayTextField,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 13, bottom: 13, right: 20, left: 20),
                            child: Row(
                              children: [
                                SVGIcon(
                                  Assets.editicon1,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  LocaleKeys.edit.tr(),
                                  style: TextStyles()
                                      .getRegularStyle(fontSize: 14.sp)
                                      .customColor(AppColors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                    _onSubmit(context);},
                    child: SizedBox(
                      height: 56.h,
                      width: 109.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: .8.h,
                            width: 109.w,
                            color: AppColors.grayTextField,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 13, bottom: 13, right: 20, left: 20),
                            child: Row(
                              children: <Widget> [
                                Icon(
                                  widget.oneProduct?.isShow == 0
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.visibility_off,
                                  color: AppColors.black,
                                  size:25.r,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text( widget.oneProduct?.isShow == 0
                                    ? "show".tr()
                                    : "hide".tr(),
                                  // LocaleKeys.hide.tr(),
                                  style: TextStyles()
                                      .getRegularStyle(fontSize: 14.sp)
                                      .customColor(AppColors.black),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
