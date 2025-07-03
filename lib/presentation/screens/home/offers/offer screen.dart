import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sulah_store/core/extensions/num_extensions.dart';
import 'package:sulah_store/presentation/screens/home/offers/widgets/offer%20item.dart';
import 'package:provider/provider.dart';
import '../../../../../core/res/text_styles.dart';
import '../../../../../core/resources/app_colors.dart';
import '../../../../../core/resources/locale_keys.g.dart';
import '../../../component/appbars/custom_app_bar.dart';
import '../../../component/custom_scaffold.dart';
import '../../../component/screen_state_layout.dart';
import '../../../component/spaces.dart';
import 'offer view model.dart';

class MyOffers extends StatefulWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  State<MyOffers> createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  late OfferProvider offerProvider;

  @override
  void initState() {
    Provider.of<OfferProvider>(context, listen: false).getOffers(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    offerProvider = Provider.of(context);
    return CustomScaffold(
      appBar: CustomAppBar(
        titleWidget: Text(
          LocaleKeys.offer.tr(),
          style: TextStyles()
              .getTitleStyle(fontSize: 18.sp)
              .customColor(AppColors.black),
        ),
        isBackButtonExist: true,
      ),
      body: Consumer<OfferProvider>(
        builder: (context, data, child) {
          return RefreshIndicator(
            onRefresh: () async => await offerProvider.getOffers(context),
            child: Column(
              children: [
                VerticalSpace(24.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 16.w, left: 16.w),
                    child: ScreenStateLayout(
                      isLoading: data.isLoading,
                      isEmpty: data.offers.isEmpty,
                      builder: (context) => ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.offers.length,
                        itemBuilder: (context, index) {
                          return RefreshIndicator(
                            onRefresh: () async =>
                                await data.getOffers(context),
                            child: Padding(
                              padding: EdgeInsets.only(top: 24.h),
                              child: OfferItem(data.offers[index], false),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
