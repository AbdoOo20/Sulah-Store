import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:khedmaty_store/core/extensions/num_extensions.dart';
import '../../../../../../core/res/text_styles.dart';
import '../../../../../../core/resources/app_colors.dart';
import '../../../../../../core/resources/locale_keys.g.dart';
import '../../../../component/inputs/custom_text_field_normal.dart';
import '../offer view model.dart';

Future<void> offerDialog(BuildContext context, OfferProvider offerProvider,
    ProductOffer product) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          LocaleKeys.enterPriceTitle.tr(),
          style: TextStyles()
              .getRegularStyle(
            fontSize: 20.sp,
          )
              .customColor(AppColors.main),
        ),
        content: CustomTextFieldNormal(
          hint: LocaleKeys.enterPrice.tr(),
          textInputType: TextInputType.number,
          controller: offerProvider.priceController,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              LocaleKeys.cancel.tr(),
              style: TextStyles()
                  .getRegularStyle(
                fontSize: 14.sp,
              )
                  .customColor(AppColors.main),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              LocaleKeys.add.tr(),
              style: TextStyles()
                  .getRegularStyle(
                fontSize: 14.sp,
              )
                  .customColor(AppColors.main),
            ),
            onPressed: () {
              Navigator.pop(context);
              offerProvider.addOfferToOrder(
                  int.parse(offerProvider.priceController.text.trim()),
                  product.id, product.amount).then((value) async {
                await offerProvider.getOffers(context);
              });
            },
          ),
        ],
      );
    },
  );
}
