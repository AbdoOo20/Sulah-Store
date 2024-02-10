import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_assets.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../../../data/model/response/best_seller_model.dart';
import '../../../../component/svg_icon.dart';

class ListOfBestSeller extends StatelessWidget {
  const ListOfBestSeller({Key? key, this.topSalesProduct}) : super(key: key);
final   List<TopSalesProduct>? topSalesProduct;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height:187.33.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount:topSalesProduct?.length,
          itemBuilder: (context, index) {
            return
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 173.33.h,
              width: 141.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color:AppColors.grayLite,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 8.h,
                    left: 12.w,
                    bottom: 8.h,
                    right: 12.w),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 83.33.h,
                      width:125 .w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: topSalesProduct?[index].mainImage??'',
                          placeholder: (context, url) =>
                          Center(child: SizedBox(height:20.h,width: 20.w,child: const CircularProgressIndicator(strokeWidth: 3))),
                          errorWidget:
                              (context, url, error) => SVGIcon(
                            Assets.logo,
                            height: 48.h,
                            width: 48.w,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      topSalesProduct?[index].title??'',
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles().getRegularStyle(fontSize: 12.sp).customColor(AppColors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          "${topSalesProduct?[index].salesCount??0}",
                          style: TextStyles().getTitleStyle(fontSize: 18.sp).customColor(AppColors.main),
                        ),
                        SizedBox(width: 4.w,),
                        Text(
                          LocaleKeys.order.tr(),
                          style: TextStyles().getRegularStyle(fontSize: 12.sp).customColor(AppColors.black),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          }),
    );
  }
}
