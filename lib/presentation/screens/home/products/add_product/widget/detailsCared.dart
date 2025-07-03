import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/core/resources/locale_keys.g.dart';

import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../data/model/response/products_Model.dart';
import '../../../../../component/images/network_image.dart';
import 'inerDetailsCared.dart';

class DetailsCared extends StatelessWidget {
  const DetailsCared({super.key, this.oneProduct});

  final OneProduct? oneProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFF7F5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 96.h,
                width: 96.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CommonNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: oneProduct?.mainImage ?? '',
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 230.h,
                    child: Text(
                      oneProduct?.title ?? '',
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyles()
                          .getTitleStyle(
                            fontSize: 14.sp,
                          )
                          .customColor(AppColors.black),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'pieceNumber'.tr(),
                          style: TextStyles()
                              .getRegularStyle(
                                fontSize: 12.sp,
                              )
                              .customColor(AppColors.black),
                        ),
                        TextSpan(
                          text: ' ${oneProduct?.code ?? ''} ',
                          style: TextStyles()
                              .getRegularStyle(
                                fontSize: 12.sp,
                              )
                              .customColor(AppColors.main),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${LocaleKeys.made.tr()} :',
                          style: TextStyles()
                              .getRegularStyle(
                                fontSize: 12.sp,
                              )
                              .customColor(AppColors.black),
                        ),
                        TextSpan(
                          text:
                              ' ${oneProduct?.type == '0' ? LocaleKeys.original.tr() : LocaleKeys.copycat.tr()} ',
                          style: TextStyles()
                              .getTitleStyle(
                                fontSize: 14.sp,
                              )
                              .customColor(AppColors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            '${LocaleKeys.compatibleWith.tr()} ::',
            style: TextStyles()
                .getRegularStyle(
                  fontSize: 12.sp,
                )
                .customColor(AppColors.black),
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InerDetailsCared(
                      title: LocaleKeys.company.tr(),
                      color: AppColors.main20,
                    ),
                    InerDetailsCared(
                      title: LocaleKeys.car.tr(),
                      color: AppColors.main20,
                    ),
                    InerDetailsCared(
                      title: LocaleKeys.model.tr(),
                      color: AppColors.main20,
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: oneProduct?.productsAdditions?.length ?? 0,
                  itemBuilder: (_, index) => Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InerDetailsCared(
                        title: oneProduct
                                ?.productsAdditions?[index].brand?.title ??
                            '',
                        color: AppColors.white,
                      ),
                      InerDetailsCared(
                        title:
                            oneProduct?.productsAdditions?[index].car?.title ??
                                '',
                        color: AppColors.white,
                      ),
                      InerDetailsCared(
                        title: oneProduct
                                ?.productsAdditions?[index].manufactureYear ??
                            '',
                        color: AppColors.white,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
